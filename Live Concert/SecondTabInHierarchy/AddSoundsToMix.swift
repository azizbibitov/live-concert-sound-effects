//
//  AddSoundsToMix.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 27.03.2022.
//

import SwiftUI
import AVKit
import RealmSwift
import ToastUI
import MediaPlayer

struct AddSoundsToMix: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var determineShowingAd: ShouldShowAd
    @EnvironmentObject var realManager: RealmManager
    @Binding var start_point_checked: Bool
    @Binding var end_point_checked: Bool
    @Binding public var initial_volume: [CGFloat]
    
    
    
    @Binding var editViewDisplay: Bool
    
    @Binding public var sound_names: [String]
    
    @State var index = 0
    @State var selection = 0
    @State var sounds_category_array: [String] = ["Rain & Thunder", "Nature", "Animals", "Birds", "City & Transport", "Meditation"]
    
    
    
    @Binding public var initial_audios: [AVAudioPlayer]
    @Binding public var initial_sounds_array: [Sound]
    @Binding public var open: Bool
    @Binding public var closed: Bool
    @Binding public var height: CGFloat
    @Binding public var addSongsShow: Bool
    @Binding public var initial_album_songs: [Songs]
    @Binding public var album_name: String
    @Binding public var album_own_songs: [Songs]
    @Binding public var album_cover: String
    @Binding public var current: Int
    @Binding public var player_called_from: String
    @Binding public var users_music_closed: Bool
    @Binding public var player: AVAudioPlayer!
    @Binding public var apps_music_bool: Bool
    @Binding public var showMixEdit: Bool
    @Binding public var playing_music_realm_id: ObjectId
    @Binding var initial_volumeValues: [Double]
    @Binding var tabChangeBool: Bool
    @Binding public var sounds_playing: [Sound]
    @Binding public var playing_sounds_audios: [AVAudioPlayer]
    @Binding var volume : [CGFloat]
    @Binding var volumeValues: [Double]
    @Binding var interstitial : InterstitialAd?
    @Binding var playing: Bool!
    @Binding var isPurchased: Bool
    @Binding var isMonthlySubscribed: Bool
    @Binding var isWeeklySubscribed: Bool
    @Binding var playingCreatedMix: CreatedMix
    @Binding var isShuffle: Bool
    @Binding var showIAPsView: Bool
    @Binding var addedLocalSongUrls: [URL]
    @Binding var songVolumeLineValue: Float
    
    
    let soundsData = SoundsData()
    
    @State var timerGradient = Timer.publish(every: 3, on: .current, in: .default).autoconnect()
    @State var gradient = [Color("EditBackColor"), Color("explore_back_color")]
    @State var startPoint = UnitPoint(x: CGFloat(Int.random(in: -1...2)), y: CGFloat(Int.random(in: -1...2)))
    @State var endPoint = UnitPoint(x: CGFloat(Int.random(in: -1...2)), y: CGFloat(Int.random(in: -1...2)))
    
    @State var showToast: Bool = false
    @State var sound_names2: [String] = []
    
    @Environment(\.horizontalSizeClass) var hSizeClass
    @Environment(\.verticalSizeClass) var vSizeClass
    
    @State var category_text_spacing: CGFloat = 0
    
    var body: some View {
        ZStack{
            
            RoundedRectangle(cornerRadius: 0)
                .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                .edgesIgnoringSafeArea(.all)
            
                .onReceive(timerGradient) { _ in
                    withAnimation (.easeInOut(duration: 4)){
                        
                        let startx = CGFloat(Int.random(in: -1...2))
                        let starty = CGFloat(Int.random(in: -1...2))
                        var endx = CGFloat(Int.random(in: -1...2))
                        var endy = CGFloat(Int.random(in: -1...2))
                        
                        
                        for _ in 0...10000{
                            if abs(startx-endx) != 0 && abs(starty-endy) != 0{
                                //print("breaked")
                                break
                            }else{
                                endx = CGFloat(Int.random(in: -1...2))
                                endy = CGFloat(Int.random(in: -1...2))
                                //print("changed")
                            }
                        }
                        
                        self.startPoint = UnitPoint(x: startx, y: starty)
                        self.endPoint = UnitPoint(x: endx, y: endy)
                        
                        //print("startx: \(startx),  starty: \(starty)")
                        //print("endx: \(endx),  endy: \(endy)\n\n\n")
                    }
                    
                }
            
            VStack{
                HStack{
                    
                    Button(action: {
                        withAnimation(.spring()) {
//                            initial_sounds_array = sounds_playing
//                            initial_audios = playing_sounds_audios
//                            initial_volume = volume
//                            initial_volumeValues = volumeValues
                            addSongsShow.toggle()
                        }
                        
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: UIScreen.main.bounds.height/25))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("Edit Sounds")
                        .foregroundColor(.white)
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/40))
                    
                    Spacer()
                    
                    Image("empty")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width*24/390, height: UIScreen.main.bounds.height*24/844)
                }
                .padding(.top, UIScreen.main.bounds.height/20)
                .padding(.horizontal, UIScreen.main.bounds.width/20)
                
                //                HStack{
                //                    HStack {
                //                        Button {
                //                            withAnimation {
                //                                start_point_checked.toggle()
                //                            }
                //
                //                        } label: {
                //                            Image(systemName: self.start_point_checked ? "checkmark.square" : "square")
                //                                .font(.system(size: UIScreen.main.bounds.height/42))
                //                                .foregroundColor(self.start_point_checked ? .white : .white.opacity(0.3))
                //                        }
                //                        Text("Startpoint sounds")
                //                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                //                            .foregroundColor(.white)
                //                    }
                //                    Spacer()
                //                    HStack{
                //                        Button {
                //                            withAnimation {
                //                                end_point_checked.toggle()
                //                            }
                //
                //                        } label: {
                //                            Image(systemName: self.end_point_checked ? "checkmark.square" : "square")
                //                                .font(.system(size: UIScreen.main.bounds.height/45))
                //                                .foregroundColor(self.end_point_checked ? .white : .white.opacity(0.3))
                //                        }
                //                        Text("Endpoint sounds")
                //                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                //                            .foregroundColor(.white)
                //                    }
                //                    Spacer()
                //                }
                //                .padding(.vertical, UIScreen.main.bounds.height/80)
                //                .padding(.horizontal, UIScreen.main.bounds.width/10)
                
                HStack {
                    Text("Selected")
                        .foregroundColor(.white)
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/55))
                    Spacer()
                }
                .padding(.leading, UIScreen.main.bounds.width/20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack { // or LazyHStack
                        ForEach(sounds_playing) { sound_playing in
                            VStack{
                                ZStack(alignment: .topTrailing) {
                                    Image(sound_playing.sound_image)
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.white)
                                        .frame(width: UIScreen.main.bounds.width*68/390, height: UIScreen.main.bounds.height*68/844)
                                    
                                    Button {
                                        withAnimation(.spring()) {
                                            playing_sounds_audios[sounds_playing.firstIndex(of: sound_playing)!].stop()
                                            playing_sounds_audios.remove(at: sounds_playing.firstIndex(of: sound_playing)!)
                                            sound_names2.remove(at: sounds_playing.firstIndex(of: sound_playing)!)
                                           // sound_names.remove(at: 0)
                                            sounds_playing.remove(at: sounds_playing.firstIndex(of: sound_playing)!)
                                        }
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: UIScreen.main.bounds.height/40))
                                    }
                                }
                                Text(sound_playing.sound_name)
                                    .foregroundColor(.white)
                                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/60))
                                
                                
                                
                                Slider(value: $playing_sounds_audios[sounds_playing.firstIndex(of: sound_playing)!].volume, in: 0...1){editing in
                                    
                                    //print("editing", editing)
                                    //isEditing = editing
                                    
                                    if !editing{
                                        volumeValues[sounds_playing.firstIndex(of: sound_playing)!] = Double(playing_sounds_audios[sounds_playing.firstIndex(of: sound_playing)!].volume)
                                    }
                                    
                                }
                                //                                .introspectSlider(customize: { slider in
                                //                                    slider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
                                //                                })
                                .tint(.white)
                                
                                
                            }
                            .padding(.trailing, UIScreen.main.bounds.width/100)
                        }
                    }
                    
                }
                .padding(.top, UIScreen.main.bounds.height/20)
                .frame(height: UIScreen.main.bounds.height/10)
                .padding(.leading, UIScreen.main.bounds.width/20)
                
                ScrollViewReader{ value in
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        // Tab View
                        HStack(spacing: category_text_spacing) {
                            
                            ForEach(sounds_category_array, id: \.self){sound_category_array in
                                
                                Text(sound_category_array)
                                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/55))
                                    .foregroundColor(index == sounds_category_array.firstIndex(of: sound_category_array) ? .white : Color("sound_categories_color").opacity(0.7))
                                    .padding(.vertical, 10)
                                    .padding(.trailing, 15)
                                    .onTapGesture {
                                        withAnimation(.default) {
                                            index = sounds_category_array.firstIndex(of: sound_category_array)!
                                            selection = sounds_category_array.firstIndex(of: sound_category_array)!
                                            value.scrollTo(sounds_category_array.firstIndex(of: sound_category_array)!, anchor: .trailing)
                                        }
                                    }
                                    .id(sounds_category_array.firstIndex(of: sound_category_array))
                            }
                            
                            
                        }
                        .padding(.leading, UIScreen.main.bounds.width/20)
                        
                        
                    }
                    
                    
                    // Dashboard Grid
                    // Tab View With Swipe Gestures
                    // connecting index with TabView for Tab Change
                    TabView(selection: $selection) {
                        
                        ForEach(sounds_category_array, id: \.self){sound_category in
                            
                            VStack{
                                AddSoundsToMixCategoryView( volume: $volume, playing_sounds_audios: $playing_sounds_audios, sound_names: $sound_names, sounds_playing: $sounds_playing, volumeValues: $volumeValues, category_sounds_data: getSoundsCategoryArray(category_name: sound_category).sounds_array, sound_names2: $sound_names2, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed, showIAPsView: $showIAPsView)
                                    .environmentObject(store)
                                
                                
                                Spacer()
                            }
                            .tag(sounds_category_array.firstIndex(of: sound_category)!)
                        }
                        
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .onChange(of: selection) { s in
                        withAnimation {
                            index = s
                            value.scrollTo(s, anchor: .trailing)
                        }
                    }
                    
                    
                }
                .padding(.top, UIScreen.main.bounds.height/15)
                
                
                Spacer()
                
