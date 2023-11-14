//
//  MusicPlayerView.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 05.03.2022.
//

import SwiftUI
import AVKit
import Combine
import RealmSwift
import KeyboardAware
import MediaPlayer

struct MusicPlayerView: View {
    
    //Gesture Properties...
    
    @EnvironmentObject var determineShowingAd: ShouldShowAd
    @EnvironmentObject var store: Store
    @EnvironmentObject var realManager: RealmManager
    @EnvironmentObject var myTimer: MyTimer
//    @EnvironmentObject var playerStart: Player
//    @EnvironmentObject var playerEnd: Player
    @State var offset: CGFloat = 0
    @State var floatingBottomSheet = false
    @State var lastoffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    @Binding public var sounds_playing_audios: [AVAudioPlayer]
    @Binding public var player: AVAudioPlayer!
    @Binding public var height: CGFloat
    @Binding public var open: Bool
    @Binding public var album_name: String
    @Binding public var album_own_songs: [Songs]
    @Binding var current: Int
    @State var addSongsShow: Bool = false
    @Binding public var album_cover: String
    @Binding var sound_names: [String]
    @Binding var initial_volume: [CGFloat]
    @Binding var initial_sounds_array: [Sound]
    @Binding public var apps_music_bool: Bool
    @Binding public var showMixEdit: Bool
    @Binding public var playing_music_realm_id: ObjectId
    @Binding var volumeValues: [Double]
    @Binding var tabBarHeight: CGFloat
    @Binding var finish: Bool
    @Binding var playingCreatedMix: CreatedMix
    @Binding var tabChangeBool: Bool
    @Binding var currentRepeatImage: Int
    @Binding var isShuffle: Bool
    @Binding var timeLineValue: Double
    @Binding var isEditing: Bool
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
    @Binding var interstitial : InterstitialAd?
    @Binding var playing: Bool!
    @Binding var addedLocalSongUrls: [URL]
    @Binding var addLocalSongWhenCreate: Bool
    
    
    
    @State var bottom_sheet_offset: Bool = false
    

