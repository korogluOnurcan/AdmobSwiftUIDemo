//
//  TestModel.swift
//  AdmobSwiftUIDemo
//
//  Created by onurcan köroğlu on 11.03.2024.
//

import Foundation

struct TestModel: Identifiable, Codable  {
    var uuid = UUID()
    let id: Int
    let questionImage: String
    let optionA: String
    let optionB: String
    let answer: String
}
