//
//  Sound.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 16.03.2022.
//

import Foundation

struct Sound: Identifiable, Equatable{
    let id: Int
    let sound_name: String
    let sound_image: String
    let sound_filename: String
    let sound_volume: Double
    let sound_category: String
    let is_sound_premium: Bool
}
