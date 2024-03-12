//
//  ToolbarView.swift
//  AdmobSwiftUIDemo
//
//  Created by onurcan köroğlu on 11.03.2024.
//

import SwiftUI

struct ToolbarView: View {
    
    let title: String
    var isBackButtonVisible: Bool = true
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack (spacing: 0) {
            HStack {
                if (isBackButtonVisible) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: UIScreen.main.bounds.height * 0.06)
                            
                            Image(systemName: "chevron.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12)
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                
                Spacer()
                
                Text(title)
                    .font(.title).bold()
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(2)
                    .padding(.leading, 8)
                
            }
            .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
            .padding(.top, UIScreen.main.bounds.height * 0.01)
            .padding(.bottom, UIScreen.main.bounds.height * 0.015)
            
            Rectangle()
                .fill(Color.gray.opacity(0.25))
                .frame(height: 1)
        }

    }
    
}


#Preview {
    ToolbarView(title: "Başlık", isBackButtonVisible: false)
}