//                HStack(spacing: 50){
//                    VStack{
//                        Button {
//
//                            if sounds_playing != initial_sounds_array {
//
//                                playing_sounds_audios.forEach { audio in
//                                    audio.stop()
//                                }
//                                playing_sounds_audios = initial_audios
//                                volume = initial_volume
//                                sounds_playing = initial_sounds_array
//                                volumeValues = initial_volumeValues
//
//                                playing_sounds_audios.forEach { audio in
//                                    audio.play()
//                                }
//
//                                sound_names2 = []
//                                sounds_playing.forEach { sound in
//                                    sound_names2.append(sound.sound_name)
//                                }
//                            }
//
//                      //      {
////                            let canceled_items_array = sounds_playing
////                            //                            for sound in initial_sounds_array{
////                            //                                if let ix = canceled_items_array.firstIndex(of: sound){
////                            //                                    canceled_items_array.remove(at: ix)
////                            //                                }
////                            //                            }
////
////                            for sound2 in canceled_items_array{
////                                if let ix = sounds_playing.firstIndex(of: sound2){
////                                    self.playing_sounds_audios[ix].stop()
////                                    self.playing_sounds_audios.remove(at: ix)
////                                    self.volume.remove(at: ix)
////                                    self.volumeValues.remove(at: ix)
////                                    sounds_playing.remove(at: ix)
////                                    sound_names.remove(at: ix)
////                                    sound_names2.remove(at: ix)
////                                }
////                            }
////
////                            var beginner_canceled_items_array = initial_sounds_array
////                            for sound in sounds_playing{
////                                if let ix = beginner_canceled_items_array.firstIndex(of: sound){
////                                    beginner_canceled_items_array.remove(at: ix)
////                                }
////                            }
////
////                            for sound2 in beginner_canceled_items_array{
////                                if let ix = initial_sounds_array.firstIndex(of: sound2){
////                                    self.playing_sounds_audios.insert(initial_audios[ix], at: ix)
////                                    self.playing_sounds_audios[ix].play()
////                                    sounds_playing.insert(sound2, at: ix)
////                                    self.volume.insert(initial_volume[ix], at: ix)
////                                    self.volumeValues.insert(initial_volumeValues[ix], at: ix)
////                                    self.sound_names.insert(sound2.sound_name, at: ix)
////                                    self.sound_names2.insert(sound2.sound_name, at: ix)
////                                }
////                            }
//                      //      }
//
//
//
//                        } label: {
//                            Image(systemName: "arrow.clockwise")
//                                .font(.system(size: UIScreen.main.bounds.height/30))
//                                .foregroundColor(.white)
//                                .padding(UIScreen.main.bounds.height/55)
//                                .clipShape(Circle())
//                                .overlay(
//                                    Circle().stroke(Color.white.opacity(0.1), lineWidth: 2)
//                                )
//                        }
//
//                        Text("Undo")
//                            .foregroundColor(.white)
//                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/60))
//                            .padding(.bottom, UIScreen.main.bounds.height/150)
//                    }.visibility(.invisible)
                    
                    VStack{
                        Button {
                      
                            
                            if initial_album_songs.count == 0{
                                showToast = true
                            }else{
                                
                                if initial_audios.count != 0{
                                    initial_audios.forEach {sounds in
                                        sounds.stop()
                                        
                                    }
                                }
                                
                                initial_sounds_array = sounds_playing
                                initial_audios = playing_sounds_audios
                                initial_volume = volume
                                initial_volumeValues = volumeValues
                                
                    
                                
                                let defaultMixID = realManager.createDefaultMix()
                                
                                for song in initial_album_songs{
                                    realManager.addSongToMix(mixID: defaultMixID, song_name: song.song_name, song_filename: song.song_filename, artist: song.artist, audio_from_internal_storage: song.audio_from_internal_storage)
                                }
                                for sound in initial_sounds_array{
                                    realManager.addSoundToMix(mixID: defaultMixID, sound_name: sound.sound_name, sound_image: sound.sound_image, sound_filename: sound.sound_filename, sound_category: sound.sound_category, sound_volume: Float(initial_volumeValues[initial_sounds_array.firstIndex(of: sound)!]))
                                }
                                
                                addedLocalSongUrls.forEach { newValue in
                                    var Artist = ""
                                    var Title = ""
                                    var localSongPlayer = AVAudioPlayer()
                                    do {
                                        
                                        try localSongPlayer = AVAudioPlayer(contentsOf: newValue)
                                        
                                    } catch {
                                        print("errorpopoppopopopopopoppo\(error)")
                                    }
                                    
                                    let asset = AVAsset(url: localSongPlayer.url!)
                                    
                                    for i in asset.commonMetadata{
                                        if i.commonKey?.rawValue == "artist"{
                                            let artist = i.value as! String
                                            Artist = artist
                                        }
                                        if i.commonKey?.rawValue == "title"{
                                            let title = i.value as! String
                                            Title = title
                                        }
                                    }
                                    
                                    let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                                    
                                    // lets create your destination file url
                                    let destinationUrl = documentsDirectoryURL.appendingPathComponent(newValue.lastPathComponent)
                                    print(destinationUrl)
                                    
                                    // to check if it exists before downloading it
                                    if FileManager.default.fileExists(atPath: destinationUrl.path) {
                                       // print("The file already exists at path")
                                        //self.playMusic(url: destinationUrl)
                                        //self.parent.url = destinationUrl
                                    } else {
                                        // if the file doesn't exist you can use NSURLSession.sharedSession to download the data asynchronously
                                        URLSession.shared.downloadTask(with: newValue, completionHandler: { (location, response, error) -> Void in
                                            guard let location = location, error == nil else { return }
                                            do {
                                                // after downloading your file you need to move it to your destination url
                                                try FileManager.default.moveItem(at: location, to: destinationUrl)
                                                // self.playMusic(url: destinationUrl)
                                                //self.parent.url = destinationUrl
                                                //print("File moved to documents folder")
                                            } catch let error as NSError {
                                                print(error.localizedDescription)
                                            }
                                        }).resume()
                                    }
                                    
                                    if Title == ""{
                                        Title = "UnknownTitle"
                                    }
                                    
                                    if Artist == ""{
                                        Artist = "UnknownArtist"
                                    }
                                    
                                    var song_file_names: [String] = []
                                    
                                    for songs in initial_album_songs{
                                        song_file_names.insert(songs.song_filename, at: 0)
                                    }
                                    
                                    if !song_file_names.contains(destinationUrl.path){
                                        
                                        let song = Songs(id: initial_album_songs.count, album_name: initial_album_songs[0].album_name, song_name: Title, song_filename: destinationUrl.path, artist: Artist, audio_from_internal_storage: true)
                                        
                                        realManager.addSongToMix(mixID: defaultMixID, song_name: song.song_name, song_filename: song.song_filename, artist: song.artist, audio_from_internal_storage: song.audio_from_internal_storage)
                                        //initial_album_songs = []
                                        initial_album_songs.append(song)
                                    }
                                }
                                
                                
                                
                                addSongsShow.toggle()
                                
                                self.editViewDisplay = false
                                if realManager.created_mixes.count != 0{
                                    self.album_name = realManager.created_mixes[0].mix_name
                                    self.album_cover = realManager.created_mixes[0].image
                                }
                                self.album_own_songs = initial_album_songs
                                
                                
                                //                            var i = 0
                                //                            self.album_own_songs.removeAll()
                                //                            let array = Array(realManager.created_mixes[0].songs)
                                //                            for realmSong in  array{
                                //                                album_own_songs.append(Songs(id: i, album_name: album_name, song_name: realmSong.song_name, song_filename: realmSong.song_filename, artist: realmSong.artist))
                                //                                i += 1
                                //                            }
                                
                                if player != nil{
                                    self.player.stop()
                                }
                                let url = Bundle.main.path(forResource: self.album_own_songs[0].song_filename, ofType: "mp3")
                                self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                                self.player.volume = songVolumeLineValue
                                self.player.play()
                                
                                
                                self.open = false
                                self.height = 0
                                self.current = 0
                                users_music_closed.toggle()
                                player_called_from = "users_music"
                                apps_music_bool = false
                                showMixEdit.toggle()
                                if realManager.created_mixes.count != 0{
                                    playing_music_realm_id = realManager.created_mixes[0].id
                                }
                                
                                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                                    
                                    print("created")
                                    determineShowingAd.clickTrigger()
                                    determineShowingAd.determizer()
                                    //
                                    if determineShowingAd.shouldShowAd && !(isPurchased || isWeeklySubscribed || isMonthlySubscribed) && interstitial!.loaded{
                                            playing = player.isPlaying

                                                player.stop()
                                                for playing_sounds_audio in initial_audios {
                                                    playing_sounds_audio.stop()
                                                }


                                        interstitial?.show()
                                        print("Yeee")
                                    }
                                }
                                
                                addedLocalSongUrls = []
                                sounds_playing = []
                                playing_sounds_audios = []
                                volume = []
                                volumeValues = []
                                initial_album_songs = []
                                
                                if realManager.created_mixes.count != 0{
                                    playingCreatedMix = realManager.created_mixes[0]
                                }
                                print("rororo\(playingCreatedMix)")
                                isShuffle = false
                                setupNowPlaying()
                            }
                        
                        } label: {
                            Image(systemName: "checkmark")
                                .font(.system(size: UIScreen.main.bounds.height/30))
                                .foregroundColor(.white)
                                .padding(UIScreen.main.bounds.height/55)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.white.opacity(0.1), lineWidth: 2)
                                )
                        }
                        
                        Text("Save")
                            .foregroundColor(.white)
                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/60))
                            .padding(.bottom, UIScreen.main.bounds.height/150)
                    }
                    .padding(.bottom, UIScreen.main.bounds.height/150)
                    
