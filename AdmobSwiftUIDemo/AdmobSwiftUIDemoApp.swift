//
//  AdmobSwiftUIDemoApp.swift
//  AdmobSwiftUIDemo
//
//  Created by onurcan köroğlu on 10.03.2024.
//
import SwiftUI
import Firebase
import GoogleMobileAds

@main
struct AdmobSwiftUIDemoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            VStack (spacing: 0) {
                NavigationView {
                    HomepageView()
                }
                BannerView()
            }
        }
    }
    
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }
}
