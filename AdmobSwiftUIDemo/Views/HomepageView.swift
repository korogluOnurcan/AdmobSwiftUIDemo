//
//  ContentView.swift
//  AdmobSwiftUIDemo
//
//  Created by onurcan köroğlu on 10.03.2024.
//

import SwiftUI
import GoogleMobileAds

struct HomepageView: View {
    
    @AppStorage("ChanceCount") private var chanceCount = 0
    
    @State private var showAlert: Bool = false
    @State private var showRewardAlert: Bool = false
    @State private var showRewardWarningAlert: Bool = false
    
    @State private var selection: String? = nil
    
    @State var rewardedInterstitialAd: GADRewardedInterstitialAd?
    
    var body: some View {
        
        ScrollView {
            VStack (spacing: UIScreen.main.bounds.height * 0.01) {
                
                NavigationLink(
                    destination: TestView(),
                    tag: "NavigateTestPage",
                    selection: $selection) { EmptyView() }
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: UIScreen.main.bounds.height * 0.08)
                    Text("Kalan Test Çözme Hakkınız : \(chanceCount)")
                        .foregroundStyle(Color.blue)
                        .bold()
                        .padding()
                }
                .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                .padding(.top, UIScreen.main.bounds.height * 0.01)
                
                Spacer()
                
                Button {
                    if (chanceCount > 0) {
                        showRewardWarningAlert.toggle()
                    } else {
                        showRewardAlert.toggle()
                    }
                    
                } label: {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: UIScreen.main.bounds.height * 0.21)
                        VStack (alignment: .leading, spacing: 12) {
                            Text("Ödüllü Reklam")
                                .foregroundStyle(Color.blue)
                                .bold()
                            HStack (spacing: 0) {
                                Image("rewarded_icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.30)
                                    .cornerRadius(16)
                                VStack (alignment: .leading, spacing: 12) {
                                    Text("Ödüllü reklamı test etmek için tıklayın.")
                                        .multilineTextAlignment(.leading)
                                        .foregroundStyle(Color.black)
                                        .bold()
                                        .padding(.horizontal, 12)
                                        .padding(.top,12)
                                    Spacer()
                                }
                                .frame(height: UIScreen.main.bounds.width * 0.25)
                            }
                        }
                        .padding()
                    }
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                    .padding(.top, UIScreen.main.bounds.height * 0.02)
                }
                
                Button {
                    if (chanceCount > 0) {
                        chanceCount -= 1
                        selection = "NavigateTestPage"
                    } else {
                        showAlert.toggle()
                    }
                } label: {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: UIScreen.main.bounds.height * 0.21)
                        VStack (alignment: .leading, spacing: 12) {
                            Text("Geçiş Reklamı")
                                .foregroundStyle(Color.blue)
                                .bold()
                            HStack (spacing: 0) {
                                Image("interstitial_icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.30)
                                    .cornerRadius(16)
                                VStack (alignment: .leading, spacing: 12) {
                                    Text("Örnek testi çözerek geçiş reklamını test edin.")
                                        .multilineTextAlignment(.leading)
                                        .foregroundStyle(Color.black)
                                        .bold()
                                        .padding(.horizontal, 12)
                                        .padding(.top,12)
                                    Spacer()
                                }
                                .frame(height: UIScreen.main.bounds.width * 0.25)
                            }
                        }
                        .padding()
                    }
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                }
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: UIScreen.main.bounds.height * 0.21)
                    VStack (alignment: .leading, spacing: 12) {
                        Text("Banner Reklamı")
                            .foregroundStyle(Color.blue)
                            .bold()
                        HStack (spacing: 0) {
                            Image("banner_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width * 0.30)
                                .cornerRadius(16)
                            VStack (alignment: .leading, spacing: 12) {
                                Text("Aşağıda görülen reklam banner test reklamıdır.")
                                    .multilineTextAlignment(.leading)
                                    .foregroundStyle(Color.black)
                                    .bold()
                                    .padding(.horizontal, 12)
                                    .padding(.top,12)
                                Spacer()
                            }
                            .frame(height: UIScreen.main.bounds.width * 0.25)
                        }
                    }
                    .padding()
                }
                .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                .padding(.bottom, UIScreen.main.bounds.height * 0.02)
                
            }
        }
        .alert(
            "Uyarı!",
            isPresented: $showRewardAlert
        ) {
            Button("İptal", role: .cancel) {}
            Button("Evet") {
                showRewardAd()
            }
        } message: {
            Text("Test çözme hakkı kazanmak için ödüllü reklamı izlemeniz gerekiyor. Devam etmek istiyor musunuz?")
        }
        .alert(
            "Uyarı!",
            isPresented: $showAlert
        ) {
            Button("Tamam", role: .cancel) {
                
            }
        } message: {
            Text("Test çözme hakkınız kalmamıştır. Ödüllü reklam izleyerek kazanabilirsiniz.")
        }
        .alert(
            "Uyarı!",
            isPresented: $showRewardWarningAlert
        ) {
            Button("İptal", role: .cancel) {}
            Button("Evet") {
                showRewardAd()
            }
        } message: {
            Text("Test çözme hakkınız bulunmaktadır. Yine de ödüllü reklam izlemek istiyor musunuz?")
        }
        .onAppear {
            loadRewardAd()
        }
        
    }
    
    private func loadRewardAd() {
        let request = GADRequest()
        GADRewardedInterstitialAd.load(
            withAdUnitID: rewardTestID,
            request: request, completionHandler: { (ad, error) in
                if let error = error {
                    print("Ödüllü reklam yüklenirken bir hata oluştu: \(error.localizedDescription) ")
                    return
                }
                self.rewardedInterstitialAd = ad
            }
        )
    }
    
    private func showRewardAd() {
        guard let rewardedInterstitialAd = rewardedInterstitialAd else {
            return print("Reklam hazır değil.")
        }
        let root = UIApplication.shared.windows.first?.rootViewController
        rewardedInterstitialAd.present(fromRootViewController: root!) {
            // Burada ödülü belirliyoruz
            // Bu uygulamadaki ödül +1 test hakkı
            chanceCount += 1
        }
    }
    
}

#Preview {
    HomepageView()
}