//                    VStack{
//                        Button {
//
//                            for sound in sounds_playing{
//                                self.playing_sounds_audios[sounds_playing.firstIndex(of: sound)!].stop()
//                                self.playing_sounds_audios.remove(at: sounds_playing.firstIndex(of: sound)!)
//                                //sound_names.remove(at: sounds_playing.firstIndex(of: sound)!)
//                                volume.remove(at: sounds_playing.firstIndex(of: sound)!)
//                                volumeValues.remove(at: sounds_playing.firstIndex(of: sound)!)
//                                sounds_playing.remove(at: sounds_playing.firstIndex(of: sound)!)
//                            }
//
//
//                            volume.insert(CGFloat(35), at: 0)
//                            volumeValues.insert(0.5, at: 0)
//                            sound_names.append(soundsData.sounds_data[21].sound_name)
//                            sounds_playing.insert(soundsData.sounds_data[21], at: 0)
//
//                            //volume[sounds_playing.firstIndex(of: category_sound_data)!] = 50
//
//                            var player = AVAudioPlayer()
//                            let url = Bundle.main.path(forResource: self.soundsData.sounds_data[21].sound_filename, ofType: "mp3")
//                            player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
//                            player.prepareToPlay()
//                            player.numberOfLoops = -1
//                            player.play()
//                            player.volume = 0.5
//                            playing_sounds_audios.insert(player, at: 0)
//
//                        } label: {
//                            Image(systemName: "xmark")
//                                .font(.system(size: UIScreen.main.bounds.height/30))
//                                .foregroundColor(.white)
//                                .padding(UIScreen.main.bounds.height/55)
//                                .clipShape(Circle())
//                                .overlay(
//                                    Circle().stroke(Color.white.opacity(0.1), lineWidth: 2)
//                                )
//                        }
//
//                        Text("Reset")
//                            .foregroundColor(.white)
//                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/60))
//                            .padding(.bottom, UIScreen.main.bounds.height/150)
//                    }.visibility(.invisible)
//                }
                
            }.edgesIgnoringSafeArea(.all)
            
        }
        .onAppear {
            
            if vSizeClass == .regular && hSizeClass == .regular{
                category_text_spacing = UIScreen.main.bounds.width/25
            }else{
                category_text_spacing = 0
            }
 
            //            volume = initial_volume
            //            playing_sounds_audios = initial_audios
            //            sounds_playing = initial_sounds_array
            
            
//            sounds_playing = initial_sounds_array
//            playing_sounds_audios = initial_audios
//            volume = initial_volume
//            volumeValues = initial_volumeValues
            sounds_playing.forEach { sound in
                sound_names2.append(sound.sound_name)
            }
        }
        
        .onDisappear {
            //initial_volume = volume
            
        }
        
        .toast(isPresented: $showToast, dismissAfter: 2) {
            showToast = false
        } content: {
            ToastView("Please add song to create a mix")
        }
        

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
    
}

