//
//  HomeView.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 22.02.2022.
//

import Foundation
import SwiftUI
import AVKit
import GoogleMobileAds
import Combine


extension Font {
    static func avenirNext(size: Int) -> Font {
        return Font.custom("Avenir Next", size: CGFloat(size))
    }
    
    static func avenirNextRegular(size: Int) -> Font {
        return Font.custom("AvenirNext-Regular", size: CGFloat(size))
    }
}

enum ViewVisibility: CaseIterable {
    case visible, // view is fully visible
         invisible, // view is hidden but takes up space
         gone // view is fully removed from the view hierarchy
}

extension View {
    @ViewBuilder func visibility(_ visibility: ViewVisibility) -> some View {
        if visibility != .gone {
            if visibility == .visible {
                self
            } else {
                hidden()
            }
        }
    }
}

struct HomeView: View {
    
    @Environment(\.horizontalSizeClass) var hSizeClass
    @Environment(\.verticalSizeClass) var vSizeClass
    
    @EnvironmentObject var store: Store
    @Binding public var player: AVAudioPlayer!
    @Binding public var height: CGFloat
    @Binding public var open: Bool
    @Binding public var closed: Bool
    @Binding public var album_name: String
    @Binding public var album_own_songs: [Songs]
    @Binding public var current: Int
    @Binding public var album_cover: String
    @Binding public var showFilter: Bool
    @Binding public var player_called_from: String
    @Binding var sound_names: [String]
    @Binding var initial_volume: [CGFloat]
    @Binding var initial_sounds_array: [Sound]
    @Binding public var sounds_playing_audios: [AVAudioPlayer]
    @Binding public var apps_music_bool: Bool
    @Binding var initial_volumeValues: [Double]
    @Binding var tabBarHeight: CGFloat
    @Binding var offsetinHomeView: CGFloat
    @Binding var errorOffset: CGFloat
    @Binding var isPurchased: Bool
    @Binding var isMonthlySubscribed: Bool
    @Binding var isWeeklySubscribed: Bool
    @Binding var showIAPsView: Bool
    @Binding var songVolumeLineValue: Float
    @Binding var isShuffle: Bool
    
    
    
    @State var imageHeight: CGFloat = 0
    private let collapsedImageHeight: CGFloat = (UIScreen.main.bounds.height*95/844)
    
    @ObservedObject private var articleContent: ViewFrame = ViewFrame()
    @State private var titleRect: CGRect = .zero
    @State private var headerImageRect: CGRect = .zero
    @State var offsetBool: Bool = false
    @State var multiColors = true
    let data = AlbumData()
    
    
    
    
    
    
    
    
    
    
    //Offset...
    @State var offsetNew: CGFloat = 0
    
    // for sticky header view...
    @State var time = Timer.publish(every: 0.3, on: .current, in: .tracking).autoconnect()
    
