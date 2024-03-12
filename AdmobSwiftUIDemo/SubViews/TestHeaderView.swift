//
//  TestHeaderView.swift
//  AdmobSwiftUIDemo
//
//  Created by onurcan köroğlu on 11.03.2024.
//

import SwiftUI

struct TestHeaderView: View {
    
    let headerTestTitle: String
    let headerCorrectAnswerCount: Int
    let headerWrongAnswerCount: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 30)
            HStack(alignment: .center, spacing: 0) {
                Image("rounded_passed")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18)
                Text(String(headerCorrectAnswerCount))
                    .font(.subheadline).bold()
                    .foregroundColor(Color.green)
                    .padding(.leading, 6)
                    .padding(.top, 1)
                Spacer()
                Text(String(headerWrongAnswerCount))
                    .font(.subheadline).bold()
                    .foregroundColor(Color.red)
                    .padding(.trailing, 6)
                    .padding(.top, 1)
                Image("rounded_failed")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18)
            }
            .overlay(
                Text(headerTestTitle)
                    .font(.subheadline).bold()
                    .foregroundColor(Color.gray)
                    .padding(.top, 1)
            )
            .padding(.horizontal, UIScreen.main.bounds.width * 0.03)
        }
        .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
    }
}

#Preview {
    TestHeaderView(
        headerTestTitle: "1/10",
        headerCorrectAnswerCount: 6,
        headerWrongAnswerCount: 4)
}
