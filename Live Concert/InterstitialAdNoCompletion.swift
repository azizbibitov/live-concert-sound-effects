//
//  InterstitialAdNoCompletion.swift
//  Live Concert
//
//  Created by Aziz Bibitov on 01.07.2022.
//

import Foundation
import GoogleMobileAds
import UIKit

final class InterstitialAdNoCompletion:  GADInterstitialAd, GADFullScreenContentDelegate {
    var completion: () -> Void
    var interstitial: GADInterstitialAd?
    var loaded: Bool = false
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
        super.init()
        
        LoadInterstitialAd()
    }
    //ca-app-pub-3940256099942544/1033173712   test
    //ca-app-pub-6455092018142201/8172422308   accaunt
    
    //let testId = "ca-app-pub-3940256099942544/1033173712"
    
    func LoadInterstitialAd() {
        let req = GADRequest()
//        let realId = "ca-app-pub-6455092018142201/8172422308"
//        GADInterstitialAd.load(withAdUnitID: realId, request: req) { ad, error in
            
        let testId = "ca-app-pub-3940256099942544/1033173712"
        GADInterstitialAd.load(withAdUnitID: testId, request: req) { ad, error in
            print("Loaded")
            self.interstitial = ad
            if self.interstitial != nil {
                self.loaded = true
            }
            self.interstitial?.fullScreenContentDelegate = self
        }
        
    }
    
    func show() {
        print("Show Ad")
        if self.interstitial != nil {
            print("Ad not nil")
            let root = UIApplication.shared.windows.first?.rootViewController
            self.interstitial?.present(fromRootViewController: root!)
        }
    }
    
//    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
//        failed = true
//    }
    
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.popoppopopopopopoppopopopopo")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        LoadInterstitialAd()
        completion()
        print("Ad did dismiss full screen content.opopoppopopopopopoppopopopopop")
    }
    
    
}
