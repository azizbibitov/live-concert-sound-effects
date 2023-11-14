//
//  NativeAdView.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 11.04.2022.
//

import SwiftUI
import GoogleMobileAds

struct GridAdView: View {
    
    var nativeAd: GADNativeAd
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Advertisement")
                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/75))
                    .padding(.horizontal, 5)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                    )
                Spacer()
            }
            
            
            HStack {
                if nativeAd.icon?.image != nil{
                    Image(uiImage: (nativeAd.icon?.image)!)
                        .resizable()
                        .scaledToFill()
                        .mask(Circle())
                        .frame(width: UIScreen.main.bounds.width/9, height: UIScreen.main.bounds.height/20)
                        .padding(.leading, UIScreen.main.bounds.width/100)
                }
                
                VStack(alignment: .leading) {
                    Text(nativeAd.headline!)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.custom("Nunito-ExtraBold", size: UIScreen.main.bounds.height/75))
                       // .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    
                    Text(nativeAd.advertiser ?? "Advert")
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/85))
                        .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                }
                Spacer()
            }
            
            Spacer()
                Text(nativeAd.body!)
                    .font(.custom("Nunito-Medium", size: UIScreen.main.bounds.height/90))
                    .padding(.horizontal, UIScreen.main.bounds.width/100)
                    //.multilineTextAlignment(.center)
                    //.multilineTextAlignment(.leading)
            
            
            HStack() {
                Text(nativeAd.price ?? "")
                   // .multilineTextAlignment(.leading)
                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/70))
                    .lineLimit(1)
                    .padding(.leading, UIScreen.main.bounds.width/100)
                
                HStack(spacing: 0){
                    ForEach(0..<Int(truncating: nativeAd.starRating ?? 0)) { _ in
                        Image(systemName: "star")
                            .font(.system(size: UIScreen.main.bounds.height/100))
                    }
                }
                .padding(.trailing, UIScreen.main.bounds.width/100)
                
                
            }
            
            Spacer()
        }
        .frame(width:UIScreen.main.bounds.width/2.5, height: UIScreen.main.bounds.height/5)
        .cornerRadius(UIScreen.main.bounds.height/40)
        .background(
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .fill((Color.white))
                .shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.76)), radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 0)
        )
        
    }
}