    @State var show = false
    
    
    var body: some View {
        
        ZStack(alignment: .top, content: {
            Color("main_page_back").edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack{
                    
                    //now go to do strechy header....
                    //follow me...
                    
                    GeometryReader{g in
                        
                        ZStack(alignment: .bottom) {
                            
                            ZStack(alignment: .bottom) {
                                Image("logo_hd")
                                    .resizable()
                                    .clipped()
                                
                                
                                
//                                Rectangle()                         // Shapes are resizable by default
//                                    .foregroundColor(.clear)        // Making rectangle transparent
//                                    .background(LinearGradient(gradient: Gradient(colors: [Color("main_page_back"), .clear]), startPoint: .bottom, endPoint: .top))
//                                    .frame(height:220)
                            }
                            
                            
                            VStack{
                                
                                
                                ZStack{
                                    Button(action: {
                                        print("Premium")
                                        showIAPsView = true
                                    }) {
                                        Image("premium_icon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.main.bounds.width*27/390, height: UIScreen.main.bounds.height*27/844)
                                            .foregroundColor(.white)
                                        
                                        
                                    }
                                }
                                .padding(.leading, UIScreen.main.bounds.width/1.2)
                                .padding(.top, 55)
                                
                                
                                //Text("Live Concert\(String(isPurchased))@\(String(isMonthlySubscribed))@\(String(isWeeklySubscribed))")
                                //                                Text("Live Concert")
                                //                                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/35))
                                //                                    .frame(maxWidth: .infinity, alignment: .leading)
                                //                                    .padding(.leading, UIScreen.main.bounds.width*2/30)
                                //                                    .foregroundColor(.white)
                                //                                    .offset(y: UIScreen.main.bounds.height/25 + g.frame(in: .global).minY)
                                
                                
                                Spacer()
                                //
                                
                                
                            }
                            
                        }
                        .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
                        .frame(height: g.frame(in: .global).minY > 0 ? self.imageHeight + g.frame(in: .global).minY : self.imageHeight)
                        .onReceive(self.time) { (_) in
                            
                            //its not a timer...
                            //for tracking the image is scrolled out or not...
                            
                            let y = g.frame(in: .global).minY
                            
                            if -y > (self.imageHeight) - 50 {
                                
                                
                                withAnimation(.spring()){
                                    self.show = true
                                }
                            }
                            else {
                                
                                withAnimation(.spring()){
                                    self.show = false
                                }
                            }
                        }
                        
                        
                    }
                    .frame(height: self.imageHeight)
                    
                    
                    VStack{
                        
                        
//                        TextShimmer(text: "Made For You", multiColors: $multiColors)
//                        TextShimmer(text: "by Aziz Bibitov", multiColors: $multiColors)
                        
                        Text("Featured")
                            .foregroundColor(.white)
                            .padding(.bottom, 0)
                            .padding(.top, 0)
                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/35))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, UIScreen.main.bounds.width*2/30)
                        
//                        Text("Made For You by Aziz Bibitov")
//                            .foregroundColor(.white)
//                            .padding(.bottom, 0)
//                            .padding(.top, 0)
//                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/35))
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .padding(.leading, UIScreen.main.bounds.width*2/30)
                        
                       
                        
                        GridView(player: $player, height: $height, album_data: data.album_data_cover, open: $open, closed: $closed, album_name: $album_name, album_own_songs: $album_own_songs, current: $current, album_cover: $album_cover, player_called_from: $player_called_from, sound_names: $sound_names, initial_volume: $initial_volume, initial_sounds_array: $initial_sounds_array, sounds_playing_audios: $sounds_playing_audios, apps_music_bool: $apps_music_bool, initial_volumeValues: $initial_volumeValues, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed, showIAPsView: $showIAPsView, songVolumeLineValue: $songVolumeLineValue, isShuffle: $isShuffle)
                            .padding(.top, 0)
                            .padding(.bottom, UIScreen.main.bounds.height/8.44)
                            .environmentObject(store)
                        
                    }
                    
                }
            })
            
            if self.show {
                
                TopView(multiColors: $multiColors)
            }
            
        })
            .edgesIgnoringSafeArea(.all)
        
        //        .onChange(of: offsetinHomeView, perform: { offsetNew in
        //            if offsetNew > 200{
        //                errorOffset = UIScreen.main.bounds.height*340/844
        //            }
        //        })
        
        
        
            .onAppear {
                if vSizeClass == .regular && hSizeClass == .regular{
                    imageHeight = (UIScreen.main.bounds.height*340/550)
                }else{
                    imageHeight = (UIScreen.main.bounds.height*340/844)
                }
                
           
                
                
            }
        
    }
}



//TopView...

struct TopView: View {
    @Binding var multiColors: Bool
    var body: some View {
        
        VStack{
            
            
            //                   TextShimmer(text: "Live Concert", multiColors: $multiColors)
            
            
            Text("Live Concert Sound Effects")
                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/35))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, UIScreen.main.bounds.width*2/30)
                .foregroundColor(.white)
                .padding(.bottom, UIScreen.main.bounds.height*4/844)
            
        }
        //for none safe area phones padding will be 15...
        .padding(.top, UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .compactMap({$0 as? UIWindowScene})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first?.safeAreaInsets.top == 0 ? 15 : (UIApplication.shared.connectedScenes
                                                                                        .filter({$0.activationState == .foregroundActive})
                                                                                        .compactMap({$0 as? UIWindowScene})
                                                                                        .first?.windows
                                                                                        .filter({$0.isKeyWindow}).first?.safeAreaInsets.top)! + 5)
        //.padding(.horizontal)
        .padding(.bottom)
        .background(BlurBG())
        //        .background(Color.w)
        //        .blur(radius: 10)
        
    }
}

