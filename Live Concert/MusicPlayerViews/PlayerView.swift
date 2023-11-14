//
//  PlayerView.swift
//  AudioPlayer
//
//  Created by Aziz Bibitov on 03.03.2022.
//

import SwiftUI
import AVKit
import GoogleMobileAds
import MediaPlayer
import RealmSwift




struct PlayerView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var realManager: RealmManager
    @EnvironmentObject var myTimer: MyTimer
    @Binding public var sounds_playing_audios: [AVAudioPlayer]
    @Binding public var current: Int
    @Binding public var player: AVAudioPlayer!
    
    @Binding public var height: CGFloat
    @Binding public var open: Bool
    @Binding public var album_name: String
    
    
    //For Smaller Size Phones
    @State var width : CGFloat = UIScreen.main.bounds.height < 750 ? 130 : 230
    @State var timer = Timer.publish(every: 0.1, on: .current, in: .default).autoconnect()
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    @State private var isLiked = false
    @State private var width_timeline : CGFloat = 0
    @State var volume : CGFloat = 0
    
    @State var timeLine : CGFloat = 0
    @State var repeatImagesArray: [String] = ["repay_enable", "repay_all_active", "repay_1_active"]
    
    
    @State var song = Song()
    
    @State var angle : Double = 0
    
    
    @State var title = ""
    @State var artist = ""
    @State var duration: TimeInterval = 0
    
    
    @State var songs = ["i_wanted", "nwantiti", "sia", "bella_ciao"]
    @Binding public var album_own_songs: [Songs]
    @Binding var sound_names: [String]
    @Binding var initial_volume: [CGFloat]
    @Binding var initial_sounds_array: [Sound]
    @Binding public var apps_music_bool: Bool
    @Binding public var showMixEdit: Bool
    
    
    @State var points_state: [Bool] = []
    @State var editViewDisplay: Bool = false
    
    
    
    @Binding var volumeValues: [Double]
    @Binding var tabBarHeight: CGFloat
    @Binding public var album_cover: String
    @Binding var finish: Bool
    @Binding var playingCreatedMix: CreatedMix
    @Binding var tabChangeBool: Bool
    @Binding var currentRepeatImage: Int
    @Binding var isShuffle: Bool
    @Binding var timeLineValue: Double
    @Binding var isEditing: Bool
    @Binding public var playing_music_realm_id: ObjectId
    @Binding var changeSongTimer: Timer?
    @Binding var changeSongTimer2: Timer?
    @Binding var endTimer: Timer?
    @Binding var del: AVdelegate
    @Binding var start_point_checked: Bool
    @Binding var end_point_checked: Bool
    @Binding var songVolumeLineValue: Float
    @Binding var playerStart: Player
    @Binding var playerEnd: Player
    @Binding var errorOffset: CGFloat
    @Binding var offsetinHomeView: CGFloat
    @Binding var isPurchased: Bool
    @Binding var isMonthlySubscribed: Bool
    @Binding var isWeeklySubscribed: Bool
    @Binding var showIAPsView: Bool
    
    @State var errorResolver: String = ""
    @State var nativeViewController: NativeViewController2!
    @State var adStatusVar: Int = 2
    @State var nativeAdClosed = false
    
    let applause_struct = Applauses()
    
