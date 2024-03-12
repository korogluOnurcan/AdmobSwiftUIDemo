//
//  TestResultView.swift
//  AdmobSwiftUIDemo
//
//  Created by onurcan köroğlu on 11.03.2024.
//

import SwiftUI

struct TestResultView: View {
    
    let correctAnswerCount: Int
    let wrongAnswerCount: Int
    let totalAnswerCount: Int
        
    var body: some View {
        
        HStack(spacing: 0) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.green.opacity(0.15))
                    .frame(width: UIScreen.main.bounds.width * 0.21, height: UIScreen.main.bounds.width * 0.44)
                VStack(spacing: 10) {
                    Image("rounded_passed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.08)
                    Text("Doğru")
                        .font(.subheadline)
                        .foregroundColor(Color.green)
                    Text(String(correctAnswerCount))
                        .font(.headline)
                        .foregroundColor(Color.green)
                }
            }
            
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 16.0)
                    .foregroundColor(Color.gray.opacity(0.2))
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(Float(correctAnswerCount) / Float(totalAnswerCount), 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 16.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.green.opacity(0.7))
                    .rotationEffect(.degrees(270))
                
                Text("%" + String(format: "%.f%", min(Float(correctAnswerCount) / Float(totalAnswerCount), 1.0) * 100.0))
                    .font(.title2)
                    .foregroundColor(Color.green)
            }.padding(.horizontal, UIScreen.main.bounds.width * 0.02 + 8)
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.red.opacity(0.15))
                    .frame(width: UIScreen.main.bounds.width * 0.21, height: UIScreen.main.bounds.width * 0.44)
                VStack(spacing: 10) {
                    Image("rounded_failed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.08)
                    Text("Yanlış")
                        .font(.subheadline)
                        .foregroundColor(Color.red)
                    Text(String(self.wrongAnswerCount))
                        .font(.headline)
                        .foregroundColor(Color.red)
                }
            }
        }
        .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
    }
}

#Preview {
    TestResultView(
        correctAnswerCount: 7,
        wrongAnswerCount: 3,
        totalAnswerCount: 10
    )
}
