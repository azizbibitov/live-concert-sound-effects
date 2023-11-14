//
//  ShouldShowAd.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 08.04.2022.
//

import Foundation
import SwiftUI


class ShouldShowAd: ObservableObject{
    @Published var shouldShowAd = false
    
    @Published var clickCountToTriggerAd = 1
    
    @Published var time = 10
    
    func clickTrigger(){
        if clickCountToTriggerAd < 2{
            
            clickCountToTriggerAd += 1
        }else{
            clickCountToTriggerAd = 1
        }
        
    }
   //time>=15 &&
    func determizer(){
        if clickCountToTriggerAd==1{
            shouldShowAd = true
        }else{
            shouldShowAd = false
        }
    }
    
}