//    private let audioSession = AVAudioSession.sharedInstance()
    
    let redrawCategoriesPublisher = NotificationCenter.default.publisher(for: Notification.Name(rawValue: "Finish"))
    
    var body: some View {
        ZStack{
            Color("add_songs_color").opacity(0.01)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                HStack{
                    
                    Button(action: {
                        withAnimation (.easeInOut(duration: 0.7)){
                            self.open = true
                            self.height = UIScreen.main.bounds.height - tabBarHeight*1.55 - UIScreen.main.bounds.height/9
                            if offsetinHomeView > 200{
                                errorOffset = UIScreen.main.bounds.height*340/844
                            }
                            tabChangeBool.toggle()
                        }
                        
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: UIScreen.main.bounds.height/25))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text(album_name)
                        .foregroundColor(.white)
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/40))
                    
                    Spacer()
                    
                    Button(action: {
                        if apps_music_bool{
                            if isLiked == false{
                                isLiked = true
                            }else{
                                isLiked = false
                            }
                        }else{
                            withAnimation(.spring()) {
                                showMixEdit.toggle()
                            }
                        }
                        
                    }) {
                        
                        if apps_music_bool{
                            Image(systemName: isLiked ? "qweheart.fill" : "qweheart")
                                .font(.system(size: UIScreen.main.bounds.height/25))
                                .foregroundColor(isLiked ? Color.white : Color.white)
                        } else{
                            //                                ZStack(alignment: .bottomTrailing){
                            //                                    Image(systemName: "doc.text")
                            //                                        .foregroundColor(.white)
                            //                                        .font(.system(size: UIScreen.main.bounds.height/33))
                            //
                            //
                            //                                        Image(systemName: "pencil")
                            //                                            .foregroundColor(.white)
                            //                                            .font(.system(size: UIScreen.main.bounds.height/45))
                            //
                            //
                            //
                            //                                }
                            
                            Image("edit_playlist")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width*26/390, height: UIScreen.main.bounds.height*26/844)
                            
                        }
                    }
                }
                .padding(.top, UIScreen.main.bounds.height/20)
                .padding(.horizontal, UIScreen.main.bounds.width/20)
                
                Spacer()
                
                ZStack{
                    
                    
                    
                    
                    
                    Slider(value: Binding(get: {
                        self.songVolumeLineValue
                    }, set: { (newVal) in
                        self.songVolumeLineValue = newVal
                        player.volume = self.songVolumeLineValue
                    }), in: 0...1)
                        .tint(.white)
                        .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                        .frame(width: UIScreen.main.bounds.height/7)
                        .offset(x: UIScreen.main.bounds.width/1.8, y: UIScreen.main.bounds.height/10)
                        .introspectSlider(customize: { slider in
                            slider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
                            //slider.tintColor = .red
                            slider.minimumTrackTintColor = .gray
                            slider.maximumTrackTintColor = UIColor(named: "SliderTindColor")
                        })
                    
                    if !(isPurchased || isWeeklySubscribed || isMonthlySubscribed){
                        
                        if !nativeAdClosed {
                            VStack {
                                //                            Text(errorResolver).foregroundColor(.white).lineLimit(1).font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/200))
                                //                                .frame(width: 0, height: 0)
                                if adStatusVar == 1 {
                                    if let nativeAd = nativeViewController.nativeAds() {
                                        ZStack{
                                            NativeAdView(nativeAd: nativeAd)
                                            //.frame(maxWidth: 300)
                                            
                                            VStack{
                                                HStack{
                                                    Spacer()
                                                    
                                                    Button {
                                                        withAnimation {
                                                            nativeAdClosed = true
                                                        }
                                                        
                                                    } label: {
                                                        Image(systemName: "x.circle.fill")
                                                            .foregroundColor(.black)
                                                            .font(.system(size: UIScreen.main.bounds.height/40))
                                                            .padding(UIScreen.main.bounds.height/100)
                                                            .contentShape(Path(CGRect(x:0, y:0, width: UIScreen.main.bounds.height/40, height: UIScreen.main.bounds.height/40)))
                                                    }
                                                    
                                                }
                                                Spacer()
                                            }.frame(width:UIScreen.main.bounds.width/1.8, height: UIScreen.main.bounds.height/4.5)
                                        }
                                        .frame(maxWidth: 300)
                                    }
                                }
                                else {
                                    
                                    
                                }
                            }
                            .onAppear {
                                self.nativeViewController = NativeViewController2(vari: $adStatusVar)
                                self.nativeViewController.loadAd()
                            }
                        }
                    }
                    
                }
                
                Spacer()
                
                SoundsView(points_state: $points_state, start_point_checked: $start_point_checked, end_point_checked: $end_point_checked, editViewDisplay: $editViewDisplay, initial_audios: $sounds_playing_audios, album_name: $album_name, sound_names: $sound_names, initial_volume: $initial_volume, initial_sounds_array: $initial_sounds_array, initial_volumeValues: $volumeValues, playing_music_realm_id: $playing_music_realm_id, apps_music_bool: $apps_music_bool, playingCreatedMix: $playingCreatedMix, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed, showIAPsView: $showIAPsView)
                    .environmentObject(realManager)
                    .environmentObject(store)
                    .padding(.bottom, UIScreen.main.bounds.height/100)
                
                if album_own_songs.count >= current{
                    Text(album_own_songs[current].song_name)
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/50))
                        .bold()
                        .foregroundColor(.white)
                        .lineLimit(1)
                    
                    
                    
                    Text(album_own_songs[current].artist)
                        .foregroundColor(.gray)
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/60))
                    
                }
                
                
                VStack {
                    HStack{
                        Text(DateComponentsFormatter.positional.string(from: self.player.currentTime) ?? "0:00")
                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/60))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        //.offset(x: UIScreen.main.bounds.height < 750 ? -65 : -85 , y: (width + 60) / 2)
                        
                        Spacer()
                        
                        Text(DateComponentsFormatter.positional.string(from: self.player.duration) ?? "0:00")
                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/60))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        //.offset(x: UIScreen.main.bounds.height < 750 ? 65 : 85 , y: (width + 60) / 2)
                    }
                    
                    //                        .introspectSlider(customize: { slider in
                    //                            slider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
                    //                        })
                    Slider(value: $timeLineValue, in: 0...player.duration){editing in
                        
                        print("editing", editing)
                        isEditing = editing
                        
                        if !editing{
                            player.currentTime = timeLineValue
                        }
                        
                    }
                    .tint(.white)
                    //                        .gesture(DragGesture().onChanged({ value in
                    //
                    //                            if value.location.x >= 0 && value.location.x <= UIScreen.main.bounds.width - 70{
                    ////                                let progress = value.location.x / (UIScreen.main.bounds.width - 70)
                    ////                                let time = TimeInterval(progress) * musicPlayer.player.duration
                    ////                                musicPlayer.player.currentTime = time
                    ////                                let progress = value.location.x / (UIScreen.main.bounds.width - 70)
                    ////                                let time = TimeInterval(progress) * musicPlayer.player.duration
                    ////                                musicPlayer.timeLine = time
                    //
                    //                                let progress = value.location.x / (UIScreen.main.bounds.width - 70)
                    //                                let time = TimeInterval(progress) * player.duration
                    //                                timeLineValue = time
                    //                                //player.currentTime = time
                    //                            }
                    //                        }))
                    
                    
                    
                    
                    
                }
                .frame(width: UIScreen.main.bounds.width - 50)
                
                HStack(spacing: UIScreen.main.bounds.width/15){
                    
                    Button(action: {
                        if isShuffle == false{
                            isShuffle = true
                            
                            let currentPlayingSong = album_own_songs[current]
                            
                            
                            album_own_songs.shuffle()
                            current = album_own_songs.firstIndex(of: currentPlayingSong)!
                        }else{
                            var album_song_names: [String] = []
                            isShuffle = false
                            let currentPlayingSong = album_own_songs[current]
                            
                            //playingCreatedMix = created_mix
                            if apps_music_bool{
                                album_own_songs = getAlbumSongsArray(album_name: album_name).songs_array
                                current = album_own_songs.firstIndex(of: currentPlayingSong)!
                            }else{
                                
                                
                                album_own_songs.removeAll()
                                var i = 0
                                let songs_realm_array = Array(playingCreatedMix.songs)
                                
                                for realmSong in  songs_realm_array{
                                    let url = URL(fileURLWithPath: realmSong.song_filename)
                                    if url.isFileURL{
                                        self.album_own_songs.append(Songs(id: i, album_name: album_name, song_name: realmSong.song_name, song_filename: realmSong.song_filename, artist: realmSong.artist, audio_from_internal_storage: realmSong.audio_from_internal_storage))
                                    }else{
                                        self.album_own_songs.append(Songs(id: i, album_name: album_name, song_name: realmSong.song_name, song_filename: realmSong.song_filename, artist: realmSong.artist, audio_from_internal_storage: realmSong.audio_from_internal_storage))
                                    }
                                    i += 1
                                    
                                }
                                
                                album_own_songs.forEach {song in
                                    album_song_names.append(song.song_name)
                                }
                                current = album_song_names.firstIndex(of: currentPlayingSong.song_name)!
                                //                                    for realmSong in  songs_realm_array{
                                //                                        let url = URL(string: realmSong.song_filename)
                                //                                        if ((url?.isFileURL) != nil){
                                //                                            self.album_own_songs.append(Songs(id: i, album_name: album_name, song_name: realmSong.song_name, song_filename: realmSong.song_filename, artist: realmSong.artist, audio_from_internal_storage: realmSong.audio_from_internal_storage))
                                //                                        }else{
                                //                                            self.album_own_songs.append(Songs(id: i, album_name: album_name, song_name: realmSong.song_name, song_filename: realmSong.song_filename, artist: realmSong.artist, audio_from_internal_storage: realmSong.audio_from_internal_storage))
                                //                                        }
                                //                                        print("items:\(i)")
                                //                                        i += 1
                                //
                                //                                    }
                                
                            }
                            
                            
                        }
                    }) {
                        
                        Image(isShuffle ? "shuffle_active" : "shuffle_enable")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.height/29, height: UIScreen.main.bounds.height/29)
                    }
                    
                    Button(action: {
                        playerStart.player.stop()
                        playerEnd.player.stop()
                        playerStart.player.currentTime = 0
                        playerEnd.player.currentTime = 0
                        endTimer?.invalidate()
                        endTimer = nil
                        playerEnd.player.volume = 1
                        changeSongTimer?.invalidate()
                        changeSongTimer = nil
                        changeSongTimer2?.invalidate()
                        changeSongTimer2 = nil
                        if self.current > 0{
                            
                            self.current -= 1
                            
                            self.ChangeSongs()
                        } else{
                            self.current = album_own_songs.count-1
                            self.ChangeSongs()
                        }
                    }) {
                        
                        Image(systemName: "backward.end.fill")
                            .font(.system(size: UIScreen.main.bounds.height/25))
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        
                        if changeSongTimer != nil{
                            let url = Bundle.main.path(forResource: self.album_own_songs[current].song_filename, ofType: "mp3")
                            
                            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                            
                            self.player.delegate = self.del
                            
                            self.title = ""
                            
                            self.player.prepareToPlay()
                            self.fetchAlbum()
                            
                            //self.isPlaying = true
                            
                            self.finish = false
                        }
                        
                        play()
                        playerStart.player.stop()
                        playerEnd.player.stop()
                        playerStart.player.currentTime = 0
                        playerEnd.player.currentTime = 0
                        endTimer?.invalidate()
                        endTimer = nil
                        playerEnd.player.volume = 1
                        changeSongTimer?.invalidate()
                        changeSongTimer = nil
                        changeSongTimer2?.invalidate()
                        changeSongTimer2 = nil
                        
                        
                    }) {
                        
                        Image(systemName: player.isPlaying ? "pause.fill" : "play.fill")
                            .font(.system(size: UIScreen.main.bounds.height/22))
                            .foregroundColor(.white)
                            .padding(UIScreen.main.bounds.height/42)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.white.opacity(0.1), lineWidth: 2)
                            )
                    }
                    
                    Button(action: {
                        playerStart.player.stop()
                        playerEnd.player.stop()
                        playerStart.player.currentTime = 0
                        playerEnd.player.currentTime = 0
                        endTimer?.invalidate()
                        endTimer = nil
                        playerEnd.player.volume = 1
                        changeSongTimer?.invalidate()
                        changeSongTimer = nil
                        changeSongTimer2?.invalidate()
                        changeSongTimer2 = nil
                        if self.album_own_songs.count-1 != self.current{
                            self.current += 1
                            
                            self.ChangeSongs()
                        } else if self.album_own_songs.count-1 == self.current{
                            self.current = 0
                            
                            self.ChangeSongs()
                        }
                        
                    }) {
                        
                        Image(systemName: "forward.end.fill")
                            .font(.system(size: UIScreen.main.bounds.height/25))
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        if currentRepeatImage < repeatImagesArray.count-1{
                            currentRepeatImage += 1
                        }else{
                            currentRepeatImage = 0
                        }
                        
                    }) {
                        
                        Image(repeatImagesArray[currentRepeatImage])
                            .resizable()
                            .frame(width: UIScreen.main.bounds.height/29, height: UIScreen.main.bounds.height/29)
                    }
                    
                }
                .padding(.top, UIScreen.main.bounds.height/130)
                
                
                
            }.edgesIgnoringSafeArea(.all)
            
            
            
            
            
            
            
            //end of ZStack
        }
        
        .onAppear(perform: {
            
            //            try! self.audioSession.setCategory(.playAndRecord, mode: .spokenAudio, options: [.defaultToSpeaker, .allowAirPlay, .allowBluetoothA2DP])
            //            try! self.audioSession.setActive(true)
            
            //            setupRemoteTransportControls()
            //            setupNowPlaying()
            
            if player != nil{
                self.player.delegate = self.del
                self.fetchAlbum()
            }
            
            
            
            
        })
        //        .onChange(of: editViewDisplay, perform: { newValue ins
        //
        //
        //
        //        })
        
        
        .onReceive(redrawCategoriesPublisher) { notification in
            self.finish = true
            if start_point_checked && end_point_checked{
                print("start & end point clapping")
                playerEnd.player.stop()
                self.player.currentTime = player.duration
                
                playerEnd = Player(urlStr: applause_struct.end_applause_sounds[Int.random(in: 0...(applause_struct.end_applause_sounds.count-1))])
                print(applause_struct.end_applause_sounds[Int.random(in: 0...(applause_struct.end_applause_sounds.count-1))])
                
                for sound_playing_audio in sounds_playing_audios {
                    sound_playing_audio.pause()
                }
                playerEnd.play()
                endTimer = Timer.scheduledTimer(withTimeInterval: playerEnd.player.duration/10, repeats: true) { timer in
                    
                    playerEnd.player.volume -= 0.1
                    print(playerEnd.player.volume)
                }
                
                changeSongTimer = Timer.scheduledTimer(withTimeInterval: playerEnd.player.duration, repeats: false) { timer in
                    endTimer?.invalidate()
                    endTimer = nil
                    playerEnd.player.volume = 1
                    playerStart.player.stop()
                    player.currentTime = 0
                    
                    playerStart = Player(urlStr: applause_struct.start_applause_sounds[Int.random(in: 0...(applause_struct.start_applause_sounds.count-1))])
                    print(applause_struct.start_applause_sounds[Int.random(in: 0...(applause_struct.start_applause_sounds.count-1))])
                    
                    playerStart.play()
                    if currentRepeatImage == 0{
                        if self.album_own_songs.count-1 != self.current{
                            self.current += 1
                            
                            changeSongTimer2 = Timer.scheduledTimer(withTimeInterval: playerStart.player.duration, repeats: false) { timer in
                                
                                self.ChangeSongs()
                                changeSongTimer?.invalidate()
                                changeSongTimer = nil
                            }
                        }
                    }else if currentRepeatImage == 1{
                        if self.album_own_songs.count-1 != self.current{
                            self.current += 1
                            
                            changeSongTimer2 = Timer.scheduledTimer(withTimeInterval: playerStart.player.duration, repeats: false) { timer in
                                
                                self.ChangeSongs()
                                changeSongTimer?.invalidate()
                                changeSongTimer = nil
                            }
                            
                        } else if self.album_own_songs.count-1 == self.current{
                            self.current = 0
                            
                            changeSongTimer2 = Timer.scheduledTimer(withTimeInterval: playerStart.player.duration, repeats: false) { timer in
                                
                                self.ChangeSongs()
                                changeSongTimer?.invalidate()
                                changeSongTimer = nil
                            }
                        }
                    }else{
                        changeSongTimer2 = Timer.scheduledTimer(withTimeInterval: playerStart.player.duration, repeats: false) { timer in
                            
                            self.ChangeSongs()
                            changeSongTimer?.invalidate()
                            changeSongTimer = nil
                        }
                    }
                }
                
                
                
            }else if start_point_checked{
                print("start point clapping")
                
                playerStart.player.stop()
                
                playerStart = Player(urlStr: applause_struct.start_applause_sounds[Int.random(in: 0...(applause_struct.start_applause_sounds.count-1))])
                print(applause_struct.start_applause_sounds[Int.random(in: 0...(applause_struct.start_applause_sounds.count-1))])
                
                for sound_playing_audio in sounds_playing_audios {
                    sound_playing_audio.pause()
                }
                playerStart.play()
                
                if currentRepeatImage == 0{
                    if self.album_own_songs.count-1 != self.current{
                        self.current += 1
                        
                        changeSongTimer = Timer.scheduledTimer(withTimeInterval: playerStart.player.duration, repeats: false) { timer in
                            self.ChangeSongs()
                            changeSongTimer?.invalidate()
                            changeSongTimer = nil
                        }
                    }
                }else if currentRepeatImage == 1{
                    if self.album_own_songs.count-1 != self.current{
                        self.current += 1
                        
                        changeSongTimer = Timer.scheduledTimer(withTimeInterval: playerStart.player.duration, repeats: false) { timer in
                            self.ChangeSongs()
                            changeSongTimer?.invalidate()
                            changeSongTimer = nil
                        }
                        
                    } else if self.album_own_songs.count-1 == self.current{
                        self.current = 0
                        
                        changeSongTimer = Timer.scheduledTimer(withTimeInterval: playerStart.player.duration, repeats: false) { timer in
                            self.ChangeSongs()
                            changeSongTimer?.invalidate()
                            changeSongTimer = nil
                        }
                    }
                }else{
                    
                    changeSongTimer = Timer.scheduledTimer(withTimeInterval: playerStart.player.duration, repeats: false) { timer in
                        self.ChangeSongs()
                        changeSongTimer?.invalidate()
                        changeSongTimer = nil
                    }
                }
                
            }else if end_point_checked{
                print("end point clapping")
                playerEnd.player.stop()
                self.player.currentTime = player.duration
                
                playerEnd = Player(urlStr: applause_struct.end_applause_sounds[Int.random(in: 0...(applause_struct.end_applause_sounds.count-1))])
                print(applause_struct.end_applause_sounds[Int.random(in: 0...(applause_struct.end_applause_sounds.count-1))])
                for sound_playing_audio in sounds_playing_audios {
                    sound_playing_audio.pause()
                }
                playerEnd.play()
                if playerEnd.isPlaying{
                    endTimer = Timer.scheduledTimer(withTimeInterval: playerEnd.player.duration/10, repeats: true) { timer in
                        
                        playerEnd.player.volume -= 0.1
                        print(playerEnd.player.volume)
                    }
                    changeSongTimer = Timer.scheduledTimer(withTimeInterval: playerEnd.player.duration, repeats: false) { timer in
                        endTimer?.invalidate()
                        endTimer = nil
                        playerEnd.player.volume = 1
                        if currentRepeatImage == 0{
                            if self.album_own_songs.count-1 != self.current{
                                self.current += 1
                                
                                self.ChangeSongs()
                                changeSongTimer?.invalidate()
                                changeSongTimer = nil
                            }
                        }else if currentRepeatImage == 1{
                            if self.album_own_songs.count-1 != self.current{
                                self.current += 1
                                self.ChangeSongs()
                                changeSongTimer?.invalidate()
                                changeSongTimer = nil
                            } else if self.album_own_songs.count-1 == self.current{
                                self.current = 0
                                self.ChangeSongs()
                                changeSongTimer?.invalidate()
                                changeSongTimer = nil
                            }
                        }else{
                            
                            self.ChangeSongs()
                            changeSongTimer?.invalidate()
                            changeSongTimer = nil
                        }
                    }
                }
            }
            else{
                print("isn't clapping")
                if currentRepeatImage == 0{
                    if self.album_own_songs.count-1 != self.current{
                        self.current += 1
                        
                        self.ChangeSongs()
                    } else{
                        for sound_playing_audio in sounds_playing_audios {
                            sound_playing_audio.pause()
                        }
                        print("Album fuc# ended")
                    }
                }else if currentRepeatImage == 1{
                    if self.album_own_songs.count-1 != self.current{
                        self.current += 1
                        self.ChangeSongs()
                    } else if self.album_own_songs.count-1 == self.current{
                        self.current = 0
                        self.ChangeSongs()
                    }
                }else{
                    
                    self.ChangeSongs()
                }
            }
        }
        
        
    }
    
    func sliderChanged() {
        print("Slider value changed to \(songVolumeLineValue)")
    }
