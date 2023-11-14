//
//  NativeViewController2.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 11.04.2022.
//

import Foundation
import GoogleMobileAds
import UIKit
import SwiftUI


class NativeViewController2: NSObject, GADNativeAdLoaderDelegate, ObservableObject{
   @State var adStatusString: Int = 2
   var adLoader: GADAdLoader?
   var nativeAd: GADNativeAd?
    @Binding var vari: Int
    
    init(vari: Binding<Int>){
        _vari = vari
    }
   
   
   func loadAd(){
       self.vari = 2
       let options = GADNativeAdMediaAdLoaderOptions()
       options.mediaAspectRatio = .square
       
       let root = UIApplication.shared.windows.first?.rootViewController
//       let realId = "ca-app-pub-6455092018142201/3331159169"
//       adLoader = GADAdLoader(adUnitID: realId, rootViewController: root!, adTypes: [GADAdLoaderAdType.native], options: [options])
      
       let testId = "ca-app-pub-3940256099942544/3986624511"
       adLoader = GADAdLoader(adUnitID: testId, rootViewController: root!, adTypes: [GADAdLoaderAdType.native], options: [options])
      
       //ca-app-pub-6455092018142201/3331159169   accaun
       //ca-app-pub-3940256099942544/3986624511   test
   
       adLoader?.delegate = self
       adLoader?.load(GADRequest())
       print("popopopopopopopoppopopopopopopopopopopoopopopAziz")
   }
   
   func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
       self.nativeAd = nativeAd
       self.adStatusString = 1
       self.vari = 1
       print("popoppopopopoAzik\(adStatusString)")
   }
   
   func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
       self.vari = 0
   }
   
   func nativeAds() -> GADNativeAd? {
       self.nativeAd
   }
}
