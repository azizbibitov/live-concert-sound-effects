//
//  NativeAdView.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 11.04.2022.
//

import SwiftUI
import GoogleMobileAds

struct NativeAdView: View {
    
    var nativeAd: GADNativeAd
    
    var body: some View {
        VStack {
            HStack {
                Text("Advertisement")
                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/80))
                    .padding(.horizontal, 5)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                    )
                
            }
            .padding(.horizontal, 15)
            .padding(.top, 10)
            
            HStack {
                if nativeAd.icon?.image != nil{
                    Image(uiImage: (nativeAd.icon?.image)!)
                        .resizable()
                        .scaledToFill()
                        .mask(Circle())
                        .frame(width: UIScreen.main.bounds.width/9, height: UIScreen.main.bounds.height/20)
                        .padding(.leading, UIScreen.main.bounds.width/150)
                }
                
                VStack(alignment: .leading) {
                    Text(nativeAd.headline!)
                        .font(.custom("Nunito-ExtraBold", size: UIScreen.main.bounds.height/70))
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .lineSpacing(1)
                    
                    Text(nativeAd.advertiser ?? "Advert")
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/70))
                        .foregroundColor(.yellow)
                }
                
            }
            .padding(.horizontal, 15)
            Spacer()
            HStack {
                Text(nativeAd.body!)
                    .font(.custom("Nunito-Medium", size: UIScreen.main.bounds.height/80))
                    .padding(.horizontal, UIScreen.main.bounds.width/100)
                
            }
            Spacer()
            
            HStack(spacing: 15) {
                Text(nativeAd.price ?? "")
                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/70))
                    .lineLimit(1)
                    .padding(.leading, UIScreen.main.bounds.width/55)
                
                HStack {
                    ForEach(0..<Int(truncating: nativeAd.starRating ?? 0)) { _ in
                        Image(systemName: "star")
                            .font(.system(size: UIScreen.main.bounds.height/85))
                    }
                }
                .padding(.trailing, UIScreen.main.bounds.width/100)
      
                
            }
            
            
            Spacer()
            
        }       .frame(width:UIScreen.main.bounds.width/1.8, height: UIScreen.main.bounds.height/4.5)
            .cornerRadius(UIScreen.main.bounds.height/40)
            .background(
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill((Color.white))
                    .shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.76)), radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 0)
            )
          
    }
}



//                if let url = URL(string: "\(String(describing: nativeAd.advertiser))"){
//                    if let cTA = nativeAd.callToAction {
//
//                        Link(destination: url) {
//
//                            Text(cTA)
//                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                                .padding(.horizontal, 10)
//                                .padding(.vertical, 5)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .fill(Color(.systemBlue))
//                                )
//                                .foregroundColor(.white)
//
//                        }
//
//                    }
//                }