//
//    func setupRemoteTransportControls() {
//        let commandCenter = MPRemoteCommandCenter.shared()
//
//        commandCenter.playCommand.isEnabled = true
//        commandCenter.playCommand.addTarget { [self] event in
//            if !self.player.isPlaying {
//
//                if changeSongTimer != nil{
//                    let url = Bundle.main.path(forResource: self.album_own_songs[current].song_filename, ofType: "mp3")
//
//                    self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
//
//                    self.player.delegate = self.del
//
//                    self.title = ""
//
//                    self.player.prepareToPlay()
//                    self.fetchAlbum()
//
//                    // self.isPlaying = true
//
//                    self.finish = false
//                }
//
//                play()
//                playerStart.player.stop()
//                playerEnd.player.stop()
//                playerStart.player.currentTime = 0
//                playerEnd.player.currentTime = 0
//                endTimer?.invalidate()
//                endTimer = nil
//                playerEnd.player.volume = 1
//                changeSongTimer?.invalidate()
//                changeSongTimer = nil
//                changeSongTimer2?.invalidate()
//                changeSongTimer2 = nil
//                return .success
//            }
//            return .commandFailed
//        }
//
//        commandCenter.pauseCommand.isEnabled = true
//        commandCenter.pauseCommand.addTarget { [self] event in
//            if self.player.isPlaying {
//                if changeSongTimer != nil{
//                    let url = Bundle.main.path(forResource: self.album_own_songs[current].song_filename, ofType: "mp3")
//
//                    self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
//
//                    self.player.delegate = self.del
//
//                    self.title = ""
//
//                    self.player.prepareToPlay()
//                    self.fetchAlbum()
//
//                    // self.isPlaying = true
//
//                    self.finish = false
//                }
//
//                play()
//                playerStart.player.stop()
//                playerEnd.player.stop()
//                playerStart.player.currentTime = 0
//                playerEnd.player.currentTime = 0
//                endTimer?.invalidate()
//                endTimer = nil
//                playerEnd.player.volume = 1
//                changeSongTimer?.invalidate()
//                changeSongTimer = nil
//                changeSongTimer2?.invalidate()
//                changeSongTimer2 = nil
//                return .success
//            }
//            return .commandFailed
//        }
//
//        commandCenter.nextTrackCommand.isEnabled = true
//        commandCenter.nextTrackCommand.addTarget { [self] event in
//            playerStart.player.stop()
//            playerEnd.player.stop()
//            playerStart.player.currentTime = 0
//            playerEnd.player.currentTime = 0
//            endTimer?.invalidate()
//            endTimer = nil
//            playerEnd.player.volume = 1
//            changeSongTimer?.invalidate()
//            changeSongTimer = nil
//            changeSongTimer2?.invalidate()
//            changeSongTimer2 = nil
//            if self.album_own_songs.count-1 != self.current{
//                self.current += 1
//
//                self.ChangeSongs()
//            } else if self.album_own_songs.count-1 == self.current{
//                self.current = 0
//
//                self.ChangeSongs()
//            }
//            return .commandFailed
//        }
//
//        commandCenter.previousTrackCommand.isEnabled = true
//        commandCenter.previousTrackCommand.addTarget { [self] event in
//            playerStart.player.stop()
//            playerEnd.player.stop()
//            playerStart.player.currentTime = 0
//            playerEnd.player.currentTime = 0
//            endTimer?.invalidate()
//            endTimer = nil
//            playerEnd.player.volume = 1
//            changeSongTimer?.invalidate()
//            changeSongTimer = nil
//            changeSongTimer2?.invalidate()
//            changeSongTimer2 = nil
//            if self.current > 0{
//
//                self.current -= 1
//
//                self.ChangeSongs()
//            } else{
//                self.current = album_own_songs.count-1
//                self.ChangeSongs()
//            }
//            return .commandFailed
//        }
//
//        commandCenter.changePlaybackPositionCommand.isEnabled = true
//        commandCenter.changePlaybackPositionCommand.addTarget { event in
//            if let event = event as? MPChangePlaybackPositionCommandEvent {
//                player.currentTime = event.positionTime
//            }
//            return .success
//        }
//
//    }
    
    
    
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
    
    func ChangeSongs(){
        self.player.stop()
        
        self.player = nil
        
        var url = Bundle.main.path(forResource: self.album_own_songs[current].song_filename, ofType: "mp3")
        
        if url == nil{
            url = self.album_own_songs[current].song_filename
            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
        }else{
            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
        }
        
        self.player.delegate = self.del
        
        self.title = ""
        
        self.player.prepareToPlay()
        self.fetchAlbum()
        
        //self.isPlaying = true
        
        self.finish = false
        
        //setupRemoteTransportControls()
        setupNowPlaying()
        
        self.player.volume = self.songVolumeLineValue
        
        self.player.play()
        
        for sound_playing_audio in sounds_playing_audios {
            sound_playing_audio.play()
        }
    }
    
    
    
    func fetchAlbum(){
        let asset = AVAsset(url: self.player.url!)
        
        for i in asset.commonMetadata{
            
            if i.commonKey?.rawValue == "artist"{
                let artist = i.value as! String
                self.artist = artist
            }
            
            if i.commonKey?.rawValue == "title"{
                let title = i.value as! String
                self.title = title
            }
        }
        
        //fetching audio volume level....
        volume = CGFloat(player.volume) * (UIScreen.main.bounds.width - 180)
        
        timeLine = CGFloat(player.currentTime) * (UIScreen.main.bounds.width - 70)
    }
    
    func updateTimeLine(value: DragGesture.Value){
        
        if value.location.x >= 0 && value.location.x <= UIScreen.main.bounds.width - 70{
            
            //updating volume
            let progress = value.location.x / (UIScreen.main.bounds.width - 70)
            let time = TimeInterval(progress) * player.duration
            player.currentTime = time
            player.play()
            withAnimation(Animation.linear(duration: 0.1)){
                self.timeLine = value.location.x
                
                if playerStart.player.isPlaying{
                    self.ChangeSongs()
                    print("changed")
                }
                playerStart.player.stop()
                playerEnd.player.stop()
                playerStart.player.currentTime = 0
                playerEnd.player.currentTime = 0
                endTimer?.invalidate()
                endTimer = nil
                playerEnd.player.volume = 1
                changeSongTimer?.invalidate()
                changeSongTimer = nil
                changeSongTimer2?.invalidate()
                changeSongTimer2 = nil
                
            }
        }
    }
    
    //    func onChanged(value: DragGesture.Value){
    //
    //        let vector = CGVector(dx: value.location.x, dy: value.location.y)
    //
    //        //12.5 = 25 => Circle Radius
    //
    //        let radians = atan2(vector.dy - 12.5, vector.dx - 12.5)
    //        let tempAngle = radians * 180 / .pi
    //
    //        let angle = tempAngle < 0 ? 360 + tempAngle : tempAngle
    //
    //        //since maximum slide is 0.8
    //        //0.8*36 = 288
    //        if angle <= 288{
    //
    //            //getting time...
    //            let progress = angle / 288
    //            let time = TimeInterval(progress) * player.duration
    //            player.currentTime = time
    //            player.play()
    //            withAnimation(Animation.linear(duration: 0.1)){self.angle = Double(angle)}
    //        }
    //    }
    
    func play(){
        if player.isPlaying{
            player.pause()
            for sound_playing_audio in sounds_playing_audios {
                sound_playing_audio.pause()
            }
        }
        else{
            if self.finish{
                
                self.player.currentTime = 0
                self.width = 0
                self.finish = false
            }
            
            player.play()
            for sound_playing_audio in sounds_playing_audios {
                sound_playing_audio.play()
            }
        }
        //isPlaying = player.isPlaying
    }
    
    //    func updateTimer(){
    //
    //        if self.player != nil {
    //            currentTime = player.currentTime
    //            duration = player.duration
    //            let progress = currentTime / duration
    //
    //            withAnimation(Animation.linear(duration: 0.1)){
    //                self.timeLine = Double(progress) * (UIScreen.main.bounds.width - 70)
    //            }
    //
    //        }
    //    }
    
    func getCurrentTime(value: TimeInterval) -> String{
        
        return "\(Int(value / 60)):\(Int(value.truncatingRemainder(dividingBy:60)) < 9 ? "0" : "")\(Int(value.truncatingRemainder(dividingBy:60)))"
    }
    
    
    
}



