//
//  AddSongsToMix.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 27.03.2022.
//

import SwiftUI
import AVKit
import RealmSwift

struct AddSongsToMix: View {
    @EnvironmentObject var realManager: RealmManager
    @EnvironmentObject var store: Store
    @Binding public var addSongsShow: Bool
    @Binding public var initial_album_songs: [Songs]
    @State public var changed_playing_song_id: Int = 0
    @State var changing_album_songs: [Songs] = []
    let all_songs = SongsData()
    @State var checkBoxes: [Bool] = []
    @Binding var showFilter: Bool
    @Binding var start_point_checked: Bool
    @Binding var end_point_checked: Bool
    @Binding public var initial_audios: [AVAudioPlayer]
    @Binding public var initial_sounds_array: [Sound]
    @Binding public var initial_volume: [CGFloat]
    @Binding var addSoundsViewShow: Bool
    @Binding var initial_volumeValues: [Double]
    @Binding public var sounds_playing: [Sound]
    @Binding public var playing_sounds_audios: [AVAudioPlayer]
    @Binding var volume : [CGFloat]
    @Binding var volumeValues: [Double]
    @Binding var addedLocalSongUrls: [URL]
    @Binding var isPurchased: Bool
    @Binding var isMonthlySubscribed: Bool
    @Binding var isWeeklySubscribed: Bool
    @Binding var showIAPsView: Bool
    @Binding public var playing_music_realm_id: ObjectId
    @Binding var addLocalSongWhenCreate: Bool
    
    
    @State var url: URL = URL(fileURLWithPath: "")
    @State var showLocalFiles = false
    @State var unicalSongs: [Songs] = []
    