    var body: some View {
        
        
        
   
            withAnimation(.easeInOut(duration: 1.5)){
                ZStack{
                    
                    
                    Color("playerGradient").edgesIgnoringSafeArea(.all)
                    
                    //for getting frame for image...
                    GeometryReader{proxy in
                        
                        let frame = proxy.frame(in: .global)
                        
                        ZStack(alignment: .top){
                          
                            Image(album_cover)
                                .resizable()
                                .aspectRatio( contentMode: .fill)
                                .frame(width: frame.width, height: frame.height-UIScreen.main.bounds.height/5)
                                .edgesIgnoringSafeArea(.all)
                            
                            
                            ZStack{
                                Rectangle()                         // Shapes are resizable by default
                                    .foregroundColor(.clear)        // Making rectangle transparent
                                    .background(LinearGradient(gradient: Gradient(colors: [.clear, Color("playerGradient")]), startPoint: .bottom, endPoint: .top))
                                    .frame(height: UIScreen.main.bounds.height/4)
                                
                            }
                            
                            VStack{
                                
                                ZStack{
                                    Rectangle()                         // Shapes are resizable by default
                                        .foregroundColor(.clear)        // Making rectangle transparent
                                        .background(LinearGradient(gradient: Gradient(colors: [.clear, Color("playerGradient")]), startPoint: .top, endPoint: .bottom))
                                }
                                Spacer()
                                    .frame(height: UIScreen.main.bounds.height/5)
                            }
                            
                         
                            
                            //Music Player Itself....
                            PlayerView(sounds_playing_audios: $sounds_playing_audios, current: $current, player: $player, height: $height, open: $open, album_name: $album_name, album_own_songs: $album_own_songs, sound_names: $sound_names, initial_volume: $initial_volume, initial_sounds_array: $initial_sounds_array, apps_music_bool: $apps_music_bool, showMixEdit: $showMixEdit, volumeValues: $volumeValues, tabBarHeight: $tabBarHeight, album_cover: $album_cover, finish: $finish, playingCreatedMix: $playingCreatedMix, tabChangeBool: $tabChangeBool, currentRepeatImage: $currentRepeatImage, isShuffle: $isShuffle, timeLineValue: $timeLineValue, isEditing: $isEditing, playing_music_realm_id: $playing_music_realm_id, changeSongTimer: $changeSongTimer, changeSongTimer2: $changeSongTimer2, endTimer: $endTimer, del: $del, start_point_checked: $start_point_checked, end_point_checked: $end_point_checked, songVolumeLineValue: $songVolumeLineValue, playerStart: $playerStart, playerEnd: $playerEnd, errorOffset: $errorOffset, offsetinHomeView: $offsetinHomeView, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed, showIAPsView: $showIAPsView)
                                .padding(.bottom, UIScreen.main.bounds.height/10)
                                .environmentObject(realManager)
                                .environmentObject(playerStart)
                                .environmentObject(playerEnd)
                                .environmentObject(store)
                            
          
                        }
                        
                    }
                    .overlay(
                   
                        Color("playerGradient")
                            .opacity(getBlurRadius()/60)
                            .onTapGesture {
                                withAnimation {
                                    print("bottom_sheet_back_pressed")
                                    offset = 0
                                }
                            }
                            .visibility(offset == 0 ? .gone : .visible)
                        
                    )
                    
                    //Bottom sheet..
                    //for getting height for drag gesture...
                    GeometryReader{proxy -> AnyView in
                        
                        let height = proxy.frame(in: .global).height
                        
                        return AnyView(
                            
                            ZStack{
                                
                                Color("BottomSheetColor")
                                    .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: UIScreen.main.bounds.height/50))
                                
                                VStack{
                                    
                                    VStack(spacing: UIScreen.main.bounds.height/175){
                                        
                                        Capsule()
                                            .fill(Color.gray)
                                            .frame(width: UIScreen.main.bounds.width/10, height: UIScreen.main.bounds.height/150)
                                            .padding(.top)
                                        
                                        Capsule()
                                            .fill(Color.gray)
                                            .frame(width: UIScreen.main.bounds.width/17, height: UIScreen.main.bounds.height/200)
                                        Spacer()
                                    }
                                    .frame(height: UIScreen.main.bounds.height/15)
                                    
                                    //ScroolView Content...
                                    //ScrollView(.vertical, showsIndicators: false) {
                                    
                                    ZStack {
                                        if !apps_music_bool{
                                            BottomContent(current: $current, player: $player, album_own_songs: $album_own_songs, playing_music_realm_id: $playing_music_realm_id, songVolumeLineValue: $songVolumeLineValue, album_cover: $album_cover)
                                                .environmentObject(realManager)
                                            .padding(.bottom, UIScreen.main.bounds.height/8 + UIScreen.main.bounds.height/2.5)
                                        
                                        Button {
                                            print("Add more songs")
                                            addSongsShow.toggle()
                                        } label: {
                                            VStack{
                                         
                                                HStack{
                                                    Image(systemName: "plus.circle.fill")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: UIScreen.main.bounds.height/35))
                                                    Text("Add more songs").foregroundColor(.white).font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/40))
                                                }
                                                .frame(maxWidth: .infinity, alignment: .center)
                                                Spacer().frame(height: UIScreen.main.bounds.height/12)
                                                
                                            }
                                         
                                        }
                                        .frame(height: UIScreen.main.bounds.height/8)
                                        .background(Color("BottomSheetColor"))
                                        } else{
                                            BottomContentForAppAlbums(current: $current, player: $player, album_own_songs: $album_own_songs, songVolumeLineValue: $songVolumeLineValue, album_cover: $album_cover)
                                                .padding(.bottom, UIScreen.main.bounds.height/8 + UIScreen.main.bounds.height/2.5)
                                            
                                        }
                                        
                                    }
                            
                                    //}
                                }
                                .padding(.horizontal)
                                .frame( maxHeight: .infinity, alignment: .top)
                           
                                
                            }
                               
                            //.offset(y: height - 60)
                                .offset(y: height - UIScreen.main.bounds.height/14)
                                .offset(y: -offset > 0 ? -offset <= (height - UIScreen.main.bounds.height/2) ? offset : -(height - UIScreen.main.bounds.height/2) : 0)
                                .gesture(DragGesture().updating($gestureOffset, body: {
                                    value, out, _ in
                                    out = value.translation.height
                                    onChange()
                                }).onEnded({ value in
                                    
                                    let maxHeight = height - UIScreen.main.bounds.height/2
                                    withAnimation {
                                        // logic condition for moving states...
                                        // up down or mid....
                                        //                                if -offset > 20 && -offset < maxHeight{
                                        //                                    offset = -maxHeight
                                        //                                }
                                        //                                else
                                        if -offset > maxHeight / 16 && !floatingBottomSheet{
                                            offset = -maxHeight
                                        bottom_sheet_offset = true
                                            floatingBottomSheet.toggle()
                                        }
                                        else if floatingBottomSheet && -offset < (maxHeight - 30)  {
                                            offset = 0
                                            bottom_sheet_offset = false
                                            floatingBottomSheet.toggle()
                                        } else if floatingBottomSheet {
                                            offset = -maxHeight
                                            bottom_sheet_offset = true
                                        } else if !floatingBottomSheet {
                                            offset = 0
                                            bottom_sheet_offset = false
                                        }
                                    }
                                    
                                    // Storing last offset...
                                    //so that the gesture can continue from the last position...
                                    lastoffset = offset
                                }))
                        )
                        
                    }
                    .ignoresSafeArea(.all, edges: .bottom)
                    
                    if !apps_music_bool{
                        EditMixView(showFilter: $showMixEdit, playing_music_realm_id: $playing_music_realm_id, album_name: $album_name, album_cover: $album_cover, sounds_playing_audios: $sounds_playing_audios, player: $player, interstitial: $interstitial, playing: $playing, playingCreatedMix: $playingCreatedMix)
                            .environmentObject(realManager)
                            .environmentObject(determineShowingAd)
                    }
                    
                    
                }
                .keyboardAware()
                
                
                .fullScreenCover(isPresented: $addSongsShow) {
                   
                    AddSongsView(initial_playing_song_id: $current, addSongsShow: $addSongsShow, initial_album_songs: $album_own_songs, playing_music_realm_id: $playing_music_realm_id, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed, showIAPsView: $showIAPsView, addedLocalSongUrls: $addedLocalSongUrls, addLocalSongWhenCreate: $addLocalSongWhenCreate)
                        .environmentObject(realManager)
                        .environmentObject(store)
                }
            }.visibility(open ? .invisible : .visible)

        
        
    }

    func onChange(){
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastoffset
        }
    }
    //Blure Radius For bg..
    func getBlurRadius() -> CGFloat{
        
        let progress = -offset / (UIScreen.main.bounds.height - 100)
        
        return progress * 30
    }
}