struct SoundsView: View{
    @EnvironmentObject var store: Store
    @EnvironmentObject var realManager: RealmManager
    @Binding var points_state: [Bool]
    @Binding var start_point_checked: Bool
    @Binding var end_point_checked: Bool
    
    @State var sounds_Images: [String] = ["beach-33", "bird-33"]
    @State var sounds_percent: [Int] = [50, 20]
    @Binding var editViewDisplay: Bool
    
    @Binding public var initial_audios: [AVAudioPlayer]
    @Binding public var album_name: String
    @Binding var sound_names: [String]
    @Binding var initial_volume: [CGFloat]
    @Binding var initial_sounds_array: [Sound]
    @Binding var initial_volumeValues: [Double]
    @Binding public var playing_music_realm_id: ObjectId
    @Binding public var apps_music_bool: Bool
    @Binding var playingCreatedMix: CreatedMix
    @Binding var isPurchased: Bool
    @Binding var isMonthlySubscribed: Bool
    @Binding var isWeeklySubscribed: Bool
    @Binding var showIAPsView: Bool
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.width/80){
            //  if !editViewDisplay{
            if initial_sounds_array.count > 0{
                VStack{
                    ZStack(alignment: .topTrailing) {
                        Image(initial_sounds_array[0].sound_image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.height/12, height: UIScreen.main.bounds.height/12)
                        
                        Button {
                            if initial_sounds_array.count > 0 {
                                withAnimation(.spring()) {
                                    initial_audios[0].stop()
                                    initial_audios.remove(at: 0)
                                    
                                    sound_names.remove(at: 0)
                                    initial_sounds_array.remove(at: 0)
                                }
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white)
                                .font(.system(size: UIScreen.main.bounds.height/40))
                        }
                    }
                    
                    Text("\(String(format: "%.0f", initial_audios[0].volume*100))%")
                        .foregroundColor(.white)
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/60))
                        .padding(.top, 5)
                }
                
                if initial_sounds_array.count >= 2 {
                    VStack{
                        ZStack(alignment: .topTrailing) {
                            Image(initial_sounds_array[1].sound_image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.height/12, height: UIScreen.main.bounds.height/12)
                            
                            Button {
                                if initial_sounds_array.count > 1 {
                                    withAnimation(.spring()) {
                                        initial_audios[1].stop()
                                        initial_audios.remove(at: 1)
                                        
                                        sound_names.remove(at: 1)
                                        initial_sounds_array.remove(at: 1)
                                    }
                                }
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: UIScreen.main.bounds.height/40))
                            }
                        }
                        
                        Text("\(String(format: "%.0f", initial_audios[1].volume*100))%")
                            .foregroundColor(.white)
                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/60))
                            .padding(.top, 5)
                    }
                }
            }
            VStack{
                Button {
                    
                    editViewDisplay = true
                    
                } label: {
                    ZStack (alignment: .bottomTrailing){
                        Image("edit_sounds")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.height/12, height: UIScreen.main.bounds.height/12)
                        
                        if sound_names.count>0{
                            ZStack{
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.height/50, height: UIScreen.main.bounds.height/50)
                                
                                Text("\(initial_sounds_array.count)")
                                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/60))
                                    .foregroundColor(.black)
                                
                            }
                            .padding(UIScreen.main.bounds.height/65)
                        }
                    }
                }
                Text("Edit")
                    .foregroundColor(.white)
                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/60))
                    .padding(.top, 5)
            }
            //   }
        }
        //.background(.green)
        
        
        .fullScreenCover(isPresented: $editViewDisplay){
            EditSoundsView(points_state: $points_state, start_point_checked: $start_point_checked,end_point_checked: $end_point_checked , initial_volume: $initial_volume, editViewDisplay: $editViewDisplay, sound_names: $sound_names, initial_audios: $initial_audios, initial_sounds_array: $initial_sounds_array, initial_volumeValues: $initial_volumeValues, playing_music_realm_id: $playing_music_realm_id, apps_music_bool: $apps_music_bool, album_name: $album_name, playingCreatedMix: $playingCreatedMix, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed, showIAPsView: $showIAPsView)
                .environmentObject(realManager)
                .environmentObject(store)
        }
        
        .onAppear {
            
            
        }
        
        .onDisappear {
            
        }
    }
}

