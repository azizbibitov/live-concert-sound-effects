//
//  ExploreView.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 22.02.2022.
//

import SwiftUI
import ACarousel
import Introspect
import AVKit
import RealmSwift
import GoogleMobileAds
import MediaPlayer

struct ExploreView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var determineShowingAd: ShouldShowAd
    @EnvironmentObject var realManager: RealmManager
    //    @EnvironmentObject var playerStart: Player
    //    @EnvironmentObject var playerEnd: Player
    let premium_data = PremiumData()
    @State var showCreateMixViews = false
    @Binding public var open: Bool
    @Binding public var closed: Bool
    @Binding public var height: CGFloat
    @Binding public var album_name: String
    @Binding public var album_own_songs: [Songs]
    @Binding public var album_cover: String
    @State private var adding_songs_to_mix = [Songs]()
    @State var addSoundsViewShow: Bool = false
    @State var addSongsShow: Bool = true
    @State var start_point_checked: Bool = false
    @State var end_point_checked: Bool = false
    @State public var createdMixesSwift: [CreatedMixSwift] = []
    @Binding var uiTabarController: UITabBarController?
    @Binding public var player: AVAudioPlayer!
    @Binding public var current: Int
    @Binding public var player_called_from: String
    @Binding public var users_music_closed: Bool
    @Binding var initial_volume: [CGFloat]
    @Binding var sound_names: [String]
    @Binding var initial_sounds_array: [Sound]
    @Binding var sounds_playing_audios: [AVAudioPlayer]
    @Binding public var apps_music_bool: Bool
    @Binding public var showMixEdit: Bool
    @Binding public var playing_music_realm_id: ObjectId
    @Binding var initial_volumeValues: [Double]
    @Binding var playingCreatedMix: CreatedMix
    @Binding var tabChangeBool: Bool
    @Binding var finish: Bool
    @Binding var changeSongTimer: Timer?
    @Binding var changeSongTimer2: Timer?
    @Binding var endTimer: Timer?
    @Binding var del: AVdelegate
    @Binding var playerStart: Player
    @Binding var playerEnd: Player
    @Binding public var showIAPsView: Bool
    @Binding var isPurchased: Bool
    @Binding var isMonthlySubscribed: Bool
    @Binding var isWeeklySubscribed: Bool
    @Binding var interstitial : InterstitialAd?
    @Binding var playing: Bool!
    @Binding var songVolumeLineValue: Float
    @Binding var isShuffle: Bool
    @Binding var addedLocalSongUrls: [URL]
    @Binding var addLocalSongWhenCreate: Bool
    @Binding var interstitialAdNoCompletion: InterstitialAdNoCompletion?
    @Binding var deletingMixId: ObjectId!
    @Binding var height_floating_player: CGFloat
    
    @State var volumeValues: [Double] = []
    @State var volume : [CGFloat] = []
    @State public var playing_sounds_audios: [AVAudioPlayer] = []
    @State public var sounds_playing: [Sound] = []
    @State var multiColors = true
    @State var gradient = [Color("explore_back_gradient"), Color("explore_back_gradient2")]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 1, y: 1.5)
    @State var showInstructionPage: Bool = false
    @State private var showingDeleteMixAlert = false
    
    //    private let audioSession = AVAudioSession.sharedInstance()
    
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 0)
                .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                .edgesIgnoringSafeArea(.all)
            //album_data: data.album_data_cover,
            VStack {
                AdSlider(premium_album_data: premium_data.premium_album_data_cover, player: $player, height: $height,  open: $open, closed: $closed, album_name: $album_name, album_own_songs: $album_own_songs, current: $current, album_cover: $album_cover, player_called_from: $player_called_from, sound_names: $sound_names, initial_volume: $initial_volume, initial_sounds_array: $initial_sounds_array, sounds_playing_audios: $sounds_playing_audios, apps_music_bool: $apps_music_bool, initial_volumeValues: $initial_volumeValues, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed, showIAPsView: $showIAPsView, songVolumeLineValue: $songVolumeLineValue)
                
                HStack{
                    // \(String(users_music_closed))
                    Text("My Mixes")
                        .foregroundColor(.white)
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/40))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, (UIScreen.main.bounds.width - UIScreen.main.bounds.width/1.3)/2)
                        .padding(.vertical)
                    
                    Text(String(open))
                        .visibility(.invisible)
                }
                
                
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    
                    HStack(spacing: 15){
                        
                        ZStack{
                            
                            VStack {
                                Button {
                                    
                                    withAnimation {
                                        if changeSongTimer != nil{
                                            let url = Bundle.main.path(forResource: self.album_own_songs[current].song_filename, ofType: "mp3")
                                            
                                            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                                            
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
                                        showCreateMixViews.toggle()
                                        //selectedImage[0] = true
                                    }
                                } label: {
                                    
                                    Image("add")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.main.bounds.height/18, height: UIScreen.main.bounds.height/18)
                                        .padding(.top)
                                }
                                
                                Text("Create your Mix")
                                    .foregroundColor(.white)
                                    .font(.custom("Nunito-Medium", size: UIScreen.main.bounds.height/60))
                                    .padding(.top, 5)
                            }
                            
                        }
                        .frame(width:UIScreen.main.bounds.height/6, height: UIScreen.main.bounds.height/6)
                        .overlay(
                            RoundedRectangle(cornerRadius: UIScreen.main.bounds.height/40)
                                .stroke(Color.white.opacity(0.1), lineWidth: 2)
                        )
                        
                        
                        ForEach(realManager.created_mixes, id: \.id){created_mix in
                            
                            
                            
                            ZStack(alignment: .top){
                                ZStack(alignment: .bottom) {
                                    Image(created_mix.image)
                                        .resizable()
                                        .aspectRatio( contentMode: .fill)
                                        .frame(width:UIScreen.main.bounds.height/6, height: UIScreen.main.bounds.height/6)
                                        .cornerRadius(UIScreen.main.bounds.height/40)
                                        .contentShape(Path(CGRect(x:0, y:0, width: UIScreen.main.bounds.height/6, height: UIScreen.main.bounds.height/6)))
                                    
                                    
                                    
                                    Rectangle()                         // Shapes are resizable by default
                                        .foregroundColor(.clear)        // Making rectangle transparent
                                        .background(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom))
                                        .cornerRadius(UIScreen.main.bounds.height/40)
                                        .frame(width:UIScreen.main.bounds.height/6, height: UIScreen.main.bounds.height/13)
                                    
                                }.frame(width:UIScreen.main.bounds.height/6, height: UIScreen.main.bounds.height/6)
                                
                                HStack {
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                    VStack {
                                        Spacer()
                                        Button {
                                            self.showingDeleteMixAlert = true
                                            deletingMixId = created_mix.id
                                        } label: {
                                            Image("delete")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.main.bounds.height/20, height: UIScreen.main.bounds.height/20)
                                                .contentShape(Path(CGRect(x:0, y:0, width: UIScreen.main.bounds.height/20, height: UIScreen.main.bounds.height/20)))
                                        }
                                        Spacer()
                                        Spacer()
                                        Spacer()
                                        Spacer()
                                        Spacer()
                                        
                                    }
                                    Spacer()
                                }
                                
                                
                                
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        Spacer()
                                        Text(created_mix.mix_name)
                                            .foregroundColor(.white)
                                            .font(.custom("Nunito-Medium", size: UIScreen.main.bounds.height/60))
                                            .bold()
                                        //                            Text(album.count)
                                        //                                .foregroundColor(.gray)
                                        //                                .font(.system(size: UIScreen.main.bounds.width*12/390))
                                    }
                                    .padding(UIScreen.main.bounds.height/100)
                                    Spacer()
                                }
                                
                            }.frame(width:UIScreen.main.bounds.height/6, height: UIScreen.main.bounds.height/6)
                                .onTapGesture {
                                    self.album_name = created_mix.mix_name
                                    self.album_cover = created_mix.image
                                    
                                    
                                    
                                    //                                    //self.player_called_from = "users_music"
                                    //                                    //users_music_closed.toggle()
                                    //                                    closed.toggle()
                                    //                                    self.height = 0
                                    //                                    self.open = false
                                    
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
                                    
                                    
                                    var i = 0
                                    playing_music_realm_id = created_mix.id
                                    
                                    let sound_realm_array = Array(created_mix.sounds)
                                    for realmSound in sound_realm_array{
                                        
                                        self.initial_sounds_array.append(Sound(id: i, sound_name: realmSound.sound_name, sound_image: realmSound.sound_image, sound_filename: realmSound.sound_filename, sound_volume: realmSound.sound_volume, sound_category: realmSound.sound_category, is_sound_premium: realmSound.is_sound_premium))
                                        
                                        i += 1
                                    }
                                    
                                    
                                    initial_sounds_array.forEach { sound in
                                        
                                        initial_volume.insert(CGFloat(35), at: 0)
                                        //initial_volumeValues.insert(sound.sound_volume, at: 0)
                                        initial_volumeValues.append(sound.sound_volume)
                                        sound_names.append(sound.sound_name)
                                        
                                        var player = AVAudioPlayer()
                                        let url = Bundle.main.path(forResource: sound.sound_filename, ofType: "mp3")
                                        player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                                        player.prepareToPlay()
                                        player.numberOfLoops = -1
                                        player.volume = Float(sound.sound_volume)
                                        player.play()
                                        sounds_playing_audios.append(player)
                                    }
                                    
                                    
                                    i = 0
                                    self.album_own_songs.removeAll()
                                    playingCreatedMix = created_mix
                                    
                                    for creadetMixSong in created_mix.songs{
                                        if creadetMixSong.audio_from_internal_storage == true{
                                            
                                            //                                            if (!FileManager.default.fileExists(atPath: creadetMixSong.song_filename)){
                                            //                                                realManager.deleteSongFromMix(mixID: playing_music_realm_id, song_position: created_mix.songs.firstIndex(of: creadetMixSong)!)
                                            //                                            }
                                            
                                            if (try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: creadetMixSong.song_filename))) == nil{
                                                print("nill")
                                                realManager.deleteSongFromMix(mixID: playing_music_realm_id, song_position: created_mix.songs.firstIndex(of: creadetMixSong)!)
                                            }
                                            
                                            
                                        }
                                    }
                                    
                                    
                                    let songs_realm_array = Array(created_mix.songs)
                                    
                                    for realmSong in  songs_realm_array{
                                        let url = URL(fileURLWithPath: realmSong.song_filename)
                                        if url.isFileURL{
                                            self.album_own_songs.append(Songs(id: i, album_name: album_name, song_name: realmSong.song_name, song_filename: realmSong.song_filename, artist: realmSong.artist, audio_from_internal_storage: realmSong.audio_from_internal_storage))
                                        }else{
                                            self.album_own_songs.append(Songs(id: i, album_name: album_name, song_name: realmSong.song_name, song_filename: realmSong.song_filename, artist: realmSong.artist, audio_from_internal_storage: realmSong.audio_from_internal_storage))
                                        }
                                        i += 1
                                        
                                    }
                                    
                                    
                                    
                                    
                                    if player != nil{
                                        self.player.stop()
                                    }
                                    var url = Bundle.main.path(forResource: self.album_own_songs[0].song_filename, ofType: "mp3")
                                    if url == nil{
                                        url = self.album_own_songs[0].song_filename
                                        player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                                    }else{
                                        player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                                    }
                                    
                                    self.player.volume = self.songVolumeLineValue
                                    self.player.play()
                                    
                                    self.open = false
                                    self.height = 0
                                    self.current = 0
                                    users_music_closed.toggle()
                                    player_called_from = "users_music"
                                    apps_music_bool = false
                                    
                                    isShuffle = false
                                    setupNowPlaying()
                                    //                                    try! self.audioSession.setCategory(.playAndRecord, mode: .spokenAudio, options: [.defaultToSpeaker, .allowAirPlay, .allowBluetoothA2DP])
                                    //                                    try! self.audioSession.setActive(true)
                                    
                                }
                            
                        }
                        
                    }
                    .padding(.horizontal, (UIScreen.main.bounds.width - UIScreen.main.bounds.width/1.3)/2)
                })
                Spacer()
                
                Button {
                    
                    showInstructionPage = true
                } label: {
                    ZStack{
                        Color("how_create_mix_back_color")
                            .edgesIgnoringSafeArea(.all)
                        
                        HStack{
                            Text("How to create mix?")
                                .foregroundColor(.white)
                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/60))
                            
                            
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height/15)
                    .cornerRadius(20)
                    .padding(.horizontal, (UIScreen.main.bounds.width - UIScreen.main.bounds.width/1.3)/2)
                }
                
                
                Spacer()
                
                if isPurchased || isWeeklySubscribed || isMonthlySubscribed{
                    
                }else{
                    GADBannerViewController()
                        .frame(height: UIScreen.main.bounds.height/10)
                        .cornerRadius(20)
                        .padding(.horizontal, (UIScreen.main.bounds.width - UIScreen.main.bounds.width/1.3)/2)
                    // .padding(.vertical, UIScreen.main.bounds.height/30)
                    
                    //, UIScreen.main.bounds.height/4
                    //.padding(.horizontal, (UIScreen.main.bounds.width - UIScreen.main.bounds.width/1.3)/2)
                }
                Spacer()
                
            }
            
            
            
        }
        
        .alert("Are you sure you want to delete mix?", isPresented: $showingDeleteMixAlert, actions: {
            Button("No", role: .cancel, action: {})
            Button("Yes", role: .destructive, action: {
                if !(isPurchased || isWeeklySubscribed || isMonthlySubscribed) && interstitialAdNoCompletion!.loaded{
                    if player != nil {
                        playing = player.isPlaying
                        player.stop()
                    }
                    if sounds_playing_audios.count != 0{
                        for playing_sounds_audio in self.sounds_playing_audios {
                            playing_sounds_audio.stop()
                        }
                    }
                    
                    interstitialAdNoCompletion?.show()
                    print("Yeee")
                }else{
                    if playing_music_realm_id == deletingMixId{
                        if player != nil {
                            playing = player.isPlaying
                            player.stop()
                        }
                        if sounds_playing_audios.count != 0{
                            for playing_sounds_audio in self.sounds_playing_audios {
                                playing_sounds_audio.stop()
                            }
                        }
                        height_floating_player = 1800
                    }
                    
                    realManager.deleteCreatedMix(id: deletingMixId)
                    
                }
                
            })
        }, message: {
            Text("There is no way back")
        })
        
        .fullScreenCover(isPresented: $showInstructionPage, content: {
            InstructionPage(showInstructionPage: $showInstructionPage)
        })
        
        
        .fullScreenCover(isPresented: $showCreateMixViews) {
            if addSongsShow{
                AddSongsToMix(addSongsShow: $addSongsShow, initial_album_songs: $adding_songs_to_mix, showFilter: $showCreateMixViews, start_point_checked: $start_point_checked, end_point_checked: $end_point_checked, initial_audios: $sounds_playing_audios, initial_sounds_array: $initial_sounds_array, initial_volume: $initial_volume, addSoundsViewShow: $addSoundsViewShow, initial_volumeValues: $initial_volumeValues, sounds_playing: $sounds_playing, playing_sounds_audios: $playing_sounds_audios, volume: $volume, volumeValues: $volumeValues, addedLocalSongUrls: $addedLocalSongUrls, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed, showIAPsView: $showIAPsView, playing_music_realm_id: $playing_music_realm_id, addLocalSongWhenCreate: $addLocalSongWhenCreate)
                    .transition(.backTrailingslide)
                    .environmentObject(realManager)
                    .environmentObject(store)
                
                
            } else if addSoundsViewShow{
                
                AddSoundsToMix(start_point_checked: $start_point_checked, end_point_checked: $end_point_checked, initial_volume: $initial_volume, editViewDisplay: $showCreateMixViews, sound_names: $sound_names, initial_audios: $sounds_playing_audios, initial_sounds_array: $initial_sounds_array, open: $open, closed: $closed, height: $height, addSongsShow: $addSongsShow, initial_album_songs: $adding_songs_to_mix, album_name: $album_name, album_own_songs: $album_own_songs, album_cover: $album_cover, current: $current, player_called_from: $player_called_from, users_music_closed: $users_music_closed, player: $player, apps_music_bool: $apps_music_bool, showMixEdit: $showMixEdit, playing_music_realm_id: $playing_music_realm_id, initial_volumeValues: $initial_volumeValues, tabChangeBool: $tabChangeBool, sounds_playing: $sounds_playing, playing_sounds_audios: $playing_sounds_audios, volume: $volume, volumeValues: $volumeValues, interstitial: $interstitial, playing: $playing, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed, playingCreatedMix: $playingCreatedMix, isShuffle: $isShuffle, showIAPsView: $showIAPsView, addedLocalSongUrls: $addedLocalSongUrls, songVolumeLineValue: $songVolumeLineValue)
                    .transition(.backLeadingslide)
                    .environmentObject(realManager)
                    .environmentObject(determineShowingAd)
                    .environmentObject(store)
                
            }
            
        }
        
        .introspectTabBarController { (UITabBarController) in
            
            if self.open{
                uiTabarController?.tabBar.isHidden = false
                
            }else{
                UITabBarController.tabBar.isHidden = true
                uiTabarController = UITabBarController
            }
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
    
    func play(){
        if player != nil{
            if player.isPlaying{
                player.pause()
                for sound_playing_audio in sounds_playing_audios {
                    sound_playing_audio.pause()
                }
            }
            
        }
    }
}