struct AddSoundsToMixCategoryView: View{
    @EnvironmentObject var store: Store
    @Binding public var volume : [CGFloat]
    @State var player: AVAudioPlayer!
    @Binding public var playing_sounds_audios: [AVAudioPlayer]
    @Binding public var sound_names: [String]
    @Binding public var sounds_playing: [Sound]
    @Binding public var volumeValues : [Double]
    var category_sounds_data: [Sound]
    @Binding public var sound_names2: [String]
    @Binding var isPurchased: Bool
    @Binding var isMonthlySubscribed: Bool
    @Binding var isWeeklySubscribed: Bool
    @Binding var showIAPsView: Bool
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 4)
    
    
    var body: some View{
        LazyVGrid(columns: columns, spacing: UIScreen.main.bounds.height/150) {
            
            ForEach(category_sounds_data) { category_sound_data in
                
                VStack{
                    
                    Button {
                        
                        if !(isPurchased || isWeeklySubscribed || isMonthlySubscribed) && category_sound_data.is_sound_premium {
                            
                            showIAPsView = true
                            
                        }else{
                            
                            if sound_names2.contains(where: { $0 == category_sound_data.sound_name}){
                                
                                playing_sounds_audios[sound_names2.firstIndex(of: category_sound_data.sound_name)!].stop()
                                playing_sounds_audios.remove(at: sound_names2.firstIndex(of: category_sound_data.sound_name)!)
                                volume.remove(at: sound_names2.firstIndex(of: category_sound_data.sound_name)!)
                                volumeValues.remove(at: sound_names2.firstIndex(of: category_sound_data.sound_name)!)
                                sounds_playing.remove(at: sound_names2.firstIndex(of: category_sound_data.sound_name)!)
                                //sound_names.remove(at: sound_names2.firstIndex(of: category_sound_data.sound_name)!)
                                sound_names2.remove(at: sound_names2.firstIndex(of: category_sound_data.sound_name)!)
                                
                                
                            }else{
                                sound_names.append(category_sound_data.sound_name)
                                sounds_playing.insert(category_sound_data, at: 0)
                                sound_names2.insert(category_sound_data.sound_name, at: 0)
                                
                                //volume[sounds_playing.firstIndex(of: category_sound_data)!] = 50
                                
                                volume.insert(CGFloat(35), at: 0)
                                volumeValues.insert(0.5, at: 0)
                                
                                let url = Bundle.main.path(forResource: self.sounds_playing[0].sound_filename, ofType: "mp3")
                                self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                                self.player.prepareToPlay()
                                self.player.numberOfLoops = -1
                                self.player.play()
                                self.player.volume = 0.5
                                playing_sounds_audios.insert(self.player, at: 0)
                            }
                        }
                        
                    } label: {
                        ZStack{
                            Image(category_sound_data.sound_image)
                                .resizable()
                                .scaledToFill()
                            
                            
                            if sound_names2.contains{ $0 == category_sound_data.sound_name}{
                                Image("icons-enable")
                                    .resizable()
                                    .scaledToFill()
                            }
                                
                            if !(isPurchased || isWeeklySubscribed || isMonthlySubscribed){
                                if category_sound_data.is_sound_premium{
                                    VStack{
                                        HStack{
                                            Spacer()
                                            Image("premium_icon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.main.bounds.height/60, height: UIScreen.main.bounds.height/60)
                                        }
                                        Spacer()
                                    }
                                }
                            }
                            
                        
                            
                        }
                        .frame(width: UIScreen.main.bounds.height/17, height: UIScreen.main.bounds.height/17)
                    }
                    
                    Text(category_sound_data.sound_name)
                        .foregroundColor(.white)
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/70))
                        .padding(.top, 2)
                        .multilineTextAlignment(.center)
                    Spacer()
                    
                }
                .frame(height: UIScreen.main.bounds.height/7.5)
                .padding(.horizontal)
                
            }
            
        }.padding(.top, UIScreen.main.bounds.height/50)
        
            .fullScreenCover(isPresented: $showIAPsView) {
                IAPsView(showIAPsView: $showIAPsView, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed)
                    .environmentObject(store)
            }
        
    }
    
    
}


//struct EditSoundsView_Previews: PreviewProvider {
//    @State static var sounds_category_array = getSoundsCategoryArray(category_name: "General").sounds_array
//    @State static var edit = true
//    @State static var sounds_playing: [Sound] = [
//        Sound(id: 0, sound_name: "Beach", sound_image: "beach-33", sound_filename: "ocean_waves", sound_volume: 0.5, sound_category: "General"),
//        Sound(id: 1, sound_name: "Birds", sound_image: "bird-33", sound_filename: "jungle_night", sound_volume: 0.5, sound_category: "General"),
//    ]
//    @State static var sound_names: [String] = ["Beach", "Birds"]
//    static var previews: some View {
//        EditSoundsView(editViewDisplay: $edit, sounds_playing: $sounds_playing, sound_names: $sound_names)
//        //EditSoundsCategoryView(category_sounds_data: sounds_category_array)
//    }
//}