//struct MusicPlayerView_Previews: PreviewProvider {
//    @State static var open = false
//    @State static var name = ""
//    @State static var album_id = 0
//    @State static var songs = [Songs]()
//    @State static var height_floating_player: CGFloat = 0
//    @State static var currentTime: TimeInterval = 0
//    @State static var player: AVAudioPlayer?
//    static var previews: some View {
//        //MusicPlayerView(player: $player, currentTime: $currentTime, isPlaying: $open, height: $height_floating_player, album_id: $album_id, open: $open, album_name: $name, album_own_songs: $songs)
//
//        BottomContent(album_own_songs: $)
//    }
//}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}


struct EditMixView: View {
    @EnvironmentObject var determineShowingAd: ShouldShowAd
    @EnvironmentObject var realManager: RealmManager
    //let premium_data = PremiumData()
    let images_to_choose = CreateMixImages()
    @State var edges = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow}).first?.safeAreaInsets
    @Binding var showFilter: Bool
    
    @State var uiTabarController: UITabBarController?
    @State private var playlistName: String = ""
    @State var chosedImage: String = ""
    @State var selectedImage: [Bool] = []
    @Binding public var playing_music_realm_id: ObjectId
    @Binding public var album_name: String
    @Binding public var album_cover: String
    @Binding public var sounds_playing_audios: [AVAudioPlayer]
    @Binding public var player: AVAudioPlayer!
    @Binding var interstitial : InterstitialAd?
    @Binding var playing: Bool!
    @Binding var playingCreatedMix: CreatedMix
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 18) {
                HStack {
                    Image(systemName: "empty")
                        .foregroundColor(.white.opacity(0.2))
                        .font(.system(size: UIScreen.main.bounds.height/25))
                        .padding(.trailing)
                    Spacer()
                    Text("Create Playlist")
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/40))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            //playlistName = ""
                           // chosedImage = "night_music"
                            showFilter.toggle()
                        }
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white.opacity(0.2))
                            .font(.system(size: UIScreen.main.bounds.height/25))
                            .padding(.trailing)
                    })
                }
                .padding(.horizontal, UIScreen.main.bounds.width/20)
                .padding(.bottom, UIScreen.main.bounds.height/100)
                .padding(.top, UIScreen.main.bounds.height/100)
                
                VStack{
                    HStack{
                        Text("Playlist name:")
                            .foregroundColor(.white)
                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/50))
                        
                        VStack(spacing: 0){
                            TextField("", text: $playlistName)
                                .multilineTextAlignment(.center)
                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/60))
                                .foregroundColor(.white)
                                .placeholder(when: playlistName.isEmpty) {
                                    Text("Playlist Name")
                                        .multilineTextAlignment(.center)
                                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/60))
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity)
                            }
                                .ignoresSafeArea(.keyboard, edges: .bottom)
                            
                        }
                        
                        Spacer()
                    }
                    
                    
                    HStack {
                        
                        Capsule()
                            .frame( height: 3)
                            .foregroundColor(.white.opacity(0.2))
                            .padding(.leading, UIScreen.main.bounds.height*10/60)
                        Spacer()
                    }
                }
                .padding(.horizontal, UIScreen.main.bounds.width/20)
                
                Text("Cover")
                    .foregroundColor(.white)
                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/50))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, UIScreen.main.bounds.width/20)
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    
                    HStack(spacing: 15){
                        
                        
                        
                        //ForEach(premium_data.premium_album_data_cover){one_premium_data in
                        ForEach(images_to_choose.create_mix_images_data){image_to_choose in
                            Button {
                                for image in selectedImage{
                                    selectedImage[selectedImage.firstIndex(of: image)!] = false
                                }
                                selectedImage[images_to_choose.create_mix_images_data.firstIndex(of: image_to_choose)!].toggle()
                                chosedImage = image_to_choose.image
                            } label: {
                                ZStack{
                                    
                                    ZStack{
                                        Image(image_to_choose.image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.main.bounds.height/10, height: UIScreen.main.bounds.height/10)
                                            .cornerRadius(UIScreen.main.bounds.height/60)
                                            .contentShape(Path(CGRect(x:0, y:0, width: 90, height: 90)))
                                        
                                        if selectedImage.count != 0{
                                            if selectedImage[images_to_choose.create_mix_images_data.firstIndex(of: image_to_choose)!]{
                                                RoundedRectangle(cornerRadius: UIScreen.main.bounds.height/50)
                                                    .stroke(Color.white, lineWidth: 3)
                                            }
                                        }
                                        
                                    }
                                    .frame(width: UIScreen.main.bounds.height/10, height: UIScreen.main.bounds.height/10)
                                    
                                    if selectedImage.count != 0{
                                        if selectedImage[images_to_choose.create_mix_images_data.firstIndex(of: image_to_choose)!]{
                                            HStack {
                                                Spacer()
                                                Spacer()
                                                Spacer()
                                                Spacer()
                                                VStack {
                                                    Spacer()
                                                    
                                                    Image(systemName: "checkmark.circle.fill")
                                                        .font(.title2)
                                                        .foregroundColor(.white)
                                                    
                                                    Spacer()
                                                    Spacer()
                                                    Spacer()
                                                    Spacer()
                                                    Spacer()
                                                    
                                                }
                                                Spacer()
                                            }
                                        }
                                        
                                    }
                                    
                                    
                                }.frame(width: UIScreen.main.bounds.height/10, height: UIScreen.main.bounds.height/10)
                            }
                            
                            
                            
                        }
                        
                    }
                    .padding(.horizontal, UIScreen.main.bounds.width/20)
                })
                
                VStack{
                    Button {
                        withAnimation {
//                            determineShowingAd.clickTrigger()
//                            determineShowingAd.determizer()
//                            if determineShowingAd.shouldShowAd{
//                                if player != nil{
//                                    playing = player.isPlaying
//                                    if player.isPlaying{
//                                        player.stop()
//                                        for sound_playing_audio in sounds_playing_audios {
//                                            sound_playing_audio.stop()
//                                        }
//                                    }
//                                }
//                                interstitial?.show()
//                                print("Yeee")
//                            }
                            //realManager.createMix(mixName: playlistName, mixImage: chosedImage)
                            realManager.setMixNameAndImage(defaultMixID: playing_music_realm_id, mix_name: playlistName, mix_cover: chosedImage)
                            album_name = playlistName
                            album_cover = chosedImage
                            //playlistName = ""
                            //chosedImage = "night_music"
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
//                            for image in selectedImage{
//                                selectedImage[selectedImage.firstIndex(of: image)!] = false
//                            }
                            
                            self.showFilter.toggle()
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
                }
                .padding(.top)
                
            }
            .padding(.bottom, 10)
            .padding(.bottom, edges?.bottom)
            .padding(.top, 10)
            .background(Color("playerGradient").clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 15)))
            .offset(y: showFilter ? 0 : UIScreen.main.bounds.height)
        }
        .ignoresSafeArea()
        .background(
            Color.black.opacity(0.3).ignoresSafeArea()
                .opacity(showFilter ? 1 : 0)
            // you can also add close here
                .onTapGesture {
                    withAnimation {
                        //playlistName = ""
                        //chosedImage = "night_music"
                        showFilter.toggle()
                    }
                }
        )
        
        
        
        .onAppear {
            playlistName = album_name
            chosedImage = playingCreatedMix.image
            var image_index = 0
            for image_to_choose in images_to_choose.create_mix_images_data{
                if image_to_choose.image == chosedImage{
                    image_index = images_to_choose.create_mix_images_data.firstIndex(of: image_to_choose)!
                }
                selectedImage.append(false)
            }
            
            
            
            
         //   selectedImage = [false, false, false, false, false]
            
            selectedImage[image_index] = true
            
            //var i = 0
//            for _ in premium_data.premium_album_data_cover{
//                //print(i)
//                if i+1 < premium_data.premium_album_data_cover.count{
//                    selectedImage.append(false)
//
//                }else{
//                    selectedImage.insert(true, at: 0)
//                    print(i)
//                }
//                i += 1
//
//            }
            
        }
    }
}

