//
//  RealmSound.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 28.03.2022.
//

import Foundation
import RealmSwift

final class RealmSound: Object, ObjectKeyIdentifiable{
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var sound_name = ""
    @Persisted var sound_image = ""
    @Persisted var sound_filename = ""
    @Persisted var sound_category = ""
    @Persisted var is_sound_premium: Bool
    @Persisted var sound_volume: Double = 0.0
    
    @Persisted(originProperty: "sounds")var createdMix: LinkingObjects<CreatedMix>
    
    convenience init(sound_name: String, sound_image: String, sound_filename: String, sound_category: String, is_sound_premium: Bool, sound_volume: Double){
        self.init()
        self.sound_name = sound_name
        self.sound_image = sound_image
        self.sound_filename = sound_filename
        self.sound_category = sound_category
        self.is_sound_premium = is_sound_premium
        self.sound_volume = sound_volume
    }
    
    
    
    
}