    var body: some View {
        ZStack{
            Color("add_songs_color")
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                HStack{
                    
                    Button(action: {
                        start_point_checked = false
                        end_point_checked = false
                        for sound in playing_sounds_audios{
                            playing_sounds_audios[playing_sounds_audios.firstIndex(of: sound)!].stop()
                        }
                        sounds_playing = []
                        playing_sounds_audios = []
                        volume = []
                        volumeValues = []
                        initial_album_songs = []
                        addedLocalSongUrls = []
                        showFilter.toggle()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: UIScreen.main.bounds.height/25))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("Select Songs")
                        .foregroundColor(.white)
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/40))
                    
                    Spacer()
                    
                    Button {
                        if !(isPurchased || isWeeklySubscribed || isMonthlySubscribed){
                            showIAPsView = true
                        }else{
                            self.showLocalFiles = true
                            self.addLocalSongWhenCreate = true
                            print("Go to Phone Music")
                        }
                    } label: {
                       // ZStack{
                            Image("Add_Local")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width*26/390, height: UIScreen.main.bounds.height*26/844)
                            
//                            VStack{
//                                Spacer()
//                                HStack{
//                                    Spacer()
//                                    Image("premium_icon")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: UIScreen.main.bounds.width*22/650, height: UIScreen.main.bounds.height*25/1300)
//                                }
//
//                            }
//                            .frame(width: UIScreen.main.bounds.width*26/390, height: UIScreen.main.bounds.height*26/844)
//
//                        }
//                        .frame(width: UIScreen.main.bounds.width*26/390, height: UIScreen.main.bounds.height*26/844)
                       
                    }
                    
                    
                }
                .padding(.top, UIScreen.main.bounds.height/20)
                .padding(.horizontal, UIScreen.main.bounds.width/20)
                
                
                HStack(spacing: UIScreen.main.bounds.width/15){
                    
                    Button {
                        var i = 0
                        checkBoxes.forEach { checkBox in
                            
                            withAnimation {
                                checkBoxes[i] = true
                            }
                            i += 1
                        }
                        changing_album_songs.removeAll()
                        changing_album_songs = unicalSongs
                        //changed_playing_song_id = changing_album_songs.firstIndex(of: initial_album_songs[initial_playing_song_id])!
                    } label: {
                        HStack{
                            Image("select_all")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width*24/390, height: UIScreen.main.bounds.height*24/844)
                            
                            Text("SELECT ALL")
                                .foregroundColor(.white)
                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/55))
                        }
                        .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height/50)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white.opacity(0.1), lineWidth: 2)
                        )
                    }
                    
                    
                    
                    Button {
                        var i = 0
                        checkBoxes.forEach { checkBox in
                            
                            withAnimation {
                                checkBoxes[i] = false
                            }
                            
                            i += 1
                        }
                        
                        changing_album_songs.removeAll()
                        
                    } label: {
                        HStack{
                            Image("clear")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width*24/390, height: UIScreen.main.bounds.height*24/844)
                            
                            Text("CLEAR")
                                .foregroundColor(.white)
                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/55))
                        }
                        .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height/50)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white.opacity(0.1), lineWidth: 2)
                        )
                    }
                    
                }
                .padding(.top)
                
                
                
                
                //List View of Songs
                List{
                    ForEach(unicalSongs){song in
                        
                        VStack{
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    //self.checkBoxes[all_songs.songs_data.firstIndex(of: song)!].toggle()
                                    
                                    
                                    if self.checkBoxes[unicalSongs.firstIndex(of: song)!] == true{
                                        
                                        self.checkBoxes[unicalSongs.firstIndex(of: song)!] = false
                                        changing_album_songs.remove(at: changing_album_songs.firstIndex(of: song)!)
                                        //changed_playing_song_id = changing_album_songs.firstIndex(of: initial_album_songs[initial_playing_song_id])!
                                    } else{
                                        
                                        self.checkBoxes[unicalSongs.firstIndex(of: song)!] = true
                                        changing_album_songs.insert(song, at: 0)
                                        //changed_playing_song_id = changing_album_songs.firstIndex(of: initial_album_songs[initial_playing_song_id])!
                                    }
                                }
                            } label: {
                                HStack{
                                    
                                    if checkBoxes.count == unicalSongs.count{
                                        Image(systemName: self.checkBoxes[unicalSongs.firstIndex(of: song)!] ? "checkmark.square.fill" : "square")
                                            .font(.system(size: UIScreen.main.bounds.height/42))
                                            .foregroundColor(self.checkBoxes[unicalSongs.firstIndex(of: song)!] ? .white : .white.opacity(0.1))
                                            .padding(.leading)
                                    }
                                    
                                    VStack(alignment: .leading){
                                        Text(song.song_name)
                                            .foregroundColor(.white)
                                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/50))
                                        Text(song.artist)
                                            .foregroundColor(.gray)
                                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/60))
                                    }
                                    .padding(.leading, 10)
                                    
                                    Spacer()
                                    
                                    Text(getDuration(songFileName: song.song_filename))
                                        .foregroundColor(.gray)
                                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/60))
                                        .padding(.trailing)
                                    
                                }.buttonStyle(PlainButtonStyle())
                            }
                            
                            
                            
                            
                            
                            Spacer()
                            Spacer()
                            
                            Divider()
                                .background(.white.opacity(0.1))
                            
                        }
                        .frame(height: UIScreen.main.bounds.height/15)
                        
                        .listRowSeparator(.hidden)
                    }
                    .listRowBackground(Color("add_songs_color"))
                }
                .padding(.top, UIScreen.main.bounds.height/180)
                .listStyle(PlainListStyle())
                
                //Save Button
                VStack{
                    Button {
                        withAnimation {
                            //initial_playing_song_id = changed_playing_song_id
                            initial_album_songs = changing_album_songs
                            
                            addSongsShow.toggle()
                            addSoundsViewShow = true
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
                
            }.edgesIgnoringSafeArea(.all)
        }
        
        .fullScreenCover(isPresented: $showIAPsView) {
            IAPsView(showIAPsView: $showIAPsView, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed)
                .environmentObject(store)
        }
        
        .fullScreenCover(isPresented: $showLocalFiles, onDismiss: {
            //addSongsShow.toggle()
        }, content: {
            DocumentPicker(url: $url, initial_album_songs: $initial_album_songs, playing_music_realm_id: $playing_music_realm_id, addedLocalSongUrls: $addedLocalSongUrls, addLocalSongWhenCreate: $addLocalSongWhenCreate)
                .environmentObject(realManager)
        })
        
//        .onChange(of: url) { newValue in
//            print(newValue)
// 
//            addedLocalSongUrls.append(newValue)
//        }
        
        
        .onAppear {
            
            var unical_song_names_array: [String] = []

            for song in all_songs.songs_data{
                if !unical_song_names_array.contains(where: { $0 == song.song_name}){
                    unicalSongs.append(song)
                    unical_song_names_array.append(song.song_name)
                }
            }
            
            changing_album_songs = initial_album_songs
            //changed_playing_song_id = initial_playing_song_id
            for _ in unicalSongs{
                
                checkBoxes.append(false)
            }
            
            for initial_album_song in changing_album_songs{
                if let ix = unicalSongs.firstIndex(of: initial_album_song){
                    self.checkBoxes[ix] = true
                }
            }
            
            
        }
        
        .onDisappear {
            checkBoxes.removeAll()
        }
        
        
    }
    func getDuration(songFileName: String) -> String{
        let url = Bundle.main.path(forResource: songFileName, ofType: "mp3")
        
        let player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
        
        let duration = getCurrentTime(value: player.duration)
        return duration
    }
    
    func getCurrentTime(value: TimeInterval) -> String{
        
        return "\(Int(value / 60)):\(Int(value.truncatingRemainder(dividingBy:60)) < 9 ? "0" : "")\(Int(value.truncatingRemainder(dividingBy:60)))"
    }
}
