//
//  TestOptionView.swift
//  AdmobSwiftUIDemo
//
//  Created by onurcan köroğlu on 11.03.2024.
//

import SwiftUI

import SwiftUI

struct TestOptionView: View {
    
    let optionText: String
    let optionRoundedIcon: String
    let optionBackgroundColor: Color
    let optionTextColor: Color
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(optionRoundedIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28)
                Text(optionText)
                    .font(.headline)
                    .foregroundColor(optionTextColor)
                    .padding(.leading, 12)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .frame(
                minWidth: UIScreen.main.bounds.width * 0.9,
                idealWidth: UIScreen.main.bounds.width * 0.9,
                maxWidth: .none,
                minHeight: 50,
                idealHeight: .none,
                maxHeight: .none)
            .background(optionBackgroundColor)
            .addBorder(Color.gray.opacity(0.2), width: optionBackgroundColor == Color.white ? 2 : 0, cornerRadius: 20)

        }
    }
}

#Preview {
    TestOptionView(
        optionText: "25",
        optionRoundedIcon: "rounded_empty",
        optionBackgroundColor: Color.green.opacity(0.5),
        optionTextColor: Color.black
    )
}
