//
//  GenreView.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 13.04.2022.
//

import SwiftUI
import AVKit

struct GenreView: View {
    @Binding var displayGenres: Bool
    @Binding var genres: String
    
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
    
    @State var gradient = [Color("explore_back_gradient"), Color("explore_back_gradient2")]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 1, y: 1.5)
    
    let data = AlbumData()
    var body: some View {
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 0)
                .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                HStack{
                    
                    Button(action: {
                     
                        
                        self.displayGenres = false
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: UIScreen.main.bounds.height/25))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text(genres)
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
                
                ScrollView{
//                GridView(player: $player, height: $height, album_data: data.album_data_cover, open: $open, closed: $closed, album_name: $album_name, album_own_songs: $album_own_songs, current: $current, album_cover: $album_cover, player_called_from: $player_called_from, sound_names: $sound_names, initial_volume: $initial_volume, initial_sounds_array: $initial_sounds_array, sounds_playing_audios: $sounds_playing_audios, apps_music_bool: $apps_music_bool, initial_volumeValues: $initial_volumeValues)
//                        .padding(.top)
            }
                
                Spacer()
                
            }.edgesIgnoringSafeArea(.all)
            
            
        }
        
    }
}

//struct GenreView_Previews: PreviewProvider {
//    @State static var genress = "Accoustic"
//    @State static var displayGenres = true
//    static var previews: some View {
//        GenreView(displayGenres: $displayGenres, genres: $genress)
//    }
//}
