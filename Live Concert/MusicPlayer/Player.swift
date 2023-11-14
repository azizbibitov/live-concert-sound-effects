//
//  Player.swift
//  AudioPlayer
//
//  Created by Aziz Bibitov on 03.03.2022.
//

import AVKit
import SwiftUI

class Player : NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    let urlStr: String
    @Published var player: AVAudioPlayer
    
    init(urlStr: String) {
        self.urlStr = urlStr
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: urlStr, ofType: "mp3")!))
        super.init()
        player.delegate = self
    }
    
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
              print("The song ended")
        
        NotificationCenter.default.post(name: NSNotification.Name(urlStr), object: nil)
        }
    
    //@Published var player = try! AVAudioPlayer(contentsOf: url)
     
    @Published var isPlaying = false
    
    
    
    @Published var song = Song()
    
    @Published var angle : Double = 0
    
    @Published var volume : CGFloat = 0
    
    @Published var timeLine : CGFloat = 0
    
    func fetchAlbum(){
        
        let asset = AVAsset(url: player.url!)
        
        asset.metadata.forEach{ (meta) in
            
            switch(meta.commonKey?.rawValue){
                
            case "title": song.title = meta.value as? String ?? ""
            case "artist": song.artist = meta.value as? String ?? ""
            case "type": song.type = meta.value as? String ?? ""
            case "artwork": if meta.value != nil{song.artwork = UIImage(data: meta.value as! Data)!}
            default: ()
            }
        }
        
        //fetching audio volume level....
        volume = CGFloat(player.volume) * (UIScreen.main.bounds.width - 180)
        
        timeLine = CGFloat(player.currentTime) * (UIScreen.main.bounds.width - 70)
    }
    
    func songEnded() ->Bool {
        
        let soundProgress = player.currentTime / player.duration
        if soundProgress == 1 {
            return true
        } else {
            return false
        }
    }
    
    func updateTimer(){
        
        let currentTime = player.currentTime
        let total = player.duration
        let progress = currentTime / total
        
        withAnimation(Animation.linear(duration: 0.1)){
            self.timeLine = Double(progress) * (UIScreen.main.bounds.width - 70)
            self.angle = Double(progress) * 288
        }
        isPlaying = player.isPlaying
    }
    
    func onChanged(value: DragGesture.Value){
        
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        //12.5 = 25 => Circle Radius
        
        let radians = atan2(vector.dy - 12.5, vector.dx - 12.5)
        let tempAngle = radians * 180 / .pi
        
        let angle = tempAngle < 0 ? 360 + tempAngle : tempAngle
        
        //since maximum slide is 0.8
        //0.8*36 = 288
        if angle <= 288{
            
            //getting time...
            let progress = angle / 288
            let time = TimeInterval(progress) * player.duration
            player.currentTime = time
            player.play()
            withAnimation(Animation.linear(duration: 0.1)){self.angle = Double(angle)}
        }
    }
    
    func play(){
        if player.isPlaying{player.pause()}
        else{player.play()}
        isPlaying = player.isPlaying
    }
    
    func getCurrentTime(value: TimeInterval) -> String{
        
        return "\(Int(value / 60)):\(Int(value.truncatingRemainder(dividingBy:60)) < 9 ? "0" : "")\(Int(value.truncatingRemainder(dividingBy:60)))"
    }
    
    func updateVolume(value: DragGesture.Value){
        
        //Updating Volume....
        
        //160 width 20 circle size
        //total 180
        if value.location.x >= 0 && value.location.x <= UIScreen.main.bounds.width - 180{
            
            //updating volume
            let progress = value.location.x / (UIScreen.main.bounds.width - 180)
            player.volume = Float(progress)
            withAnimation(Animation.linear(duration: 0.1)){volume = value.location.x}
        }
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
                
            }
        }
    }
    
    
    
}
