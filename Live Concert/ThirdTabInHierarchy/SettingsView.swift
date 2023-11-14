//
//  SettingsView.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 22.02.2022.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @EnvironmentObject var store: Store
    @State var gradient = [Color("premiumButtonGradient1"), Color("premiumButtonGradient2")]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 1, y: 2)
    
    @Binding var showIAPsView: Bool
    @Binding var isMonthlySubscribed: Bool
    var body: some View {
        ZStack{
            
            ZStack(alignment: .top){
                
                Color.clear
                ZStack(alignment: .bottom){
                    Image("back_settings")
                        .resizable()
                        .scaledToFill()
                        .frame(height: UIScreen.main.bounds.height*340/844)
                    
                    //                    Rectangle()                         // Shapes are resizable by default
                    //                        .foregroundColor(.clear)        // Making rectangle transparent
                    //                        .background(LinearGradient(gradient: Gradient(colors: [Color("setting_back"), .clear]), startPoint: .bottom, endPoint: .top))
                    //                        .frame(height:220)
                }
                
            }.edgesIgnoringSafeArea(.all)
            
            
            
            VStack{
                
                ZStack{
                    
                    Image("back_settings")
                        .resizable()
                        .scaledToFill()
                        .blur(radius: CGFloat(7))
                        .frame(width: UIScreen.main.bounds.width-UIScreen.main.bounds.width/5, height: UIScreen.main.bounds.height*340/844-UIScreen.main.bounds.height*340/844/2)
                    
                    VStack{
                        
                        
                        
                        HStack{
                            
                            Text("Get Premium")
                                .foregroundColor(Color("premium_text_color"))
                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/42))
                            Spacer()
                            Image("premium_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width*27/390, height: UIScreen.main.bounds.height*27/844)
                                .foregroundColor(.white)
                            
                        }.padding(.horizontal)
                            .padding(.top, UIScreen.main.bounds.height/100)
                            .frame(width: UIScreen.main.bounds.width-UIScreen.main.bounds.width/5)
                        
                        HStack{
                            VStack{
                                HStack{
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: UIScreen.main.bounds.height/60))
                                    
                                    Text("Unlock all sounds")
                                        .foregroundColor(.white)
                                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/70))
                                    
                                    Spacer()
                                }
                                
                                HStack{
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: UIScreen.main.bounds.height/60))
                                    
                                    Text("Remove ads")
                                        .foregroundColor(.white)
                                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/70))
                                    
                                    Spacer()
                                }
                                
                                HStack{
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: UIScreen.main.bounds.height/60))
                                    
                                    Text("Create Playlist")
                                        .foregroundColor(.white)
                                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/70))
                                    
                                    Spacer()
                                }
                            }.padding(.horizontal)
                        }
                        .frame(width: UIScreen.main.bounds.width-UIScreen.main.bounds.width/5)
                        
                        HStack{
                            VStack(alignment: .leading){
                                Text("Best price for you")
                                    .foregroundColor(.white)
                                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/70))
                                
                                Text("$4.99/month")
                                    .foregroundColor(.white)
                                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/55))
                                
                                
                            }.padding(.horizontal)
                            Spacer()
                            
                            Button {
//                                if store.subscriptions.count != 0{
//                                    Task {
//                                        await buy(product: store.subscriptions[1])
//                                    }
//                                }
                                
                                showIAPsView = true
                                print("Get Premium!")
                            } label: {
                                
                                RoundedRectangle(cornerRadius: 600)
                                    .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                                    .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.height/25)
                                    .overlay(
                                        Text("Get Premium")
                                            .foregroundColor(.black)
                                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                                    )
                            }.padding(.horizontal)
                            
                        }.frame(width: UIScreen.main.bounds.width-UIScreen.main.bounds.width/5)
                            .padding(.vertical, 5)
                        
                        
                    }
                    .frame(width: UIScreen.main.bounds.width-UIScreen.main.bounds.width/5, height: UIScreen.main.bounds.height*340/844-UIScreen.main.bounds.height*340/844/2)
                    
                    
                    //.background(BlurView(style: .systemUltraThinMaterialLight))
                }
                .overlay(
                    
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.blue.opacity(0.75), lineWidth: UIScreen.main.bounds.height/200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white.opacity(1), lineWidth: UIScreen.main.bounds.height/400)
                        )
                    
                    
                )
                .padding(.top, UIScreen.main.bounds.height/30)
                
                
                VStack{
                    
                    Link(destination: URL(string: "https://azico.team/privacy.html")!) {
                        HStack{
                            
                            Image(systemName: "checkmark.shield.fill")
                                .foregroundColor(.white)
                                .font(.system(size: UIScreen.main.bounds.height/33))
                            
                            Text("Privace Policy")
                                .foregroundColor(.white)
                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/52))
                            Spacer()
                            Image(systemName: "arrow.right.circle.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: UIScreen.main.bounds.height/45))
                            
                        }.frame(width: UIScreen.main.bounds.width-UIScreen.main.bounds.width/4)
                            .padding(.vertical, 13)
                    }
                    
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width-UIScreen.main.bounds.width/5, height: 2)
                        .foregroundColor(.white.opacity(0.1))
                    
                    Link(destination: URL(string: "https://azico.team/terms.html")!) {
                        HStack{
                            
                            Image(systemName: "doc.text.fill")
                                .foregroundColor(.white)
                                .font(.system(size: UIScreen.main.bounds.height/33))
                            
                            Text("Terms of Use")
                                .foregroundColor(.white)
                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/52))
                            Spacer()
                            Image(systemName: "arrow.right.circle.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: UIScreen.main.bounds.height/45))
                            
                        }.frame(width: UIScreen.main.bounds.width-UIScreen.main.bounds.width/4)
                            .padding(.vertical, 13)
                    }
                    
                    
                    
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width-UIScreen.main.bounds.width/5, height: 2)
                        .foregroundColor(.white.opacity(0.1))
                    
                    
                    
                    Link(destination: URL(string: "https://apps.apple.com/us/app/live-concert-sound-effects/id1621842040")!) {
                        HStack{
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.white)
                                .font(.system(size: UIScreen.main.bounds.height/33))
                            
                            Text("Rate us")
                                .foregroundColor(.white)
                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/52))
                            Spacer()
                            Image(systemName: "arrow.right.circle.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: UIScreen.main.bounds.height/45))
                            
                        }.frame(width: UIScreen.main.bounds.width-UIScreen.main.bounds.width/4)
                            .padding(.vertical, 13)
                    }
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width-UIScreen.main.bounds.width/5, height: 2)
                        .foregroundColor(.white.opacity(0.1))
                    
                    
                    Link(destination: URL(string: "https://apps.apple.com/us/developer/maksat-meredov/id1629872467")!) {
                        
                        HStack{
                            
                            Image(systemName: "square.stack.3d.up.fill")
                                .foregroundColor(.white)
                                .font(.system(size: UIScreen.main.bounds.height/33))
                            
                            Text("More Apps")
                                .foregroundColor(.white)
                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/52))
                            Spacer()
                            Image(systemName: "arrow.right.circle.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: UIScreen.main.bounds.height/45))
                            
                        }.frame(width: UIScreen.main.bounds.width-UIScreen.main.bounds.width/4)
                            .padding(.vertical, 13)
                    }
                    
                    
                    
                }.padding(.top, 20)
                
                Spacer()
                VStack{
                    Text("Payment will be charged to iTunes Account at confirmation of purchase. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period. Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal. Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase. No cancelation of the current subscription is allowed during active subscription period. Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable.")
                        .foregroundColor(Color.white)
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/90))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, UIScreen.main.bounds.width/5)
                }
                
                Spacer()
                
                let appVersionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
                
                Text("App version \(appVersionString)")
                    .foregroundColor(.white)
                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/52))
                    .padding(.bottom)
                
            }
        }
        .background(Color("setting_back"))
        
    }
    
    func buy(product: Product) async {
        do {
            if try await store.purchase(product) != nil {
                withAnimation { if product == store.subscriptions[1]{
                    isMonthlySubscribed = true
                    Task {
                        //When `purchasedIdentifiers` changes, get the latest subscription status.
                        await updateSubscriptionStatus()
                    }
                }
                }
            }
        } catch StoreError.failedVerification {
            //errorTitle = "Your purchase could not be verified by the App Store."
            // isShowingError = true
        } catch {
            print("Failed purchase for \(store.cars[0].id): \(error)")
        }
    }
    
    @MainActor
    func updateSubscriptionStatus() async {
        do {
            //This app has only one subscription group so products in the subscriptions
            //array all belong to the same group. The statuses returned by
            //`product.subscription.status` apply to the entire subscription group.
            guard let product = store.subscriptions.first,
                  let statuses = try await product.subscription?.status else {
                      return
                  }
            
            var highestStatus: Product.SubscriptionInfo.Status? = nil
            var highestProduct: Product? = nil
            
            //Iterate through `statuses` for this subscription group and find
            //the `Status` with the highest level of service which isn't
            //expired or revoked.
            for status in statuses {
                switch status.state {
                case .expired, .revoked:
                    continue
                default:
                    let renewalInfo = try store.checkVerified(status.renewalInfo)
                    
                    guard let newSubscription = store.subscriptions.first(where: { $0.id == renewalInfo.currentProductID }) else {
                        continue
                    }
                    
                    guard let currentProduct = highestProduct else {
                        highestStatus = status
                        highestProduct = newSubscription
                        continue
                    }
                    
                    let highestTier = store.tier(for: currentProduct.id)
                    let newTier = store.tier(for: renewalInfo.currentProductID)
                    
                    if newTier > highestTier {
                        highestStatus = status
                        highestProduct = newSubscription
                    }
                }
            }
            
            //            status = highestStatus
            //            currentSubscription = highestProduct
        } catch {
            print("Could not update subscription status \(error)")
        }
    }
    
}


//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}




struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
