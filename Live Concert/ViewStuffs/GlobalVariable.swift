//
//  GlobalVariable.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 11.03.2022.
//

import Foundation
import AVKit

class GlobalVariable: ObservableObject {
    @Published var stringy = ""
    @Published var temperature = 0.0
    
    @Published var player: AVAudioPlayer!
    @Published var current: Int = 0
    
}
