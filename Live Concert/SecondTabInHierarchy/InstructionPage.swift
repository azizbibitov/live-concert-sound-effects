//
//  InstructionPage.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 31.05.2022.
//

import SwiftUI

struct InstructionPage: View {
    
    @State var gradient = [Color("explore_back_gradient"), Color("explore_back_gradient2")]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 1, y: 1.5)
    
    
    @Binding var showInstructionPage: Bool
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 0)
                .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                .edgesIgnoringSafeArea(.all)
            
            
            VStack{
                
                HStack{
                    
                    Button(action: {
                        showInstructionPage = false
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: UIScreen.main.bounds.height/25))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("Instruction Page")
                        .foregroundColor(.white)
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/40))
                    
                    Spacer()
                    
                    
                    
                    
                }
                .padding(.top, UIScreen.main.bounds.height/20)
                .padding(.horizontal, UIScreen.main.bounds.width/20)
                
                
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    Text(" Here's how to create a playlist of songs in few steps: \n On the Discover screen of the app select the “Create Your Mix” button. Then, on the Playlist screen select any song from our list you wish to listen. By tapping on “Add Songs” icon in the top right corner, Premium subscribers can add the files they want on a playlist from their devices. \n At the bottom of your screen, tap Save. \n Select any sounds and adjust them to your preference to match your perfect ambiance. \n When you're finished, tap the Save button. \n Give your playlist a name and cover, then tap Save. \n After creating new playlist, you can customize your songs and sounds however you want.")
                        .foregroundColor(Color.white)
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/50))
                    //  .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.bottom, UIScreen.main.bounds.height/30)
                        .padding(.top, UIScreen.main.bounds.height/20)
                })
                
                
                Spacer()
                
            }.edgesIgnoringSafeArea(.all)
            
        }
    }
}

//struct InstructionPage_Previews: PreviewProvider {
//    static var previews: some View {
//        InstructionPage()
//    }
//}
