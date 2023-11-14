//
//  RealmManager.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 23.03.2022.
//

import Foundation
import RealmSwift
import SwiftUI

class RealmManager: ObservableObject{
    private(set) var localRealm: Realm?
    @Published private(set) var created_mixes: [CreatedMix] = []
    
    init(){
        openRealm()
        getCreatedMixes()
    }
    
    func openRealm(){
        do{
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm()
        }catch{
            print("Errot opening Realm: \(error)")
        }
    }
    
    func createDefaultMix()-> ObjectId{
        var id = ObjectId()
        if let localRealm = localRealm {
            do{
                try localRealm.write({
                    let newMix = CreatedMix(value: ["mix_name": "", "image": "heal your soul with music"])
                    id = newMix.id
                    localRealm.add(newMix)
                    getCreatedMixes()
                    print("Added new default mix to Realm: \(newMix)")
                })
                
            }catch{
                print("Error creating mix\(error)")
            }
        }
        
        return id
    }
    
    func addSongToMix(mixID: ObjectId, song_name: String, song_filename: String, artist: String, audio_from_internal_storage: Bool){
        if let localRealm = localRealm {
            do{
                let defaultMix = localRealm.objects(CreatedMix.self).filter(NSPredicate(format: "id == %@", mixID))
                guard !defaultMix.isEmpty else {return}
                
                try localRealm.write({
                    defaultMix[0].songs.append(RealmSong(value: ["song_name": song_name, "song_filename": song_filename, "artist": artist, "audio_from": audio_from_internal_storage]))
                    getCreatedMixes()
                    //print("Songs added to default mix: \(defaultMix[0].songs)")
                })
                
            }catch{
                print("Error adding songs to default mix\(error)")
            }
        }
    }
    
    func deleteSongFromMix(mixID: ObjectId, song_position: Int){
        if let localRealm = localRealm {
            do{
                let mix = localRealm.objects(CreatedMix.self).filter(NSPredicate(format: "id == %@", mixID))
                guard !mix.isEmpty else {return}
                
                let songToDelete = mix[0].songs[song_position]
                
                
                try localRealm.write({
                    print("Deleted song with name: \(mix[0].songs[song_position].song_name) of mix \(mix[0].mix_name)")
                    localRealm.delete(songToDelete)
                    getCreatedMixes()
                })
                
            }catch{
                print("Error adding songs to default mix\(error)")
            }
        }
    }
    
    func deleteAllSoundsOfMix(mixID: ObjectId){
        if let localRealm = localRealm {
            do{
                let mix = localRealm.objects(CreatedMix.self).filter(NSPredicate(format: "id == %@", mixID))
                guard !mix.isEmpty else {return}
                
                if mix[0].sounds.count != 0{
                    for _ in 0...mix[0].sounds.count-1{
                        try localRealm.write({
                            let soundToDelete = mix[0].sounds[0]
                            localRealm.delete(soundToDelete)
                            print("Sound deleted: \(soundToDelete.sound_name)")
                            getCreatedMixes()
                        })
                    }
                }
                

                
            }catch{
                print("Error deleting all sounds of mix: \(error)")
            }
        }
    }
    
    func replaceSoundsInMix(mixID: ObjectId, newSounds: RealmSwift.List<RealmSound>){
        if let localRealm = localRealm {
            do{
                let mix = localRealm.objects(CreatedMix.self).filter(NSPredicate(format: "id == %@", mixID))
                guard !mix.isEmpty else {return}
                
                //if mix[0].sounds.count != 0{
                    
                   // for _ in 0...mix[0].sounds.count-1{
                        try localRealm.write({
                            mix[0].sounds = newSounds
                            print("Replaced sounds of mix: \(mix[0].mix_name)")
                            getCreatedMixes()
                        })
                   // }
             //   }
                

                
            }catch{
                print("Error replacing sounds of mix: \(error)")
            }
        }
    }
    
    
    func replaceSongsinMix(mixID: ObjectId, newSongs: RealmSwift.List<RealmSong>){
        if let localRealm = localRealm {
            do{
                let mix = localRealm.objects(CreatedMix.self).filter(NSPredicate(format: "id == %@", mixID))
                guard !mix.isEmpty else {return}
                
                try localRealm.write({
                    mix[0].songs = newSongs
                    print("Replaced songs of mix: \(mix[0].mix_name)")
                    getCreatedMixes()
                })
                
                
            }catch{
                print("Error replacing sounds of mix: \(error)")
            }
        }
    }
    
