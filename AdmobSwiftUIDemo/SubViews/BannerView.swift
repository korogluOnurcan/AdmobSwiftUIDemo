//
//  BannerView.swift
//  AdmobSwiftUIDemo
//
//  Created by onurcan köroğlu on 11.03.2024.
//

import SwiftUI
import GoogleMobileAds

struct BannerVC: UIViewControllerRepresentable  {
        
    func makeUIViewController(context: Context) -> UIViewController {
        
        let view = GADBannerView(adSize: GADAdSizeBanner)
        let viewController = UIViewController()
        
        view.adUnitID = bannerID
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: GADAdSizeBanner.size)
        view.load(GADRequest())

        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct BannerView: View {
    var body: some View {
        VStack (spacing: 0) {
            Rectangle()
                .fill(Color.gray.opacity(0.25))
                .frame(height: 1)
                .padding(.bottom, 14)
            HStack {
                Spacer()
                BannerVC().frame(width: 320, height: 50, alignment: .center)
                Spacer()
            }
        }
    }
}
