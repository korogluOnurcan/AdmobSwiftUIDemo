//
//  Constants.swift
//  AdmobSwiftUIDemo
//
//  Created by onurcan köroğlu on 11.03.2024.
//

import Foundation

let isStoreCode = false

let appTestID = "ca-app-pub-3940256099942544~1458002511"

let bannerAdTestID = "ca-app-pub-3940256099942544/2934735716"
let interstitialAdTestID = "ca-app-pub-3940256099942544/4411468910"
let rewardAdTestID = "ca-app-pub-3940256099942544/5354046379"

let bannerAdID = ""
let interstitialAdID = ""
let rewardTestAdID = ""

let bannerID = isStoreCode ? bannerAdID : bannerAdTestID
let interstitialID = isStoreCode ? interstitialAdID : interstitialAdTestID
let rewardTestID = isStoreCode ? rewardTestAdID : rewardAdTestID