extension AnyTransition {
    static var backLeadingslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))}
}

extension AnyTransition {
    static var backTrailingslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .leading),
            removal: .move(edge: .trailing)
        )
    }
}


//struct ExploreView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        ExploreView(, showFilter: )
//    }
//}


struct GADBannerViewController: UIViewControllerRepresentable{
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = GADBannerView(adSize: GADPortraitInlineAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width))
        let viewController = UIViewController()
        
        let testID = "ca-app-pub-3940256099942544/2934735716"
        view.adUnitID = testID
        //banner ad
        //        let realID = "ca-app-pub-6455092018142201/6148894190"
        //        view.adUnitID = realID
        view.rootViewController = viewController
        
        //Veiw Controller
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: GADPortraitInlineAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width).size)
        
        //load an ad
        view.load(GADRequest())
        return viewController
    }
}

struct AdSlider: View {
    var premium_album_data: [PremiumAlbums]
    
    @State var spacing: CGFloat = UIScreen.main.bounds.width/6
    @State var headspace: CGFloat = UIScreen.main.bounds.width/300
    @State var sidesScaling: CGFloat = 0.78
    @State var isWrap: Bool = true
    @State var autoScroll: Bool = true
    @State var time: TimeInterval = 8
    @State var currentIndex: Int = 0
    
