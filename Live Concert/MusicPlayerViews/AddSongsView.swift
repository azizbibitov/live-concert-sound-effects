//
//  AddSongsView.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 24.03.2022.
//

import SwiftUI
import AVKit
import RealmSwift
import MobileCoreServices
import UniformTypeIdentifiers

struct AddSongsView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var realManager: RealmManager
    @Binding public var initial_playing_song_id: Int
    @Binding public var addSongsShow: Bool
    @Binding public var initial_album_songs: [Songs]
    @Binding public var playing_music_realm_id: ObjectId
    @Binding var isPurchased: Bool
    @Binding var isMonthlySubscribed: Bool
    @Binding var isWeeklySubscribed: Bool
    @Binding var showIAPsView: Bool
    @Binding var addedLocalSongUrls: [URL]
    @Binding var addLocalSongWhenCreate: Bool
    
    @State public var changed_playing_song_id: Int = 0
    @State var changing_album_songs: [Songs] = []
    @State var end_point_checked: Bool = false
    let all_songs = SongsData()
    @State var allSongs = SongsData().songs_data
    @State var checkBoxes: [Bool] = []
    @State var song_names: [String] = []
    @State var showLocalFiles = false
    @State var url: URL = URL(fileURLWithPath: "")
    @State var localSongPlayer: AVAudioPlayer!
    @State var unicalSongs: [Songs] = []
    var body: some View {
        ZStack(alignment: .top){
            Color("add_songs_color")
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                HStack{
                    
                    Button(action: {
                        addSongsShow.toggle()
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
                            self.addLocalSongWhenCreate = false
                            print("Go to Phone Music")
                        }
                    } label: {
                        Image("Add_Local")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width*26/390, height: UIScreen.main.bounds.height*26/844)
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
                        
                        song_names = []
                        changing_album_songs.forEach { song in
                            song_names.append(song.song_name)
                        }
                        
                        
                        
                        changed_playing_song_id = song_names.firstIndex(of: initial_album_songs[initial_playing_song_id].song_name)!
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
                            
                            if changing_album_songs[changed_playing_song_id].song_name != unicalSongs[i].song_name{
                                withAnimation {
                                    checkBoxes[i] = false
                                }
                            }
                            i += 1
                        }
                        
                        changing_album_songs.removeAll()
                        changing_album_songs.insert(initial_album_songs[initial_playing_song_id], at: 0)
                        changed_playing_song_id = changing_album_songs.firstIndex(of: initial_album_songs[initial_playing_song_id])!
                        
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
                                if changing_album_songs[changed_playing_song_id].song_name != song.song_name{
                                    withAnimation {
                                        //self.checkBoxes[all_songs.songs_data.firstIndex(of: song)!].toggle()
                                        
                                        
                                        if self.checkBoxes[unicalSongs.firstIndex(of: song)!] == true{
                                            
                                            self.checkBoxes[unicalSongs.firstIndex(of: song)!] = false
                                            
                                            song_names = []
                                            changing_album_songs.forEach { song in
                                                song_names.append(song.song_name)
                                            }
                                            
                                            changing_album_songs.remove(at: song_names.firstIndex(of: song.song_name)!)
                                            changed_playing_song_id = changing_album_songs.firstIndex(of: initial_album_songs[initial_playing_song_id])!
                                        } else{
                                            
                                            self.checkBoxes[unicalSongs.firstIndex(of: song)!] = true
                                            changing_album_songs.append(song)
                                            changed_playing_song_id = changing_album_songs.firstIndex(of: initial_album_songs[initial_playing_song_id])!
                                        }
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
                                    
                                    //
                                    
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
                            }//
                            
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
                            initial_playing_song_id = changed_playing_song_id
                            initial_album_songs = changing_album_songs
                            
                            realManager.deleteAllSongsOfMix(mixID: playing_music_realm_id)
                            
                            for song in initial_album_songs{
                                realManager.addSongToMix(mixID: playing_music_realm_id, song_name: song.song_name, song_filename: song.song_filename, artist: song.artist, audio_from_internal_storage: false)
                            }
                            
                            addSongsShow.toggle()
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
                
            }
            .edgesIgnoringSafeArea(.all)
        }
        
        .fullScreenCover(isPresented: $showIAPsView) {
            IAPsView(showIAPsView: $showIAPsView, isPurchased: $isPurchased, isMonthlySubscribed: $isMonthlySubscribed, isWeeklySubscribed: $isWeeklySubscribed)
                .environmentObject(store)
        }
        
        
        .fullScreenCover(isPresented: $showLocalFiles, onDismiss: {
            addSongsShow.toggle()
        }, content: {
            DocumentPicker(url: $url, initial_album_songs: $initial_album_songs, playing_music_realm_id: $playing_music_realm_id, addedLocalSongUrls: $addedLocalSongUrls, addLocalSongWhenCreate: $addLocalSongWhenCreate)
                .environmentObject(realManager)
        })
        
        //        .onChange(of: url) { newValue in
        //            //print("qweqweqweqwe\(newValue)")
        //
        //
        //            var Artist = ""
        //            var Title = ""
        //            do {
        //
        //                try localSongPlayer = AVAudioPlayer(contentsOf: newValue)
        //
        //            } catch {
        //                print("errorpopoppopopopopopoppo\(error)")
        //            }
        //
        //            let asset = AVAsset(url: self.localSongPlayer.url!)
        //
        //            for i in asset.commonMetadata{
        //                if i.commonKey?.rawValue == "artist"{
        //                    let artist = i.value as! String
        //                    Artist = artist
        //                }
        //                if i.commonKey?.rawValue == "title"{
        //                    let title = i.value as! String
        //                    Title = title
        //                }
        //            }
        //
        //            if Title == ""{
        //                Title = "NoTitle"
        //            }
        //
        //            if Artist == ""{
        //                Artist = "NoArtist"
        //            }
        //
        //            var song_file_names: [String] = []
        //
        //            for songs in initial_album_songs{
        //                song_file_names.insert(songs.song_filename, at: 0)
        //            }
        //
        //            if !song_file_names.contains(newValue.path){
        //
        //                let song  = Songs(id: initial_album_songs.count, album_name: initial_album_songs[0].album_name, song_name: Title, song_filename: newValue.path, artist: Artist, audio_from_internal_storage: true)
        //
        //                realManager.addSongToMix(mixID: playing_music_realm_id, song_name: song.song_name, song_filename: song.song_filename, artist: song.artist, audio_from_internal_storage: song.audio_from_internal_storage)
        //                //initial_album_songs = []
        //                initial_album_songs.append(song)
        //            }
        //        }
        
        .onAppear {
            
            var unical_song_names_array: [String] = []
            
            for song in all_songs.songs_data{
                if !unical_song_names_array.contains(where: { $0 == song.song_name}){
                    unicalSongs.append(song)
                    unical_song_names_array.append(song.song_name)
                }
            }
            
            
            checkBoxes.removeAll()
            changing_album_songs = initial_album_songs
            changed_playing_song_id = initial_playing_song_id
            for _ in unicalSongs{
                
                checkBoxes.append(false)
            }
            
            
            for song in unicalSongs{
                song_names.append(song.song_name)
            }
            
            
            for initial_album_song in changing_album_songs{
                
                if let ix  = song_names.firstIndex(of: initial_album_song.song_name){
                    self.checkBoxes[ix] = true
                    print(ix)
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

//struct AddSongsView_Previews: PreviewProvider {
//    @State static var show: Bool = true
//    static var previews: some View {
//        AddSongsView(addSongsShow: $show)
//    }
//}

struct DocumentPicker: UIViewControllerRepresentable{
    
    func makeCoordinator() -> Coordinator {
        return DocumentPicker.Coordinator(parent1: self )
    }
    
    @Binding var url: URL
    @EnvironmentObject var realManager: RealmManager
    @Binding public var initial_album_songs: [Songs]
    @Binding public var playing_music_realm_id: ObjectId
    @Binding var addedLocalSongUrls: [URL]
    @Binding var addLocalSongWhenCreate: Bool
    
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        
        //        let supportedTypes: [UTType] = [UTType.audio]
        ////        let pickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        //
        //       // let picker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeMP3)], in: .import)
        //        let picker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        
        var documentPicker: UIDocumentPickerViewController
        if #available(iOS 14.0, *) {
            let supportedTypes: [UTType] = [UTType.audio]
            documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        } else {
            documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeMP3)], in: UIDocumentPickerMode.import)
        }
        
        
        documentPicker.allowsMultipleSelection = true
        documentPicker.delegate = context.coordinator
        return documentPicker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
        
    }
    
    
    class Coordinator: NSObject, UIDocumentPickerDelegate{
        
        var parent: DocumentPicker
        
        init(parent1: DocumentPicker) {
            parent = parent1
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            //print(urls)
            
            //            let attributes = [ FileAttributeKey.protectionKey : FileProtectionType.none ]
            //          let path = urls[0]
            //
            //            try! FileManager.default.setAttributes(attributes, ofItemAtPath: path.deletingLastPathComponent().path)
            
            //            let fileName = urls[0].absoluteString
            //            let fileArray = fileName.components(separatedBy: "/")
            //            let finalFileName = fileArray.last
            //
            //
            //            let paths: [String] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            //            let audiofilePath = "\(paths[0])/\(String(describing: finalFileName))"
            //            let audiourl : NSURL = NSURL(fileURLWithPath: audiofilePath)
            
            urls.forEach { url in
                
                var localSongPlayer = AVAudioPlayer()
                var Artist = ""
                var Title = ""
                do {
                    
                    try localSongPlayer = AVAudioPlayer(contentsOf: url)
                    
                } catch {
                    print("errorpopoppopopopopopoppo\(error)")
                }
                //                @Binding var addedLocalSongUrls: [URL]
                let asset2 = AVAsset(url: localSongPlayer.url!)
                
                for i in asset2.commonMetadata{
                    if i.commonKey?.rawValue == "artist"{
                        let artist = i.value as! String
                        Artist = artist
                    }
                    if i.commonKey?.rawValue == "title"{
                        let title = i.value as! String
                        Title = title
                    }
                }
                
                
                if self.parent.addLocalSongWhenCreate {
                    
                    self.parent.addedLocalSongUrls.append(url)
                }else{
                    
                    let asset = AVURLAsset(url: url)
                    guard asset.isComposable else {
                        print("Your music is Not Composible")
                        return
                    }
                    print("qweqweqweqwe\(url)")
                    // then lets create your document folder url
                    let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    
                    // lets create your destination file url
                    let destinationUrl = documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)
                    print(destinationUrl)
                    
                    // to check if it exists before downloading it
                    if FileManager.default.fileExists(atPath: destinationUrl.path) {
                        // print("The file already exists at path")
                        //self.playMusic(url: destinationUrl)
                        //self.parent.url = destinationUrl
                    } else {
                        // if the file doesn't exist you can use NSURLSession.sharedSession to download the data asynchronously
                        URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
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
                    //self.parent.url = destinationUrl
                    
                    
                    if Title == ""{
                        Title = "UnknownTitle"
                    }
                    
                    if Artist == ""{
                        Artist = "UnknownArtist"
                    }
                    
                    var song_file_names: [String] = []
                    
                    for songs in self.parent.initial_album_songs{
                        song_file_names.insert(songs.song_filename, at: 0)
                    }
                    
                    if !song_file_names.contains(destinationUrl.path){
                        
                        let song  = Songs(id: self.parent.initial_album_songs.count, album_name: self.parent.initial_album_songs[0].album_name, song_name: Title, song_filename: destinationUrl.path, artist: Artist, audio_from_internal_storage: true)
                        
                        self.parent.realManager.addSongToMix(mixID: self.parent.playing_music_realm_id, song_name: song.song_name, song_filename: song.song_filename, artist: song.artist, audio_from_internal_storage: song.audio_from_internal_storage)
                        //initial_album_songs = []
                        self.parent.initial_album_songs.append(song)
                    }
                }
                
            }
            
            
            
            //            guard let url = urls.first else { return }
            //            let asset = AVURLAsset(url: url)
            //            guard asset.isComposable else {
            //                print("Your music is Not Composible")
            //                return
            //            }
            //            addAudio(audioUrl: url)
            
            
            // self.parent.url = urls[0]
            
            
            
            //let bucker = storag
            
        }
        
        func delay(_ delay:Double, closure:@escaping ()->()) {
            DispatchQueue.main.asyncAfter(
                deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
        }
        
        func addAudio(audioUrl: URL) {
            // then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
            print(destinationUrl)
            
            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                // print("The file already exists at path")
                //self.playMusic(url: destinationUrl)
                self.parent.url = destinationUrl
            } else {
                // if the file doesn't exist you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) -> Void in
                    guard let location = location, error == nil else { return }
                    do {
                        // after downloading your file you need to move it to your destination url
                        try FileManager.default.moveItem(at: location, to: destinationUrl)
                        // self.playMusic(url: destinationUrl)
                        self.parent.url = destinationUrl
                        //print("File moved to documents folder")
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }).resume()
            }
        }
        
        
    }
}
