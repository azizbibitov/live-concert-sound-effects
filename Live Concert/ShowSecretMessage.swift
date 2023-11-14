//
//  ShowSecretMessage.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 22.06.2022.
//

import Foundation
import SwiftUI


class ShowSecretMessage: ObservableObject{
    
    @Published var shouldShowSecretMessage = false
    
    @Published var clickCountToTriggerSecretMessage = 1
    
    func clickTrigger(){
        if clickCountToTriggerSecretMessage < 10{
            
            clickCountToTriggerSecretMessage += 1
        }else{
            clickCountToTriggerSecretMessage = 1
        }
        
    }
   //time>=15 &&
    func determizer(){
        
        if clickCountToTriggerSecretMessage==1{
            shouldShowSecretMessage = true
        }else{
            shouldShowSecretMessage = false
        }
    }
    
}
