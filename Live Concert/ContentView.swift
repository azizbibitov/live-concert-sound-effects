//
//  ContentView.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 16.02.2022.
//

import SwiftUI
import Introspect
import AVKit
import RealmSwift
import MediaPlayer



struct ContentView: View {
    @State var player : AVAudioPlayer!
    @State private var open = true
    @State public var closed = true
    @State private var album_name = "Default"
    @State private var name = "awda"
    @State private var album_id = 0
    @State private var album_own_songs = [Songs]()
    @State var height_floating_player: CGFloat = 1800
    @State var uiTabarController: UITabBarController?
    @State var showFilter = false
    @State var current = 0
    @StateObject var realManager = RealmManager()
    @State var album_cover: String = "night_music"
    @State public var player_called_from: String = ""
    @State public var users_music_closed: Bool = true
    @State var sound_names: [String] = ["Beach", "Birds"]
    @State var initial_volume: [CGFloat] = []
    @State var initial_sounds_array: [Sound] = []
    @State var sounds_playing_audios: [AVAudioPlayer] = []
    @State public var apps_music_bool: Bool = false
    @State var showMixEdit = false
    @State public var playing_music_realm_id = ObjectId()
    @State var volumeValues: [Double] = []
    @State var tabBarPadding: CGFloat = 0
    @State var offsetinHomeView: CGFloat = 0
    @State var playingCreatedMix = CreatedMix()
    @State var tabChangeBool: Bool = true
    @State var currentRepeatImage: Int = 0
    @State var isShuffle = false
    @State var finish = false
    @StateObject var myTimer = MyTimer()
    @State var del = AVdelegate()
    @State var playerStart = Player(urlStr: "large-crowd-applause")
    @State var playerEnd = Player(urlStr: "large-crowd-applause")
    @State var changeSongTimer: Timer? = nil
    @State var changeSongTimer2: Timer? = nil
    @State var endTimer: Timer? = nil
    @State var start_point_checked: Bool = false
    @State var end_point_checked: Bool = false
    @State var errorOffset: CGFloat = 8.0
    @StateObject var store: Store = Store()
    @State var isPurchased: Bool = true
    @State var isMonthlySubscribed = false
    @State var isWeeklySubscribed = false
    @State var showIAPsView: Bool = false
    private let audioSession = AVAudioSession.sharedInstance()
    @State var interstitial : InterstitialAd?
    @State var playing: Bool!
    @StateObject var determineShowingAd = ShouldShowAd()
    @State var songVolumeLineValue: Float = 1.0
    @State var addedLocalSongUrls: [URL] = []
    @State var addLocalSongWhenCreate: Bool = true
    @State var interstitialAdNoCompletion: InterstitialAdNoCompletion?
    @State var deletingMixId: ObjectId!
    
//
//    init() {
//        UITabBar.appearance().unselectedItemTintColor = .gray
    //        UITabBar.appearance().backgroundColor = UIColor(named: "TabBarBackground")
    //        UITabBar.appearance().barTintColor = UIColor(named: "TabBarBackground")
    //        tabBarPadding = UITabBar.appearance().frame.height
    //        print("pppppppppppppppppppplplp\(tabBarPadding)")
    //    }
    
