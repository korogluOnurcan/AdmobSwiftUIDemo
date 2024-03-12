//
//  TestView.swift
//  AdmobSwiftUIDemo
//
//  Created by onurcan köroğlu on 11.03.2024.
//

import SwiftUI
import GoogleMobileAds

struct TestView: View {
        
    @State var blankAnswerCount: Int = 0
    @State var wrongAnswerCount: Int = 0
    @State var correctAnswerCount: Int = 0
    @State var currentQuestionIndex: Int = 0
    
    @State private var isTestFinished: Bool = false
    
    @State private var selectedOption = Array(repeating: "notAnswered", count: 10)
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var interstitialAd: GADInterstitialAd?
    
    
    var body: some View {
        
        if (currentQuestionIndex < colorBlindnessTestData.count) {
            
            VStack (spacing: 0) {
                
                ToolbarView(title: "Renk Testi")
                
                TestHeaderView(
                    headerTestTitle: "\(currentQuestionIndex + 1)/10",
                    headerCorrectAnswerCount: correctAnswerCount,
                    headerWrongAnswerCount: wrongAnswerCount)
                .padding(.top, UIScreen.main.bounds.height * 0.02)
                
                ScrollView {
                    
                    Image(colorBlindnessTestData[currentQuestionIndex].questionImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: UIScreen.main.bounds.height * 0.3)
                        .padding(.top, UIScreen.main.bounds.height * 0.02)
                    
                    Text("Yukarıdaki resimde hangi sayıyı görüyorsunuz?")
                        .font(.subheadline)
                        .padding(.top, UIScreen.main.bounds.height * 0.04)
                    
                    VStack (spacing: UIScreen.main.bounds.height * 0.01) {
                        Button {
                            optionClicked(clickedOption: "A")
                        } label: {
                            TestOptionView(
                                optionText: colorBlindnessTestData[currentQuestionIndex].optionA,
                                optionRoundedIcon: changeOptionAppearance(option: "A").2,
                                optionBackgroundColor: changeOptionAppearance(option: "A").0,
                                optionTextColor: changeOptionAppearance(option: "A").1
                            )
                        }
                        
                        Button {
                            optionClicked(clickedOption: "B")
                        } label: {
                            TestOptionView(
                                optionText: colorBlindnessTestData[currentQuestionIndex].optionB,
                                optionRoundedIcon: changeOptionAppearance(option: "B").2,
                                optionBackgroundColor: changeOptionAppearance(option: "B").0,
                                optionTextColor: changeOptionAppearance(option: "B").1
                            )
                        }
                    }
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                    .padding(.top, UIScreen.main.bounds.height * 0.02)
                    
                }
                
                TestButtonView(
                    testPreviousButtonHandler: previosButtonHandler,
                    testNextButtonHandler: nextButtonHandler)
                .padding(.bottom, UIScreen.main.bounds.height * 0.02)
                
            }
            .navigationBarHidden(true)
            
        } else {
            
            VStack (spacing: 0) {
                
                ToolbarView(title: "Test Sonuçları")
                
                VStack (spacing: 0) {
                    TestResultView(
                        correctAnswerCount: self.correctAnswerCount,
                        wrongAnswerCount: self.wrongAnswerCount,
                        totalAnswerCount: colorBlindnessTestData.count)
                    .padding(.top, UIScreen.main.bounds.height * 0.03)
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: UIScreen.main.bounds.width * 0.32)
                        Text("Bu uygulama sadece kodlama eğitimi amaçlıdır ve renk körlüğü testi olarak kabul edilmemelidir. Kesin sonuçlar için lütfen bir sağlık uzmanına danışın.")
                            .padding(UIScreen.main.bounds.width * 0.05)
                    }
                    .padding(.top, UIScreen.main.bounds.height * 0.05)
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                    
                    Spacer()
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.blue)
                                .frame(width: UIScreen.main.bounds.width * 0.90,
                                       height: UIScreen.main.bounds.height * 0.06)
                            Text("Anasayfa")
                                .font(.title3)
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding(.bottom, UIScreen.main.bounds.height * 0.01)
                    
                }
            }
            .navigationBarHidden(true)
        }
        
    }
    
    
    func changeOptionAppearance(option: String) -> (Color, Color, String) {
        let answer = colorBlindnessTestData[currentQuestionIndex].answer
        let selectedOption = selectedOption[currentQuestionIndex]
        if (answer == option && selectedOption == option) {
            return (Color.green.opacity(0.5), Color.white, "rounded_correct")
        } else if (answer != option && selectedOption == option) {
            return (Color.red.opacity(0.5), Color.white, "rounded_wrong")
        } else if((selectedOption != "notAnswered" && selectedOption != "blank") && answer == option) {
            return (Color.green.opacity(0.5), Color.white, "rounded_correct")
        } else {
            return (Color.white, Color.black, "rounded_empty")
        }
    }
    
    func optionClicked(clickedOption: String) {
        
        if(selectedOption[currentQuestionIndex] == "notAnswered" || selectedOption[currentQuestionIndex] == "blank") {
            
            selectedOption[currentQuestionIndex] = clickedOption
            
            if (!isTestFinished) {
                
                if(selectedOption[currentQuestionIndex] == colorBlindnessTestData[currentQuestionIndex].answer) {
                    correctOptionClicked()
                } else {
                    wrongOptionClicked()
                }
            }
        }
    }
    
    private func correctOptionClicked() {
        correctAnswerCount += 1
    }
    
    private func wrongOptionClicked() {
        wrongAnswerCount += 1
    }
    
    private func previosButtonHandler() {
        if (currentQuestionIndex != 0) {
            currentQuestionIndex -= 1
        }
    }
    
    private func nextButtonHandler() {
        if(selectedOption[currentQuestionIndex] == "notAnswered") {
            selectedOption[currentQuestionIndex] = "blank"
            blankAnswerCount += 1
        }
        if (currentQuestionIndex != colorBlindnessTestData.count) {
            currentQuestionIndex += 1
        }
        showAndLoadAdProcess()
    }
    
    private func showAndLoadAdProcess() {
        // Reklamı 3. soruda yüklüyoruz
        if(currentQuestionIndex == 2) {
            loadInterstitialAd()
        }
        
        // 6. soruda gösteriyoruz
        if (currentQuestionIndex % 10 == 5) {
            showInterstitialAd()
        }
    }
    
    private func loadInterstitialAd() {
        let request = GADRequest()
        GADInterstitialAd.load(
            withAdUnitID: interstitialID,
            request: request,
            completionHandler: {
                [self] ad, error in if let error = error
                {
                    print("Geçiş reklamı yüklenmedi, hata kodu: \(error.localizedDescription)")
                    return
                }
                self.interstitialAd = ad
            }
        )
    }
    
    private func showInterstitialAd() {
        let root = UIApplication.shared.windows.first?.rootViewController
        if interstitialAd != nil {
            self.interstitialAd?.present(fromRootViewController: root!)
            interstitialAd = nil
        } else {
            print("Reklam yüklenmemiş.")
        }
    }
    
}

#Preview {
    TestView()
}
