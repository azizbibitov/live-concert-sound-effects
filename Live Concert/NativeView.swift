//
//  NativeView.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 11.04.2022.
//

import SwiftUI

//struct NativeView: View {
    
//    var nativeViewController = NativeViewController2()
//    @State var adStatusVar: Int = 2
//
//    var body: some View {
//        VStack {
//            if adStatusVar == 1 {
//                if let nativeAd = nativeViewController.nativeAds() {
//                    NativeAdView(nativeAd: nativeAd)
//                        .frame(maxWidth: 375)
//                }
//            }
//            else {
//                ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
//                    .progressViewStyle(CircularProgressViewStyle())
//
//                Text("Loading ad\(nativeViewController.adStatusString)")
//                    .foregroundColor(.secondary)
//                    .onTapGesture {
//                        //nativeViewController.adStatusString = 1
//                        adStatusVar = 1
//                        print(nativeViewController.adStatusString)
//                    }
//            }
//        }
//        .onAppear {
//
//            nativeViewController.loadAd()
//            //adStatusVar =
//        }
////        .onReceive(self.nativeViewController.$adStatusString) { newValue in
////            self.adStatusVar = newValue
////        }
////        .onChange(of: nativeViewController.adStatusString) { newValue in
////            adStatusVar = newValue
////            print("AdStatusVar: \(adStatusVar)")
////        }
//    }
//}