    var body: some View {
        TabView{
            
            HomeView(player: $player, height: $height_floating_player, open: $open, closed: $closed, album_name: $album_name, album_own_songs: $album_own_songs, current: $current, album_cover: $album_cover, showFilter: $showFilter, player_called_from: $player_called_from, sound_names: $sound_names, initial_volume: $initial_volume, initial_sounds_array: $initial_sounds_array, sounds_playing_audios: $sounds_playing_audios, apps_music_bool: $apps_music_bool, initial_volumeValues: $volumeValues, tabBarHeight: $tabBarPadding, offsetinHomeView: $offsetinHomeView, errorOffset: $errorOffset, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed, showIAPsView: $showIAPsView, songVolumeLineValue: $songVolumeLineValue, isShuffle: $isShuffle)
                .background(TabBarAccessor { tabBar in
                    tabBarPadding = tabBar.bounds.height
                    //print("pppppppppppppppppppp\(tabBarPadding)")
                })
                .tabItem {
                    Image(systemName: "music.note.house.fill")
                    Text("Home")
                }
                .environmentObject(store)
     
            
            ExploreView(open: $open, closed: $closed, height: $height_floating_player, album_name: $album_name, album_own_songs: $album_own_songs, album_cover: $album_cover, uiTabarController: $uiTabarController, player: $player, current: $current, player_called_from: $player_called_from, users_music_closed: $users_music_closed, initial_volume: $initial_volume, sound_names: $sound_names, initial_sounds_array: $initial_sounds_array, sounds_playing_audios: $sounds_playing_audios, apps_music_bool: $apps_music_bool, showMixEdit: $showMixEdit, playing_music_realm_id: $playing_music_realm_id, initial_volumeValues: $volumeValues, playingCreatedMix: $playingCreatedMix, tabChangeBool: $tabChangeBool, finish: $finish, changeSongTimer: $changeSongTimer, changeSongTimer2: $changeSongTimer2, endTimer: $endTimer, del: $del, playerStart: $playerStart, playerEnd: $playerEnd, showIAPsView: $showIAPsView, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed, interstitial: $interstitial, playing: $playing, songVolumeLineValue: $songVolumeLineValue, isShuffle: $isShuffle, addedLocalSongUrls: $addedLocalSongUrls, addLocalSongWhenCreate: $addLocalSongWhenCreate, interstitialAdNoCompletion: $interstitialAdNoCompletion, deletingMixId: $deletingMixId, height_floating_player: $height_floating_player)
                .tabItem {
                    Image(systemName: "safari.fill")
                    Text("Discover")
                }
                .environmentObject(realManager)
                .environmentObject(determineShowingAd)
                .environmentObject(store)
//                .environmentObject(playerStart)
//                .environmentObject(playerEnd)
            
            SettingsView(showIAPsView: $showIAPsView, isMonthlySubscribed: $isMonthlySubscribed)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                
                .environmentObject(store)
        }
        .accentColor(.white)
        .overlay(
            Music(sounds_playing_audios: $sounds_playing_audios, player: $player, closed: $closed, height: $height_floating_player, open: $open, album_name: $album_name, album_own_songs: $album_own_songs, current: $current, album_cover: $album_cover, player_called_from: $player_called_from, users_music_closed: $users_music_closed, sound_names: $sound_names, initial_volume: $initial_volume, initial_sounds_array: $initial_sounds_array, apps_music_bool: $apps_music_bool, showMixEdit: $showMixEdit, playing_music_realm_id: $playing_music_realm_id, volumeValues: $volumeValues, tabBarHeight: $tabBarPadding, playingCreatedMix: $playingCreatedMix, tabChangeBool: $tabChangeBool, currentRepeatImage: $currentRepeatImage, isShuffle: $isShuffle, finish: $finish, changeSongTimer: $changeSongTimer, changeSongTimer2: $changeSongTimer2, endTimer: $endTimer, del: $del, start_point_checked: $start_point_checked, end_point_checked: $end_point_checked, playerStart: $playerStart, playerEnd: $playerEnd, errorOffset: $errorOffset, offsetinHomeView: $offsetinHomeView, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed, showIAPsView: $showIAPsView, interstitial: $interstitial, playing: $playing, songVolumeLineValue: $songVolumeLineValue, addedLocalSongUrls: $addedLocalSongUrls, addLocalSongWhenCreate: $addLocalSongWhenCreate)
                .environmentObject(realManager)
                .environmentObject(myTimer)
                .environmentObject(store)
                .environmentObject(determineShowingAd)
//                .environmentObject(playerStart)
//                .environmentObject(playerEnd)
                
        )
        
        .onChange(of: store.cars, perform: { cars in
            Task {
                if !UserDefaults.standard.bool(forKey: "isPurchased") {
                    isPurchased = (try? await store.isPurchased(store.cars[0].id)) ?? false
                    UserDefaults.standard.set(isPurchased, forKey: "isPurchased")
                }
                if !UserDefaults.standard.bool(forKey: "isMonthlySubscribed") {
                    isMonthlySubscribed = (try? await store.isPurchased(store.subscriptions[1].id)) ?? false
                    UserDefaults.standard.set(isMonthlySubscribed, forKey: "isMonthlySubscribed")
                }
                if !UserDefaults.standard.bool(forKey: "isWeeklySubscribed") {
                    isWeeklySubscribed = (try? await store.isPurchased(store.subscriptions[0].id)) ?? false
                    UserDefaults.standard.set(isWeeklySubscribed, forKey: "isWeeklySubscribed")
                }
            }
//            Task {
//                if store.cars.count != 0 {
//                    isPurchased = (try? await store.isPurchased(store.cars[0].id)) ?? false
//                    isMonthlySubscribed = (try? await store.isPurchased(store.subscriptions[1].id)) ?? false
//                    isWeeklySubscribed = (try? await store.isPurchased(store.subscriptions[0].id)) ?? false
//                    print(isPurchased)
//                    if offsetinHomeView > 200{
//                        errorOffset = UIScreen.main.bounds.height*340/844
//                    }
//                }else{
//                    print("== to null")
//                }
//            }
        })
        
        .onAppear {
            
            if UserDefaults.standard.bool(forKey: "isPurchased") {
                isPurchased = UserDefaults.standard.bool(forKey: "isPurchased")
            }
//            else {
//                Task {
//                    if store.cars.count != 0 {
//                        isPurchased = (try? await store.isPurchased(store.cars[0].id)) ?? false
//                    }else{
//                        print("== to null")
//                    }
//                }
//            }
            
            if UserDefaults.standard.bool(forKey: "isMonthlySubscribed") {
                isMonthlySubscribed = UserDefaults.standard.bool(forKey: "isMonthlySubscribed")
            }
            
            if UserDefaults.standard.bool(forKey: "isWeeklySubscribed") {
                isWeeklySubscribed = UserDefaults.standard.bool(forKey: "isWeeklySubscribed")
            }
            
            let standardAppearance = UITabBarAppearance()
            standardAppearance.configureWithDefaultBackground()
            standardAppearance.backgroundColor = UIColor(named: "TabBarBackground")
            UITabBar.appearance().standardAppearance = standardAppearance
            
            let scrollEdgeAppearance = UITabBarAppearance()
            scrollEdgeAppearance.configureWithTransparentBackground()
            scrollEdgeAppearance.backgroundColor = UIColor(named: "TabBarBackground")
            UITabBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
            
            try! self.audioSession.setCategory(.playAndRecord, mode: .spokenAudio, options: [.defaultToSpeaker, .allowAirPlay, .allowBluetoothA2DP])
            try! self.audioSession.setActive(true)
            

            setupRemoteTransportControls()
            
            interstitialAdNoCompletion = InterstitialAdNoCompletion(completion: {
                realManager.deleteCreatedMix(id: deletingMixId)
                
                if playing_music_realm_id == deletingMixId {
                    height_floating_player = 1800
                }else{
                    if player != nil{
                        if playing{
                            player.play()
                            for sound_playing_audio in sounds_playing_audios {
                                sound_playing_audio.play()
                            }
                        }
                    }
                }
                
            })
            
          
            interstitial = InterstitialAd(completion: {
//                print("time to 0")
//                determineShowingAd.time = 0
                //determineShowingAd.determizer()
                if player != nil{
                    if playing{
                        player.play()
                        for sound_playing_audio in sounds_playing_audios {
                            sound_playing_audio.play()
                        }
                    }
                }
            })
            
        }
        
        //        .fullScreenCover(isPresented: $open, content: {
        //            MusicPlayerView(album_id: $album_id, open: $open, album_name: $album_name, album_own_songs: $album_own_songs)
        //        })
        
        //        .fullScreenCover(isPresented: $open) {
        //            MusicPlayerView(open: $open, album_name: $album_name)
        //        }
        
        .introspectTabBarController { (UITabBarController) in
            
            if self.open{
                withAnimation(.easeInOut(duration: 1.5)){
                uiTabarController?.tabBar.isHidden = false
                }
                
            }else{
                withAnimation(.easeInOut(duration: 1.5)){
                UITabBarController.tabBar.isHidden = true
                uiTabarController = UITabBarController
                }
            }
        }
    }
    
