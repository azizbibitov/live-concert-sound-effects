//
//  Album.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 23.02.2022.
//

import Foundation

struct Album: Identifiable {
    let id: Int
    let title: String
    let count: String
    let image: String
    let premium: Bool
    let artist: String
}
