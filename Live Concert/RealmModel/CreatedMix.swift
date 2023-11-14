//
//  CreatedMix.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 23.03.2022.
//

import Foundation
import RealmSwift

class CreatedMix: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var mix_name = ""
    @Persisted var image = ""
    
    @Persisted var songs = RealmSwift.List<RealmSong>()
    @Persisted var sounds = RealmSwift.List<RealmSound>()
}