    func setupRemoteTransportControls() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [self] event in
            if !self.player.isPlaying {
                
                   if changeSongTimer != nil{
                       let url = Bundle.main.path(forResource: self.album_own_songs[current].song_filename, ofType: "mp3")
                       
                       self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                       
                       self.player.delegate = self.del
                       
                       //self.title = ""
                       
                       self.player.prepareToPlay()
                      // self.fetchAlbum()
                       
                      // self.isPlaying = true
                       
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
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [self] event in
            if self.player.isPlaying {
                if changeSongTimer != nil{
                    let url = Bundle.main.path(forResource: self.album_own_songs[current].song_filename, ofType: "mp3")
                    
                    self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                    
                    self.player.delegate = self.del
                    
                 //   self.title = ""
                    
                    self.player.prepareToPlay()
                 //   self.fetchAlbum()
                    
                   // self.isPlaying = true
                    
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
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.nextTrackCommand.isEnabled = true
        commandCenter.nextTrackCommand.addTarget { [self] event in
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
            return .commandFailed
        }
        
        commandCenter.previousTrackCommand.isEnabled = true
        commandCenter.previousTrackCommand.addTarget { [self] event in
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
            return .commandFailed
        }
        
        commandCenter.changePlaybackPositionCommand.isEnabled = true
        commandCenter.changePlaybackPositionCommand.addTarget { event in
              if let event = event as? MPChangePlaybackPositionCommandEvent {
                  player.currentTime = event.positionTime
              }
              return .success
          }
        
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
        
       // self.title = ""
        
        self.player.prepareToPlay()
        //self.fetchAlbum()
        
        //self.isPlaying = true
        
        self.finish = false
        
        //setupRemoteTransportControls()
        setupNowPlaying()
        
        self.player.volume = self.songVolumeLineValue
        
        self.player.play()
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
                //self.width = 0
                self.finish = false
            }
            
            player.play()
            for sound_playing_audio in sounds_playing_audios {
                sound_playing_audio.play()
            }
        }
        //isPlaying = player.isPlaying
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Music: View {
    @EnvironmentObject var determineShowingAd: ShouldShowAd
    @EnvironmentObject var store: Store
    @EnvironmentObject var realManager: RealmManager
    @EnvironmentObject var myTimer: MyTimer
    @Binding public var sounds_playing_audios: [AVAudioPlayer]
    @Binding public var player: AVAudioPlayer!
    @Binding public var closed: Bool
    @Binding public var height: CGFloat
    @Binding public var open: Bool
    @Binding public var album_name: String
    @Binding public var album_own_songs: [Songs]
    @State private var high: CGFloat = 0
    
    @State var progress: CGFloat = 0
    
    @State var fade = 1.0
    @State var timeLineValue: Double = 0.0
    @State var isEditing: Bool = false
    @State var gradient = [Color("EditBackColor"), Color("explore_back_color")]
    @State var startPoint = UnitPoint(x: 1, y: 0)
    @State var endPoint = UnitPoint(x: 5, y: 0)
  
    
    @State var errorResolver: String = ""
    @State var opacity: Double = 1
    @State var currentTime1: TimeInterval = 0
    @State public var isPlaying1: Bool = false
    @Binding public var current: Int
    @Binding public var album_cover: String
    @Binding public var player_called_from: String
    @Binding public var users_music_closed: Bool
    @Binding var sound_names: [String]
    @Binding var initial_volume: [CGFloat]
    @Binding var initial_sounds_array: [Sound]
    @Binding public var apps_music_bool: Bool
    @Binding public var showMixEdit: Bool
    @Binding public var playing_music_realm_id: ObjectId
    @Binding var volumeValues: [Double]
    @Binding var tabBarHeight: CGFloat
    @Binding var playingCreatedMix: CreatedMix
    @Binding var tabChangeBool: Bool
    @Binding var currentRepeatImage: Int
    @Binding var isShuffle: Bool
    @Binding var finish: Bool
    @Binding var changeSongTimer: Timer?
    @Binding var changeSongTimer2: Timer?
    @Binding var endTimer: Timer?
    @Binding var del: AVdelegate
    @Binding var start_point_checked: Bool
    @Binding var end_point_checked: Bool
    @Binding var playerStart: Player
    @Binding var playerEnd: Player
    @Binding var errorOffset: CGFloat
    @Binding var offsetinHomeView: CGFloat
    @Binding var isPurchased: Bool
    @Binding var isMonthlySubscribed: Bool
    @Binding var isWeeklySubscribed: Bool
    @Binding var showIAPsView: Bool
    @Binding var interstitial : InterstitialAd?
    @Binding var playing: Bool!
    @Binding var songVolumeLineValue: Float
    @Binding var addedLocalSongUrls: [URL]
    @Binding var addLocalSongWhenCreate: Bool
    
    
    
    let data = AlbumData()
    
    
    var body: some View{
        
        
        
        GeometryReader{geo in
            
            
            VStack(spacing: 35) {
                if open {
                    HStack {
                        // resizing image
                        
                        HStack(spacing: 15){
                            Image(album_cover)
                                .resizable()
                                .scaledToFill()
                                .frame(width: !open ? 250 : UIScreen.main.bounds.width/6, height: !open ? 250 : UIScreen.main.bounds.height/14)
                                .cornerRadius(10)
                            
                         
                            VStack(alignment: .leading, spacing: 4) {
                                Text(album_name).foregroundColor(.white).lineLimit(1).font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/43))
                                if player != nil{
                                    Text(DateComponentsFormatter.positional.string(from: self.currentTime1) ?? "0:00").font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/50)).foregroundColor(.gray)
                                }
                                Text(errorResolver).foregroundColor(.white).lineLimit(1).font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/200))
                                    .frame(width: 0, height: 0)
                            }
                        }
                        .padding(.leading, 30)
                        
                        Spacer()
                        HStack(spacing: 15) {
                            Button(action: {
   
                                
                                if changeSongTimer != nil{
                                    var url = Bundle.main.path(forResource: self.album_own_songs[current].song_filename, ofType: "mp3")
                                    if url == nil{
                                        url = self.album_own_songs[current].song_filename
                                        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                                    }
                                    
                                    self.player.delegate = self.del
                                    
                                    //self.title = ""
                                    
                                    self.player.prepareToPlay()
                                    //self.fetchAlbum()
                                    
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
                                if player != nil{
                                    Image(systemName: isPlaying1 ? "pause.fill" : "play.fill")
                                        .font(.system(size: UIScreen.main.bounds.height/25))
                                        .foregroundColor(.white)
                                }
                                
                            }
                            
                            Button(action: {
                                determineShowingAd.clickTrigger()
                                determineShowingAd.determizer()
                                if determineShowingAd.shouldShowAd && !(isPurchased || isWeeklySubscribed || isMonthlySubscribed) && interstitial!.loaded{
                                    if player != nil{
                                        playing = player.isPlaying
                                        if player.isPlaying{
                                            player.stop()
                                            for sound_playing_audio in sounds_playing_audios {
                                                sound_playing_audio.stop()
                                            }
                                        }
                                    }
                                    interstitial?.show()
                                    print("Yeee")
                                }else{
                                    self.height = 1800
                                    player.stop()
                                    for sound_playing_audio in sounds_playing_audios {
                                        sound_playing_audio.stop()
                                    }
                                    if changeSongTimer != nil{
                                        var url = Bundle.main.path(forResource: self.album_own_songs[current].song_filename, ofType: "mp3")
                                        if url == nil{
                                            url = self.album_own_songs[current].song_filename
                                            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                                        }

                                        self.player.delegate = self.del

                                        //self.title = ""

                                        self.player.prepareToPlay()
                                        //self.fetchAlbum()

                                        //self.isPlaying = true

                                        self.finish = false
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
                                    sounds_playing_audios.removeAll()
                                    volumeValues.removeAll()
                                    initial_sounds_array.removeAll()
                                    initial_volume.removeAll()
                                }

                            }) {
                                Image(systemName: "xmark")
                                    .font(.system(size: UIScreen.main.bounds.height/25))
                                    .foregroundColor(.white)
                            }
                            
                        }
                        .padding(.trailing, UIScreen.main.bounds.width/30)
                        
                        
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/9)
                    .background(
                        BlurView(style: .dark)
                            .cornerRadius(UIScreen.main.bounds.height/50).padding(.horizontal, UIScreen.main.bounds.width/60)
//
//                        RoundedRectangle(cornerRadius: 0)
//                            .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
//                            .edgesIgnoringSafeArea(.all)
                    )
                    Spacer()
                 
                }
                // moving view up
                //                if !floating{
                //                    MusicPlayerView(height: $height, album_id: $id, open: $open, album_name: $album_name, album_own_songs: $album_own_songs)
                //                        .opacity(floating ? 0 : 1)
                //                }
                
                if album_own_songs.count != 0 {
                    
                   // if player_called_from == "apps_music"{
                        if self.closed{
                            withAnimation (.easeInOut(duration: 0.7)){
                                MusicPlayerView(sounds_playing_audios: $sounds_playing_audios, player: $player, height: $height, open: $open, album_name: $album_name, album_own_songs: $album_own_songs, current: $current, album_cover: $album_cover, sound_names: $sound_names, initial_volume: $initial_volume, initial_sounds_array: $initial_sounds_array, apps_music_bool: $apps_music_bool, showMixEdit: $showMixEdit, playing_music_realm_id: $playing_music_realm_id, volumeValues: $volumeValues, tabBarHeight: $tabBarHeight, finish: $finish, playingCreatedMix: $playingCreatedMix, tabChangeBool: $tabChangeBool, currentRepeatImage: $currentRepeatImage, isShuffle: $isShuffle, timeLineValue: $timeLineValue, isEditing: $isEditing, changeSongTimer: $changeSongTimer, changeSongTimer2: $changeSongTimer2, endTimer: $endTimer, del: $del, start_point_checked: $start_point_checked, end_point_checked: $end_point_checked, songVolumeLineValue: $songVolumeLineValue, playerStart: $playerStart, playerEnd: $playerEnd, errorOffset: $errorOffset, offsetinHomeView: $offsetinHomeView, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed, showIAPsView: $showIAPsView, interstitial: $interstitial, playing: $playing, addedLocalSongUrls: $addedLocalSongUrls, addLocalSongWhenCreate: $addLocalSongWhenCreate)
                                   // .opacity(open ? 0 : 1)
                                    .environmentObject(realManager)
                                    .environmentObject(myTimer)
                                    .environmentObject(store)
                                    .environmentObject(determineShowingAd)
                            }
                            

                        }

                    
//                    else if player_called_from == "users_music"{
//                        if users_music_closed{
//                            withAnimation (.easeInOut(duration: 0.7)){
//                                MusicPlayerView(sounds_playing_audios: $sounds_playing_audios, player: $player, currentTime: $currentTime, isPlaying: $isPlaying, height: $height, open: $open, album_name: $album_name, album_own_songs: $album_own_songs, current: $current, album_cover: $album_cover, sound_names: $sound_names, initial_volume: $initial_volume, initial_sounds_array: $initial_sounds_array, apps_music_bool: $apps_music_bool, showMixEdit: $showMixEdit, playing_music_realm_id: $playing_music_realm_id, volumeValues: $volumeValues, tabBarHeight: $tabBarHeight, finish: $finish, playingCreatedMix: $playingCreatedMix, tabChangeBool: $tabChangeBool, currentRepeatImage: $currentRepeatImage, isShuffle: $isShuffle)
//                                    //.opacity(open ? 0 : 1)
//                                    .environmentObject(realManager)
//                            }
//                        }else{
//                            withAnimation (.easeInOut(duration: 0.7)){
//                                MusicPlayerView(sounds_playing_audios: $sounds_playing_audios, player: $player, currentTime: $currentTime, isPlaying: $isPlaying, height: $height, open: $open, album_name: $album_name, album_own_songs: $album_own_songs, current: $current, album_cover: $album_cover, sound_names: $sound_names, initial_volume: $initial_volume, initial_sounds_array: $initial_sounds_array, apps_music_bool: $apps_music_bool, showMixEdit: $showMixEdit, playing_music_realm_id: $playing_music_realm_id, volumeValues: $volumeValues, tabBarHeight: $tabBarHeight, finish: $finish, playingCreatedMix: $playingCreatedMix, tabChangeBool: $tabChangeBool, currentRepeatImage: $currentRepeatImage, isShuffle: $isShuffle)
//                                  //  .opacity(open ? 0 : 1)
//                                    .environmentObject(realManager)
//                            }
//                        }
//                    }
                    
//                    MusicPlayerView(sounds_playing_audios: $sounds_playing_audios, player: $player, currentTime: $currentTime, isPlaying: $isPlaying, height: $height, open: $open, album_name: $album_name, album_own_songs: $album_own_songs, current: $current, album_cover: $album_cover, sound_names: $sound_names, initial_volume: $initial_volume, initial_sounds_array: $initial_sounds_array, apps_music_bool: $apps_music_bool, showMixEdit: $showMixEdit, playing_music_realm_id: $playing_music_realm_id, volumeValues: $volumeValues, tabBarHeight: $tabBarHeight)
//                        .opacity(open ? 0 : 1)
//                        .environmentObject(realManager)
//                        .visibility(self.closed ? .gone : .visible)
                    
                }
                
                
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.7)){
                    self.open = false
                    self.height = 0
                }
                   
                    //.opacity(floating ? 0 : 1)
                
            }
//            .gesture(DragGesture().onChanged({ (value) in
//
//                if self.height == 635{
//                    //                    self.height -= value.translation.height / 8
//                    //                    self.opacity = 0.5
//
//                }else
//                {
//                    //                    if (value.translation.height / 8) >= 0{
//                    //                    self.height += value.translation.height / 8
//                    //                    }
//                    high = height + value.translation.height / 8
//                    if high >= 0{
//
//                        self.height += value.translation.height / 8
//
//                    }
//                    //self.opacity = 0.5
//                }
//
//            }).onEnded({ (value) in
//                if self.height < (geo.size.height - 700) && !self.open{
//                    self.height = 0
//                    self.open = false
//                    self.opacity = 1
//                }
//                else{
//                    if self.height < (geo.size.height - 100) && self.open{
//                        self.height = 0
//                        self.opacity = 1
//                        self.open = false
//                    }else{
//                        self.height = UIScreen.main.bounds.height - tabBarHeight*1.55 - UIScreen.main.bounds.height/9
//                        self.open = true
//                        self.opacity = 1
//                    }
//                }
//            }))
            .opacity(self.opacity)
            .offset(y: self.height)
            .animation(.easeInOut(duration: 0.7), value: open)
            
        }
        
        
        .onReceive(Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()) { (_) in
            guard let player = self.player, !isEditing else {return}
            currentTime1 = player.currentTime
            isPlaying1 = player.isPlaying
            timeLineValue = player.currentTime
            
            //
        }
        
    }
    
    
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
                self.finish = false
            }
            
            player.play()
            for sound_playing_audio in sounds_playing_audios {
                sound_playing_audio.play()
            }
        }
        //isPlaying = player.isPlaying
    }
    
    func getCurrentTime(value: TimeInterval) -> String{
        
        return "\(Int(value / 60)):\(Int(value.truncatingRemainder(dividingBy:60)) < 9 ? "0" : "")\(Int(value.truncatingRemainder(dividingBy:60)))"
    }
}

// Helper bridge to UIViewController to access enclosing UITabBarController
// and thus its UITabBar

struct TabBarAccessor: UIViewControllerRepresentable {
    var callback: (UITabBar) -> Void
    private let proxyController = ViewController()

    func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarAccessor>) ->
                              UIViewController {
        proxyController.callback = callback
        return proxyController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<TabBarAccessor>) {
    }

    typealias UIViewControllerType = UIViewController

    private class ViewController: UIViewController {
        var callback: (UITabBar) -> Void = { _ in }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let tabBar = self.tabBarController {
                self.callback(tabBar.tabBar)
            }
        }
    }
}