//struct PlayerView_Previews: PreviewProvider {
//    @State static var change = false
//    @State static var album_name = "false"
//    @State static var songs = [Songs]()
//    @State static var height_floating_player: CGFloat = 0
//    @State static var currentTime: TimeInterval = 0
//    static var previews: some View {
//        //        PlayerView(currentTime: $currentTime, isPlaying: $change, height: $height_floating_player, open: $change, album_name: $album_name, album_own_songs: $songs)
//        SoundsView()
//    }
//}

class AVdelegate: NSObject, AVAudioPlayerDelegate{
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name("Finish"), object: nil)
        print("songfinished")
    }
    
    
}



class getAlbumSoundsNamesArray {
    let album_name: String
    
    init(album_name: String){
        self.album_name = album_name
    }
    
    let all_album_sounds = AlbumSoundsData()
    lazy var sounds_array: [AlbumSound] = getSoundArray()
    
    func getSoundArray() -> [AlbumSound]{
        var this_sounds_array = [AlbumSound]()
        for one_of_all_sounds in self.all_album_sounds.album_sounds_data_array{
            if one_of_all_sounds.sound_album_name == album_name {
                this_sounds_array.append(one_of_all_sounds)
            }
        }
        
        return this_sounds_array
    }
}


class getAlbumSoundsArray {
    let sound_id: Int
    
    init(sound_id: Int){
        self.sound_id = sound_id
    }
    
    let all_sounds = SoundsData()
    lazy var sounds_array: [Sound] = getSoundArray()
    
    func getSoundArray() -> [Sound]{
        var this_sounds_array = [Sound]()
        for one_of_all_sounds in self.all_sounds.sounds_data{
            if one_of_all_sounds.id == sound_id {
                this_sounds_array.append(one_of_all_sounds)
            }
        }
        
        return this_sounds_array
    }
}
