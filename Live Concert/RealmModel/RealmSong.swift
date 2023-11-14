//
//  RealmSong.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 28.03.2022.
//

import Foundation
import RealmSwift

final class RealmSong: Object, ObjectKeyIdentifiable{
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var song_name = ""
    @Persisted var song_filename = ""
    @Persisted var artist = ""
    @Persisted var audio_from_internal_storage: Bool
    
    @Persisted(originProperty: "songs")var createdMix: LinkingObjects<CreatedMix>
    
    convenience init(song_name: String, song_filename: String, artist: String, audio_from_internal_storage: Bool){
        self.init()
        self.song_name = song_name
        self.song_filename = song_filename
        self.artist = artist
        self.audio_from_internal_storage = audio_from_internal_storage
    }
    
    
}
