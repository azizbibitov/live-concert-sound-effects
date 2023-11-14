//
//  Song.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 04.03.2022.
//

import Foundation
import RealmSwift

struct Songs: Identifiable, Equatable,  Hashable{
    let id: Int
    let album_name: String
    let song_name: String
    let song_filename: String
    let artist: String
    let audio_from_internal_storage: Bool
}
