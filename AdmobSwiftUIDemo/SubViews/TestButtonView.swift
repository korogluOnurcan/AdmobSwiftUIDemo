//
//  TestButtonView.swift
//  AdmobSwiftUIDemo
//
//  Created by onurcan köroğlu on 11.03.2024.
//


import SwiftUI

struct TestButtonView: View {
    
    let testPreviousButtonHandler: () -> ()
    let testNextButtonHandler: () -> ()
    
    var body: some View {
        HStack(spacing: 0) {
            
            Button {
                testPreviousButtonHandler()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: UIScreen.main.bounds.width * 0.425, height: UIScreen.main.bounds.width * 0.11)
                    
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .font(Font.title.weight(.semibold))
                        .frame(width: UIScreen.main.bounds.width * 0.032)
                        .foregroundColor(Color.gray)
                }
            }
            
            Spacer()
            
            Button {
                testNextButtonHandler()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: UIScreen.main.bounds.width * 0.425, height: UIScreen.main.bounds.width * 0.11)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .font(Font.title.weight(.semibold))
                        .frame(width: UIScreen.main.bounds.width * 0.032)
                        .foregroundColor(Color.gray)
                }
            }
        }
        .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
    }
}

#Preview {
    TestButtonView(
        testPreviousButtonHandler: {},
        testNextButtonHandler: {})
}