//Blur background....
struct BlurBG: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        //for dark mode adoption...
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

//sample data for cards....






struct MainMusicsButton: View {
    let image: String
    @State var genres: String
    @State var interstitial : InterstitialAd?
    @State var playing: Bool!
    @State var timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    @StateObject var determineShowingAd = ShouldShowAd()
    
    @State var displayGenres: Bool = false
    
    @Binding public var player: AVAudioPlayer!
    @Binding public var height: CGFloat
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
    
    
    var body: some View {
        Button(action: {
            
            determineShowingAd.clickTrigger()
            determineShowingAd.determizer()
            if determineShowingAd.shouldShowAd{
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
            }else{
                displayGenres = true
            }
            
            //Goes to selected music
        }) {
            //            VStack{
            //                HStack{
            //                Text(String(determineShowingAd.shouldShowAd))
            //                Text(String(determineShowingAd.time))
            //                Text(String(determineShowingAd.clickCountToTriggerAd))
            //                }
            ZStack {
                
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width*65/390, height: UIScreen.main.bounds.height*65/844)
                
            }
            .cornerRadius(23)
            //    }
        }
        .onAppear(perform: {
            
            interstitial = InterstitialAd(completion: {
                print("time to 0")
                determineShowingAd.time = 0
                determineShowingAd.determizer()
                if player != nil{
                    if playing{
                        player.play()
                        for sound_playing_audio in sounds_playing_audios {
                            sound_playing_audio.play()
                        }
                    }
                }
            })
        })
        .onReceive(timer) { (_) in
            determineShowingAd.time += 1
            
            // self.now = Date()
        }
        
        .fullScreenCover(isPresented: $displayGenres) {
            GenreView(displayGenres: $displayGenres, genres: $genres, player: $player, height: $height, open: $open, closed: $closed, album_name: $album_name, album_own_songs: $album_own_songs, current: $current, album_cover: $album_cover, player_called_from: $player_called_from, sound_names: $sound_names, initial_volume: $initial_volume, initial_sounds_array: $initial_sounds_array, sounds_playing_audios: $sounds_playing_audios, apps_music_bool: $apps_music_bool, initial_volumeValues: $initial_volumeValues)
        }
    }
    
}

//struct BackgroundClearView: UIViewRepresentable {
//    func makeUIView(context: Context) -> UIView {
//        let view = UIView()
//        DispatchQueue.main.async {
//            view.superview?.superview?.backgroundColor = .clear
//        }
//        return view
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {}
//}

//struct HomeView_Previews: PreviewProvider {
//    @State static var change = false
//    @State static var closed = false
//    @State static var album_name = "false"
//    @State static var id = 0
//    @State static var songs = [Songs]()
//    @State static var height_floating_player: CGFloat = 0
//
//    static var previews: some View {
//        HomeView(player: , height: $height_floating_player, id: $id, open: $change, closed: $closed, album_name: $album_name, album_own_songs: $songs)
//    }
//}

class ViewFrame: ObservableObject {
    var startingRect: CGRect?
    
    @Published var frame: CGRect {
        willSet {
            if startingRect == nil {
                startingRect = newValue
            }
        }
    }
    
    init() {
        self.frame = .zero
    }
}

struct GeometryGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
        GeometryReader { geometry in
            AnyView(Color.clear)
                .preference(key: RectanglePreferenceKey.self, value: geometry.frame(in: .global))
        }.onPreferenceChange(RectanglePreferenceKey.self) { (value) in
            self.rect = value
        }
    }
}

struct RectanglePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}