    func deleteAllSongsOfMix(mixID: ObjectId){
        if let localRealm = localRealm {
            do{
                let mix = localRealm.objects(CreatedMix.self).filter(NSPredicate(format: "id == %@", mixID))
                guard !mix.isEmpty else {return}
                
                
                for _ in 0...mix[0].songs.count-1{
                    try localRealm.write({
                        let songToDelete = mix[0].songs[0]
                        localRealm.delete(songToDelete)
                        getCreatedMixes()
                    })
                }
                

                
            }catch{
                print("Error deleting all song of mix: \(error)")
            }
        }
    }
    

    
    func addSoundToMix(mixID: ObjectId, sound_name: String, sound_image: String, sound_filename: String, sound_category: String, sound_volume: Float){
        if let localRealm = localRealm {
            do{
                let mix = localRealm.objects(CreatedMix.self).filter(NSPredicate(format: "id == %@", mixID))
                guard !mix.isEmpty else {return}
                
                try localRealm.write({
                    mix[0].sounds.insert(RealmSound(value: ["sound_name": sound_name, "sound_image": sound_image, "sound_filename": sound_filename, "sound_category": sound_category, "sound_volume": sound_volume]), at: 0)
                    getCreatedMixes()
                    print("Sounds added to mix\(mix[0].sounds)")
                })
            }catch{
                print("Error adding sounds to mix: \(error)")
            }
        }
    }
    
    
    
    func setMixNameAndImage(defaultMixID: ObjectId, mix_name: String, mix_cover: String){
        if let localRealm = localRealm {
            do{
                let creatingMix = localRealm.objects(CreatedMix.self).filter(NSPredicate(format: "id == %@", defaultMixID))
                guard !creatingMix.isEmpty else {return}
                
                try localRealm.write({
                    creatingMix[0].mix_name = mix_name
                    creatingMix[0].image = mix_cover
                    getCreatedMixes()
                    print("Changed mix name in Realm: \(creatingMix[0])")
                })
            }catch{
                print("Error setting name and image to mix: \(error)")
            }
        }
    }
    
    func createMix(mixName: String, mixImage: String){
        if let localRealm = localRealm {
            do{
                try localRealm.write({
                    let newMix = CreatedMix(value: ["mix_name": mixName, "image": mixImage])
                    localRealm.add(newMix)
                    getCreatedMixes()
                    print("Added new mix to Realm: \(newMix)")
                })
                
            }catch{
                print("Error adding mix\(error)")
            }
        }
    }
    
    func getCreatedMixes(){
        if let localRealm = localRealm {
            let allCreatedMixes = localRealm.objects(CreatedMix.self)
            created_mixes = []
            allCreatedMixes.forEach { createdMix in
                created_mixes.append(createdMix)
            }
            created_mixes.reverse()
        }
    }
    
    func deleteCreatedMix(id: ObjectId){
        if let localRealm = localRealm {
            do{
                let mixToDelete = localRealm.objects(CreatedMix.self).filter(NSPredicate(format: "id == %@", id))
                guard !mixToDelete.isEmpty else {return}
                
                try localRealm.write({
                    localRealm.delete(mixToDelete)
                    getCreatedMixes()
                    print("Deleted mix with id \(id)")
                })
                
            }catch{
                print("Error deleting mix \(id) from Realm: \(error)")
            }
        }
    }
}
