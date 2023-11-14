//
//  GridView.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 23.02.2022.
//

import Foundation
import SwiftUI
import AVKit
import GoogleMobileAds
import MediaPlayer

struct GridView: View {
    @State private var adStatusVar = [2, 2]
    @State private var adStatusVarOne: Int = 2
    @State var nativeViewControllers: [NativeViewController2] = []
    
    @EnvironmentObject var store: Store
    @Binding public var player: AVAudioPlayer!
    @Binding public var height: CGFloat
    var album_data: [Album]
    @Binding public var open: Bool
    @Binding public var closed: Bool
    @Binding public var album_name: String
    @Binding public var album_own_songs: [Songs]
    @Binding public var current: Int
    @Binding public var album_cover: String
    @Binding public var player_called_from: String
    @Binding var sound_names: [String]
    @Binding var initial_volume: [CGFloat]
    @Binding var initial_sounds_array: [Sound]
    @Binding public var sounds_playing_audios: [AVAudioPlayer]
    @Binding public var apps_music_bool: Bool
    @Binding var initial_volumeValues: [Double]
    @State var gridVievs: [Int] = []
    private let audioSession = AVAudioSession.sharedInstance()
    @Binding var isPurchased: Bool
    @Binding var isMonthlySubscribed: Bool
    @Binding var isWeeklySubscribed: Bool
    @Binding var showIAPsView: Bool
    @Binding var songVolumeLineValue: Float
    @Binding var isShuffle: Bool
    
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
    let data = AlbumData()
    let soundsData = SoundsData()
    
    
    var body: some View {
        LazyVGrid(columns: columns) {
            
            
            if adStatusVar[0] == 1 && adStatusVar[1] == 1 && !(isPurchased || isWeeklySubscribed || isMonthlySubscribed){
                
                
                ForEach(0..<self.album_data.count+2, id: \.self) { index in
                    
                    let changedIndex = indexDeterminer(index: index)
                    let adIndex = adIndexDeterminer(index: index)
                    
                    
                    
                    if index == 1 || index == 9{
                        
                        //Text("Ad")
                        VStack {
                            if adStatusVar[adIndex] == 1 {
                                if let nativeAd = nativeViewControllers[adIndex].nativeAds() {
                                    GridAdView(nativeAd: nativeAd)
                                        .frame(maxWidth: 375)
                                }
                            }
                            else {
                                ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                                    .progressViewStyle(CircularProgressViewStyle())
                                
                                Text("Loading ad")
                                    .foregroundColor(.secondary)
                                
                            }
                        }
                        
                        
                        
                    }else{
                        
                        Button(action: {
                            
                            if !(isPurchased || isWeeklySubscribed || isMonthlySubscribed) && album_data[changedIndex].premium {
                                
                                showIAPsView = true
                                
                            }else{
                                
                                self.open = false
                                self.album_name = album_data[changedIndex].title
                                self.album_cover = data.album_data_cover[album_data[changedIndex].id].image
                                self.album_own_songs = getAlbumSongsArray(album_name: album_name).songs_array
                                self.height = 0
                                self.current = 0
                                closed = true
                                player_called_from = "apps_music"
                                apps_music_bool = true
                                
                                //                        try! self.audioSession.setCategory(.playAndRecord, mode: .spokenAudio, options: [.defaultToSpeaker, .allowAirPlay, .allowBluetoothA2DP])
                                //                        try! self.audioSession.setActive(true)
                                
                                if sounds_playing_audios.count != 0{
                                    sounds_playing_audios.forEach {sounds in
                                        sounds.stop()
                                    }
                                    
                                    initial_volumeValues.removeAll()
                                    initial_volume.removeAll()
                                    sound_names.removeAll()
                                    initial_sounds_array.removeAll()
                                    sounds_playing_audios.removeAll()
                                }
                                
                                
                                if player != nil{
                                    self.player.stop()
                                }
                                let url = Bundle.main.path(forResource: self.album_own_songs[0].song_filename, ofType: "mp3")
                                self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                                self.player.volume = self.songVolumeLineValue
                                self.player.play()
                                
                                let albums_sounds_names_array = getAlbumSoundsNamesArray(album_name: album_name).sounds_array
                                
                                for album_sound in albums_sounds_names_array{
                                    
                                    if soundsData.sounds_data.contains(where: {$0.id == album_sound.sound_id}){
                                        initial_volumeValues.insert(album_sound.sound_volume, at: 0)
                                        initial_volume.insert(CGFloat(35), at: 0)
                                        sound_names.append(soundsData.sounds_data[album_sound.sound_id].sound_name)
                                        initial_sounds_array.insert(soundsData.sounds_data[album_sound.sound_id], at: 0)
                                        
                                        var player = AVAudioPlayer()
                                        let url = Bundle.main.path(forResource: self.soundsData.sounds_data[album_sound.sound_id].sound_filename, ofType: "mp3")
                                        player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                                        player.prepareToPlay()
                                        player.numberOfLoops = -1
                                        player.play()
                                        player.volume = Float(album_sound.sound_volume)
                                        sounds_playing_audios.insert(player, at: 0)
                                    }
                                }
                                isShuffle = false
                                setupNowPlaying()
                            }
                            
                        }) {
                            AlbumCell(height: $height, open: $open, album_name: $album_name, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed, album: album_data[changedIndex])
                                .frame(width:UIScreen.main.bounds.width/2.5, height: UIScreen.main.bounds.height/5)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                    
                    
                }
            } else{
                ForEach(0..<self.album_data.count, id: \.self) { index in
                    
                    Button(action: {
                        
                        if !(isPurchased || isWeeklySubscribed || isMonthlySubscribed) && album_data[index].premium {
                            
                            showIAPsView = true
                            
                        }else{
                            
                            self.open = false
                            self.album_name = album_data[index].title
                            self.album_cover = data.album_data_cover[album_data[index].id].image
                            self.album_own_songs = getAlbumSongsArray(album_name: album_name).songs_array
                            self.height = 0
                            self.current = 0
                            closed = true
                            player_called_from = "apps_music"
                            apps_music_bool = true
                            
                            //                        try! self.audioSession.setCategory(.playAndRecord, mode: .spokenAudio, options: [.defaultToSpeaker, .allowAirPlay, .allowBluetoothA2DP])
                            //                        try! self.audioSession.setActive(true)
                            
                            if sounds_playing_audios.count != 0{
                                sounds_playing_audios.forEach {sounds in
                                    sounds.stop()
                                }
                                
                                initial_volumeValues.removeAll()
                                initial_volume.removeAll()
                                sound_names.removeAll()
                                initial_sounds_array.removeAll()
                                sounds_playing_audios.removeAll()
                            }
                            
                            
                            if player != nil{
                                self.player.stop()
                            }
                            let url = Bundle.main.path(forResource: self.album_own_songs[0].song_filename, ofType: "mp3")
                            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                            self.player.volume = songVolumeLineValue
                            self.player.play()
                            
                            let albums_sounds_names_array = getAlbumSoundsNamesArray(album_name: album_name).sounds_array
                            
                            for album_sound in albums_sounds_names_array{
                                
                                if soundsData.sounds_data.contains(where: {$0.id == album_sound.sound_id}){
                                    initial_volumeValues.insert(album_sound.sound_volume, at: 0)
                                    initial_volume.insert(CGFloat(35), at: 0)
                                    sound_names.append(soundsData.sounds_data[album_sound.sound_id].sound_name)
                                    initial_sounds_array.insert(soundsData.sounds_data[album_sound.sound_id], at: 0)
                                    
                                    var player = AVAudioPlayer()
                                    let url = Bundle.main.path(forResource: self.soundsData.sounds_data[album_sound.sound_id].sound_filename, ofType: "mp3")
                                    player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                                    player.prepareToPlay()
                                    player.numberOfLoops = -1
                                    player.play()
                                    player.volume = Float(album_sound.sound_volume)
                                    sounds_playing_audios.insert(player, at: 0)
                                }
                            }
                            setupNowPlaying()
                        }
                        
                    }) {
                        AlbumCell(height: $height, open: $open, album_name: $album_name, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed, album: album_data[index])
                            .frame(width:UIScreen.main.bounds.width/2.5, height: UIScreen.main.bounds.height/5)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(.horizontal)
        
        .fullScreenCover(isPresented: $showIAPsView) {
            IAPsView(showIAPsView: $showIAPsView, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed)
                .environmentObject(store)
        }
        
        .onAppear {
            self.nativeViewControllers.append(NativeViewController2(vari: $adStatusVarOne))
        }
        
        
        .onAppear {
            //print(index)
            //  adIndex = adIndexDeterminer(index: index)
            // print(adIndex)
            //rself.nativeViewControllers.remove(at: adIndex)
            
            self.nativeViewControllers.insert(NativeViewController2(vari: $adStatusVar[0]), at: 0)
            let isIndexValid = self.nativeViewControllers.indices.contains(0)
            if isIndexValid{
                nativeViewControllers[0].loadAd()
            }
            
            self.nativeViewControllers.insert(NativeViewController2(vari: $adStatusVar[1]), at: 1)
            let isIndexValid2 = self.nativeViewControllers.indices.contains(1)
            if isIndexValid2 {
                nativeViewControllers[1].loadAd()
            }
            
            print("LoadLoadlOAd")
        }
        .onDisappear {
            print("Dissapeared")
            
            //self.nativeViewControllers.remove(at: adIndex)
        }
        

        
        // for adGrids
        //        .onAppear {
        //            self.nativeViewControllers.append(NativeViewController2(vari: $adStatusVarOne))
        //        }
        
    }
    
    func setupNowPlaying() {
        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = album_own_songs[current].song_name

        if let image = UIImage(named: album_cover ) {
            nowPlayingInfo[MPMediaItemPropertyArtwork] =
                MPMediaItemArtwork(boundsSize: image.size) { size in
                    return image
            }
        }
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.rate

        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    
    func indexDeterminer(index: Int) -> Int{
        
        if index > 9{
            return index - 2
        }else if index > 1{
            return index - 1
        }
        
        return index
    }
    
    func adIndexDeterminer(index: Int) -> Int {
        if index == 9{
            return 1
        }else if index == 1{
            return 0
        }
        return 0
    }
    
    
}



struct AlbumCell: View {
    @Binding public var height: CGFloat
    @Binding public var open: Bool
    @Binding public var album_name: String
    @Binding var isPurchased: Bool
    @Binding var isMonthlySubscribed: Bool
    @Binding var isWeeklySubscribed: Bool
    
    let album: Album
    var body: some View {
        ZStack(alignment: .top){
            ZStack(alignment: .bottom) {
                Image(album.image)
                    .resizable()
                    .aspectRatio( contentMode: .fill)
                    .frame(width:UIScreen.main.bounds.width/2.5, height: UIScreen.main.bounds.height/5)
                    .cornerRadius(UIScreen.main.bounds.height/40)
                    .contentShape(Path(CGRect(x:0, y:0, width: UIScreen.main.bounds.width/2.5, height: UIScreen.main.bounds.height/5)))
                
                
                
                Rectangle()                         // Shapes are resizable by default
                    .foregroundColor(.clear)        // Making rectangle transparent
                    .background(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(UIScreen.main.bounds.height/40)
                    .frame(width:UIScreen.main.bounds.width/2.5, height: 70)
                
            }
            .frame(width:UIScreen.main.bounds.width/2.5, height: UIScreen.main.bounds.height/5)
            
            
            
            if !(isPurchased || isWeeklySubscribed || isMonthlySubscribed){
                
                if(album.premium){
                    Image("premium_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width*22/390, height: UIScreen.main.bounds.height*22/844)
                        .padding(.leading, UIScreen.main.bounds.width/3.5)
                        .padding(.top, 15)
                }
            }
            
            VStack{
                Spacer()
                
                HStack{
                    VStack(alignment: .leading){
                        Text(album.title)
                            .foregroundColor(.white)
                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                        
                        if album.artist != ""{
                        Text(album.artist)
                            .foregroundColor(.gray)
                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/85))
                        }
                    }
                    .padding(UIScreen.main.bounds.height/130)
                    Spacer()
                }
                
            }.frame(width:UIScreen.main.bounds.width/2.5, height: UIScreen.main.bounds.height/5)
            
            
            
//            HStack {
//                VStack(alignment: .leading) {
//                    Spacer()
//                    Text(album.title)
//                        .foregroundColor(.white)
//                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
//
//                    //                            Text(album.count)
//                    //                                .foregroundColor(.gray)
//                    //                                .font(.system(size: UIScreen.main.bounds.width*12/390))
//                }
//                .padding()
//                Spacer()
//            }
            
        }
        .frame(width:UIScreen.main.bounds.width/2.5, height: UIScreen.main.bounds.height/5)
    }
}