struct ExtractedView: View {
    @Binding public var player: AVAudioPlayer!
    @Binding public var height: CGFloat
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
    var body: some View {
        HStack( spacing: UIScreen.main.bounds.width/19.5) {
            VStack {
                MainMusicsButton(image: "rap_icon", genres: "Rap", player: $player, height: $height, open: $open, closed: $closed, album_name: $album_name, album_own_songs: $album_own_songs, current: $current, album_cover: $album_cover, player_called_from: $player_called_from, sound_names: $sound_names, initial_volume: $initial_volume, initial_sounds_array: $initial_sounds_array, sounds_playing_audios: $sounds_playing_audios, apps_music_bool: $apps_music_bool, initial_volumeValues: $initial_volumeValues)
                Text("Rap")
                    .foregroundColor(.white)
                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/55))
            }
            VStack {
                MainMusicsButton(image: "guitar_icon", genres: "Acoustic", player: $player, height: $height, open: $open, closed: $closed, album_name: $album_name, album_own_songs: $album_own_songs, current: $current, album_cover: $album_cover, player_called_from: $player_called_from, sound_names: $sound_names, initial_volume: $initial_volume, initial_sounds_array: $initial_sounds_array, sounds_playing_audios: $sounds_playing_audios, apps_music_bool: $apps_music_bool, initial_volumeValues: $initial_volumeValues)
                Text("Acoustic")
                    .foregroundColor(.white)
                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/55))
            }
            VStack {
                MainMusicsButton(image: "rock_icon", genres: "Rock music", player: $player, height: $height, open: $open, closed: $closed, album_name: $album_name, album_own_songs: $album_own_songs, current: $current, album_cover: $album_cover, player_called_from: $player_called_from, sound_names: $sound_names, initial_volume: $initial_volume, initial_sounds_array: $initial_sounds_array, sounds_playing_audios: $sounds_playing_audios, apps_music_bool: $apps_music_bool, initial_volumeValues: $initial_volumeValues)
                Text("Rock music")
                    .foregroundColor(.white)
                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/55))
            }
            VStack {
                MainMusicsButton(image: "piano_icon", genres: "Classics", player: $player, height: $height, open: $open, closed: $closed, album_name: $album_name, album_own_songs: $album_own_songs, current: $current, album_cover: $album_cover, player_called_from: $player_called_from, sound_names: $sound_names, initial_volume: $initial_volume, initial_sounds_array: $initial_sounds_array, sounds_playing_audios: $sounds_playing_audios, apps_music_bool: $apps_music_bool, initial_volumeValues: $initial_volumeValues)
                Text("Classics")
                    .foregroundColor(.white)
                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/55))
            }
        }
        .padding(.top, UIScreen.main.bounds.height/80)
    }
}

struct TextShimmer: View {
    
    var text: String
    @State var animation = false
    @Binding var multiColors: Bool
    
    var body: some View {
        
//        Text("Featured")
//            .foregroundColor(.white)
//            .padding(.bottom, 0)
//            .padding(.top, 0)
//            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/35))
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding(.leading, UIScreen.main.bounds.width*2/30)
        
        ZStack {
            Text(text)
                .foregroundColor(Color.white.opacity(0.6))
                .padding(.bottom, 0)
                .padding(.top, 0)
                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/50))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, UIScreen.main.bounds.width*2/30)
            //.offset(x: 0, y: getHeaderTitleOffsetForShimmer(titleRect: titleRect, headerImageRect: headerImageRect))
            
            // Multicolor Text
            HStack(spacing: 0) {
                ForEach(0..<text.count, id: \.self) { index in
                    Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                    
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/50))
                        .foregroundColor(multiColors ? randomColor() : Color.white)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, UIScreen.main.bounds.width*2/30-1)
            // .offset(x: 0, y: getHeaderTitleOffsetForShimmer(titleRect: titleRect, headerImageRect: headerImageRect))
            
            // Masking for Shimmer Effect
            .mask(
                Rectangle()
                // For Some more nice effects, we will use Gradient
                    .fill(
                        // You can use any Color here
                        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.white, Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                    )
                    .rotationEffect(Angle(degrees: 45))
                    .padding(8)
                // Moving View continuosly so it will create Shimmer Effect
                    .offset(x: -250)
                    .offset(x: animation ? 500 : 0)
            )
            .onAppear(perform: {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: true)) {
                    animation.toggle()
                }
            })
            
        }
        
    }
    
    // Random Color
    
    // It's your wish to change any color
    // or you can also use Array of Colors to pick random One
    func randomColor() -> Color {
        
        let color = UIColor(red: 1, green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        
        return Color(color)
    }
    
}