struct BottomContent: View{
    @EnvironmentObject var realManager: RealmManager
    @Binding public var current: Int
    @Binding public var player: AVAudioPlayer!
    @Binding public var album_own_songs: [Songs]
    @State private var dragging: Songs?
    @State var del = AVdelegate()
    @State var model1Goni: CGFloat = 0
    @State var model2Goni: CGFloat = 0
    @State var model3Goni: CGFloat = 0
    @Binding public var playing_music_realm_id: ObjectId
    @Binding var songVolumeLineValue: Float
    @Binding public var album_cover: String
    @State var model1 = Model()
    @State var model2 = Model()
    @State var model3 = Model()
    
    @State var errorResolver: String = ""
    
    @State var offset2: CGFloat = 200.0

    var body: some View{
        
        List{
            ForEach(album_own_songs, id: \.self){album_own_song in
                VStack{
                Button(action: {
                    
                    if self.current != album_own_songs.firstIndex(of: album_own_song){
                        self.player.stop()
                        
                        if let index = album_own_songs.firstIndex(of: album_own_song) {
                            self.current = index
                        }
                        
                        var url = Bundle.main.path(forResource: album_own_song.song_filename, ofType: "mp3")
                        
                        if url == nil{
                            url = album_own_song.song_filename
                            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                        }else{
                            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                        }
                        
                        self.player.delegate = self.del
                        self.player.volume = songVolumeLineValue
                        self.player.play()
                        setupNowPlaying()
                    }
                }, label: {
                    
                    VStack {
                        HStack(spacing: UIScreen.main.bounds.width/50){
                            VStack (spacing: UIScreen.main.bounds.height/180){
                                Rectangle()
                                    .foregroundColor(Color("capsulesColor"))
                                    .frame(width: UIScreen.main.bounds.width/14, height: UIScreen.main.bounds.height/190)
                                    .cornerRadius(UIScreen.main.bounds.width/100)
                                Rectangle()
                                    .foregroundColor(Color("capsulesColor"))
                                    .frame(width: UIScreen.main.bounds.width/14, height: UIScreen.main.bounds.height/190)
                                    .cornerRadius(UIScreen.main.bounds.width/100)
                                Rectangle()
                                    .foregroundColor(Color("capsulesColor"))
                                    .frame(width: UIScreen.main.bounds.width/14, height: UIScreen.main.bounds.height/190)
                                    .cornerRadius(UIScreen.main.bounds.width/100)
                            }.padding(.leading, 15)
                            
                            VStack(alignment: .leading){
                                Text("\(album_own_song.song_name)")
                                    .foregroundColor(.white)
                                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/55))
                                Text(album_own_song.artist)
                                    .foregroundColor(.gray)
                                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                            }
                            .padding(.leading, 10)
                            
                            Spacer()
                            //&& !self.isPlaying
                            if self.current == album_own_songs.firstIndex(of: album_own_song) {
                    
                                
                               // SwiftUIGIFPlayerView(gifName: "yellow_audio_visualizer")
                                    //.frame(width: 20, height: 20)
                              
                                HStack(alignment: .bottom, spacing: UIScreen.main.bounds.width/200){
                                    
                                    ForEach([model1, model2, model3]){
                                  
                                        Rectangle()
                                            .foregroundColor(.green)
                                            .frame(width: UIScreen.main.bounds.width/100, height: $0.offset, alignment: .center)
                                            .animation(Animation.easeInOut(duration: 1.0), value: offset2)
                         
                                        
                                            
                                    }
                                    Text(errorResolver).foregroundColor(.white).lineLimit(1).font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/200))
                                        .frame(width: 0, height: 0)
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .frame(width: 0, height: CGFloat(UIScreen.main.bounds.height/35), alignment: .center)
                                    
                                    
                                    
                                }
                                .frame(height: UIScreen.main.bounds.height/35)
                                .padding(.bottom, 8)
                                .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { (_) in
                                   // guard let player = self.player, !isEditing else {return}
                                    if player.isPlaying{
                                        errorResolver = "error\(Int.random(in: 0...3))"
                                    }
                        //            timeLineValue = player.currentTime
                                    //self.updateTimer()
                        //            isPlaying = player.isPlaying
                        //            currentTime = player.currentTime
                        //            duration = player.duration

                                }
                                
                         
                            }
                            
                            Text(getDuration(songFileName: album_own_song.song_filename))
                                .foregroundColor(.gray)
                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                            
                            Button {
                                
                                withAnimation {
                                    if album_own_songs.firstIndex(of: album_own_song)! != current{
                                        let playing_song = album_own_songs[current]
//                                        let deletingSongID = realManager.getSongIdBySongName(mixID: playing_music_realm_id, song_position: album_own_songs.firstIndex(of: album_own_song)!)
                                        realManager.deleteSongFromMix(mixID: playing_music_realm_id, song_position: album_own_songs.firstIndex(of: album_own_song)!)
                                        album_own_songs.remove(at: album_own_songs.firstIndex(of: album_own_song)!)
                                        current = album_own_songs.firstIndex(of: playing_song)!
                                        
                                        
                                    }
                                }
                            } label: {
                                Image(systemName: "trash.fill")
                                    .font(.system(size: UIScreen.main.bounds.height/35))
                                    .foregroundColor(Color("deleteBtnColor"))
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.trailing)
                        }
                        .contentShape(Rectangle())
                        .padding(.top)
                        .padding(.bottom)
                        
                        
                        Divider()
                            .background(.white)
                    }
                    
                    
                }).buttonStyle(PlainButtonStyle())
                
            }
              //  .id(UUID())
                
                    .onDrag {
                        self.dragging = album_own_song
                        return NSItemProvider(object: NSString())
                    }
                    .onDrop(of: [UTType.text], delegate: DragDelegate(current: $dragging))
                
                    .listRowSeparator(.hidden)
                
                
                
            }
            .onMove { indices, newOffset in
                
                self.player.delegate = self.del
                
                album_own_songs.move(fromOffsets: indices, toOffset: newOffset)
                print("\(indices.first!)&&\(newOffset)")
                
                if self.current < Int(indices.first!) && album_own_songs.firstIndex(of: dragging!)! <= self.current{
                    self.current = self.current + 1
                } else if self.current > Int(indices.first!) && album_own_songs.firstIndex(of: dragging!)! >= self.current{
                    self.current = self.current - 1
                } else if self.current == Int(indices.first!){
                    self.current = album_own_songs.firstIndex(of: dragging!)!
                }

                realManager.deleteAllSongsOfMix(mixID: playing_music_realm_id)

                for song in album_own_songs{
                    realManager.addSongToMix(mixID: playing_music_realm_id, song_name: song.song_name, song_filename: song.song_filename, artist: song.artist, audio_from_internal_storage: song.audio_from_internal_storage)
                    print(song.song_name)
                }
                
                
                // Name Ucindir ashakdaky ishlanok???
                
//                let realmSongsList = RealmSwift.List<RealmSong>()
//
//                for song in album_own_songs{
//                    realmSongsList.append(RealmSong(song_name: song.song_name, song_filename: song.song_filename, artist: song.artist, audio_from: song.audio_from))
//                }
//
//                realManager.replaceSongsinMix(mixID: playing_music_realm_id, newSongs: realmSongsList)
                
                
            }
            .listRowBackground(Color("BottomSheetColor"))
            
        }
        .listStyle(PlainListStyle())
        
        .onAppear {
            album_own_songs.forEach { song in
                print(song.song_name)
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
        
    func getDuration(songFileName: String) -> String{
        var url = Bundle.main.path(forResource: songFileName, ofType: "mp3")
        var player: AVAudioPlayer
        if url == nil{
            url = songFileName
            player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
            
            
        }else{
            player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
        }
        
        
       // let duration = getCurrentTime(value: player.duration)
        let duration2 = DateComponentsFormatter.positional.string(from: player.duration) ?? "0:00"
        return duration2
    }
    
    
    func getCurrentTime(value: TimeInterval) -> String{
        
        return "\(Int(value / 60)):\(Int(value.truncatingRemainder(dividingBy:60)) < 9 ? "0" : "")\(Int(value.truncatingRemainder(dividingBy:60)))"
    }
}


struct BottomContentForAppAlbums: View{
    @Binding public var current: Int
    @Binding public var player: AVAudioPlayer!
    @Binding public var album_own_songs: [Songs]
    @Binding var songVolumeLineValue: Float
    @Binding public var album_cover: String
    @State private var dragging: Songs?
    @State var del = AVdelegate()
    @State var model1Goni: CGFloat = 0
    @State var model2Goni: CGFloat = 0
    @State var model3Goni: CGFloat = 0
    
    @State var model1 = Model()
    @State var model2 = Model()
    @State var model3 = Model()
    
    @State var errorResolver: String = ""
    
    @State var offset2: CGFloat = 200.0

    var body: some View{
        
        List{
            ForEach(album_own_songs, id: \.self){album_own_song in
                VStack{
                    Button(action: {
                        
                        if self.current != album_own_songs.firstIndex(of: album_own_song){
                            self.player.stop()
                            
                            if let index = album_own_songs.firstIndex(of: album_own_song) {
                                self.current = index
                            }
                            
                            let url = Bundle.main.path(forResource: album_own_song.song_filename, ofType: "mp3")
                            
                            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                            self.player.delegate = self.del
                            self.player.volume = songVolumeLineValue
                            self.player.play()
                            setupNowPlaying()
                        }
                    }, label: {
                        
                        VStack {
                            HStack(spacing: UIScreen.main.bounds.width/50){
                                //                            VStack (spacing: UIScreen.main.bounds.height/180){
                                //                                Rectangle()
                                //                                    .foregroundColor(Color("capsulesColor"))
                                //                                    .frame(width: UIScreen.main.bounds.width/14, height: UIScreen.main.bounds.height/190)
                                //                                    .cornerRadius(UIScreen.main.bounds.width/100)
                                //                                Rectangle()
                                //                                    .foregroundColor(Color("capsulesColor"))
                                //                                    .frame(width: UIScreen.main.bounds.width/14, height: UIScreen.main.bounds.height/190)
                                //                                    .cornerRadius(UIScreen.main.bounds.width/100)
                                //                                Rectangle()
                                //                                    .foregroundColor(Color("capsulesColor"))
                                //                                    .frame(width: UIScreen.main.bounds.width/14, height: UIScreen.main.bounds.height/190)
                                //                                    .cornerRadius(UIScreen.main.bounds.width/100)
                                //                            }.padding(.leading, 15)
                                
                                VStack(alignment: .leading){
                                    Text(album_own_song.song_name)
                                        .foregroundColor(.white)
                                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/55))
                                    Text(album_own_song.artist)
                                        .foregroundColor(.gray)
                                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                                }
                                .padding(.leading, 10)
                                
                                Spacer()
                                
                                if self.current == album_own_songs.firstIndex(of: album_own_song){
                                    
                                    
                                    // SwiftUIGIFPlayerView(gifName: "yellow_audio_visualizer")
                                    //.frame(width: 20, height: 20)
                                    
                                    HStack(alignment: .bottom, spacing: UIScreen.main.bounds.width/200){
                                        
                                        ForEach([model1, model2, model3]){
                                            
                                            Rectangle()
                                                .foregroundColor(.green)
                                                .frame(width: UIScreen.main.bounds.width/100, height: $0.offset, alignment: .center)
                                                .animation(Animation.easeInOut(duration: 1.0), value: offset2)
                                                //.animation(.default)
                                            
                                            
                                            
                                        }
                                        Text(errorResolver).foregroundColor(.white).lineLimit(1).font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/200))
                                            .frame(width: 0, height: 0)
                                        Rectangle()
                                            .foregroundColor(.white)
                                            .frame(width: 0, height: CGFloat(UIScreen.main.bounds.height/35), alignment: .center)
                                        
                                        
                                        
                                    }
                                    .frame(height: UIScreen.main.bounds.height/35)
                                    .padding(.bottom, 8)
                                    .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { (_) in
                                        // guard let player = self.player, !isEditing else {return}
                                        if player.isPlaying{
                                            errorResolver = "error\(Int.random(in: 0...3))"
                                        }
                                        //            timeLineValue = player.currentTime
                                        //self.updateTimer()
                                        //            isPlaying = player.isPlaying
                                        //            currentTime = player.currentTime
                                        //            duration = player.duration
                                        
                                    }
                                    
                                    
                                }
                                
                                Text(getDuration(songFileName: album_own_song.song_filename))
                                    .foregroundColor(.gray)
                                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                                
                                
                            }
                            .contentShape(Rectangle())
                            .padding(.top)
                            .padding(.bottom)
                            
                            
                            Divider()
                                .background(.white)
                        }
                        
                        
                    }).buttonStyle(PlainButtonStyle())
                    
                }
                
                
                .listRowSeparator(.hidden)
                
                
                
            }
            
            
            .listRowBackground(Color("BottomSheetColor"))
            
        }
        .listStyle(PlainListStyle())
        
        
 
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
    
    func getDuration(songFileName: String) -> String{
        var url = Bundle.main.path(forResource: songFileName, ofType: "mp3")
        
        if url == nil{
            url = songFileName
        }
        let player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                
        let duration = getCurrentTime(value: player.duration)
        return duration
    }
    
    
    func getCurrentTime(value: TimeInterval) -> String{
        
        return "\(Int(value / 60)):\(Int(value.truncatingRemainder(dividingBy:60)) < 9 ? "0" : "")\(Int(value.truncatingRemainder(dividingBy:60)))"
    }
}

class getAlbumSongsArray {
    let album_name: String
    
    init(album_name: String){
        self.album_name = album_name
    }
    
    let all_songs = SongsData()
    lazy var songs_array: [Songs] = getAlbumArray()
    
    func getAlbumArray() -> [Songs]{
        var this_album_songs_array = [Songs]()
        for one_of_all_songs in self.all_songs.songs_data{
            if one_of_all_songs.album_name == album_name {
                this_album_songs_array.append(one_of_all_songs)
            }
        }
        
        return this_album_songs_array
    }
}

struct DragDelegate<Item: Equatable>: DropDelegate {
    @Binding var current: Item?
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        current = nil
        return true
    }
}

class Model: ObservableObject, Identifiable {
    @Published var offset: CGFloat = 0

    let id = UUID()

    private var tickets: [AnyCancellable] = []

    let num = CGFloat(UIScreen.main.bounds.height/35)
    
    init() {
        Timer.publish(every: 0.1, on: RunLoop.main, in: .common)
            .autoconnect()
            .map { _ in CGFloat.random(in: 0...self.num) }
            .sink { [weak self] in self?.offset = $0 }
            .store(in: &tickets)
    }
}
