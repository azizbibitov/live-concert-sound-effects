//
//  CreatedMixSwift.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 29.03.2022.
//

import Foundation

struct CreatedMixSwift: Identifiable, Equatable {
    var id: Int
    var mix_name: String
    var mix_image: String
    
    var songs: [Songs]
//    var sounds: [Sound]
}