    //    @Binding public var showIAPsView: Bool
    //    @Binding var isPurchased: Bool
    //    @Binding var isMonthlySubscribed: Bool
    //    @Binding var isWeeklySubscribed: Bool
    
    @Binding public var player: AVAudioPlayer!
    @Binding public var height: CGFloat
    //   var album_data: [Album]
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
    //    private let audioSession = AVAudioSession.sharedInstance()
    @Binding var isPurchased: Bool
    @Binding var isMonthlySubscribed: Bool
    @Binding var isWeeklySubscribed: Bool
    @Binding var showIAPsView: Bool
    @Binding var songVolumeLineValue: Float
    
    let data = AlbumData()
    let soundsData = SoundsData()
    
    var body: some View {
        ACarousel(premium_album_data,
                  index: $currentIndex,
                  spacing: spacing,
                  headspace: headspace,
                  sidesScaling: sidesScaling,
                  isWrap: isWrap,
                  autoScroll: autoScroll ? .active(time) : .inactive) { premium_album in
            
            ZStack(alignment: .top){
                ZStack(alignment: .bottom) {
                    Image(premium_album.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width:UIScreen.main.bounds.width/1.3, height: UIScreen.main.bounds.height/4)
                    
                    Rectangle()                         // Shapes are resizable by default
                        .foregroundColor(.clear)        // Making rectangle transparent
                        .background(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom))
                        .frame(width:UIScreen.main.bounds.width/1.3, height: UIScreen.main.bounds.height/10)
                }
                .cornerRadius(UIScreen.main.bounds.height/30)
                
                if isPurchased || isWeeklySubscribed || isMonthlySubscribed{
                    
                }else{
                    
                    HStack {
                        Spacer()
                        VStack {
                            
                            Image("premium_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width*22/390, height: UIScreen.main.bounds.height*25/844)
                                .padding(UIScreen.main.bounds.height/50)
                            
                            
                            
                        }
                        
                    }
                    
                }
                
                
                
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(premium_album.title)
                            .foregroundColor(.white)
                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/50))
                        Text(premium_album.description)
                            .foregroundColor(.gray)
                            .font(.custom("Nunito-Medium", size: UIScreen.main.bounds.height/60))
                    }
                    .padding()
                    Spacer()
                }
                
            }
            .onTapGesture {
                if !(isPurchased || isWeeklySubscribed || isMonthlySubscribed) {
                    
                    showIAPsView = true
                    
                }else{
                    print(premium_album.title)
                    
                    var index = 0
                    
                    switch premium_album.id {
                    case 0:
                        index = 1
                    case 1:
                        index = 4
                    case 2:
                        index = 5
                    case 3:
                        index = 9
                    case 4:
                        index = 10
                    default:
                        return
                    }
                    
                    //index = premium_album.id
                    
                    self.open = false
                    self.album_name = data.album_data_cover[index].title
                    self.album_cover = data.album_data_cover[index].image
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
                            player.volume = Float(album_sound.sound_volume)
                            player.play()
                            sounds_playing_audios.insert(player, at: 0)
                        }
                    }
                    setupNowPlaying()
                }
            }
            
            
        }
                  .frame(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/4)
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


