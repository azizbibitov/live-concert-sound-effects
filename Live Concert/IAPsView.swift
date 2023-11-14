//
//  IAPsView.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 06.05.2022.
//

import SwiftUI
import StoreKit

struct IAPsView: View {
    @EnvironmentObject var store: Store
    @Binding public var showIAPsView: Bool
    @Binding var isPurchased: Bool
    @Binding var isMonthlySubscribed: Bool
    @Binding var isWeeklySubscribed: Bool
    
    
    
    @State var iap_plan_number: Int = 2
    @State var gradient = [Color("premiumButtonGradient1"), Color("premiumButtonGradient2")]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 1, y: 2)
    @State var product_purchasing: Product!
    
    @State var currentSubscription: Product?
    @State var status: Product.SubscriptionInfo.Status?
    
    var body: some View {
        ZStack{
            //Image("main_image")
            Image("back")
                .resizable()
            //.scaledToFill()
                .edgesIgnoringSafeArea(.all)
            //.frame( height: 850)
            
            VStack{
                
                HStack{
                    
                    Button(action: {
                        
                        withAnimation {
                            self.showIAPsView = false
                        }
                        
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: UIScreen.main.bounds.height/25))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("")
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
                
                Spacer()
                
                HStack{
                    Image("premium_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width*27/390, height: UIScreen.main.bounds.height*27/844)
                        .foregroundColor(.white)
                    
                    Text("Premium")
                        .foregroundColor(Color("premium_text_color_2"))
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/37))
                }
                .padding(.bottom, 25)
                
                VStack{
                    Text("Get Premium and unlock more sounds")
                        .foregroundColor(Color.white.opacity(0.6))
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                    Text("and get all features")
                        .foregroundColor(Color.white.opacity(0.6))
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                }
                .padding(.bottom, 15)
                if (store.subscriptions.count == 0 || store.cars.count == 0){
                    Text("It seems, you have internet connection issue. At this moment app can't get all purchases sorry")
                        .foregroundColor(Color("premium_text_color_2"))
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/45))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }else{
                
                Button {
                    
                    iap_plan_number = 1
                    if store.subscriptions.count != 0{
                        product_purchasing = store.subscriptions[0]
                    }
                } label: {
                 
                        if currentSubscription == store.subscriptions[0] {
                            VStack{
                                if let status = status {
                                    StatusInfoView(product: currentSubscription!,
                                                   status: status)
                                        .environmentObject(store)
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width/1.6, height: UIScreen.main.bounds.height/10)
                            .background(Color("premium_paid"))
                            .cornerRadius(UIScreen.main.bounds.height/60)
                       
                    }else{
                        
                        VStack{
                            HStack {
                                Text("7-day plan")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/48))
                                    .padding(.horizontal, UIScreen.main.bounds.width/50)
                                    .padding(.top, UIScreen.main.bounds.height/100)
                                    .padding(.bottom, 1)
                                
                                if isWeeklySubscribed{
                                    Spacer()
                                    Text("Subscribed Already")
                                        .foregroundColor(.white)
                                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/90))
                                        .padding(.trailing, 10)
                                }
                            }
                            
                            HStack{
                                VStack{
                                    HStack{
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: UIScreen.main.bounds.height/75))
                                        
                                        Text("Unlock all sounds")
                                            .foregroundColor(.white)
                                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/80))
                                        
                                        Spacer()
                                    }
                                    
                                    HStack{
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: UIScreen.main.bounds.height/75))
                                        
                                        Text("Remove ads")
                                            .foregroundColor(.white)
                                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/80))
                                        
                                        Spacer()
                                    }
                                    
                                    HStack{
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: UIScreen.main.bounds.height/75))
                                        
                                        Text("Full playlist access")
                                            .foregroundColor(.white)
                                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/80))
                                        
                                        Spacer()
                                    }
                                }.padding(.horizontal, UIScreen.main.bounds.width/50)
                                
                                VStack{
                                    Text("just for")
                                        .foregroundColor(Color.white.opacity(0.6))
                                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                                        .padding(.trailing)
                                    Text("$1.99")
                                        .font(.custom("Nunito-ExtraBold", size: UIScreen.main.bounds.height/45))
                                        .foregroundColor(.white)
                                        .padding(.trailing)
                                }
                                
                            }
                            Spacer()
                        }
                        .background(
                            iap_plan_number == 1 ? AnyView(BackImage(image: "gradient_premium", width: UIScreen.main.bounds.width/1.6, height: UIScreen.main.bounds.height/10)) : AnyView(Color.white.opacity(0.2))
                        )
                        .frame(width: UIScreen.main.bounds.width/1.6, height: UIScreen.main.bounds.height/10)
                        .cornerRadius(UIScreen.main.bounds.height/60)
                    }
                    
                }
                
                Button {
                    
                    iap_plan_number = 2
                } label: {
                    
                    if currentSubscription == store.subscriptions[1] {
                        VStack{
                            if let status = status {
                                StatusInfoView(product: currentSubscription!,
                                               status: status)
                                    .environmentObject(store)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width/1.6, height: UIScreen.main.bounds.height/10)
                        .background(Color("premium_paid"))
                        .cornerRadius(UIScreen.main.bounds.height/60)
                        
                    }else{
                        
                        VStack{
                            Text("Monthly plan")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/48))
                                .padding(.horizontal, UIScreen.main.bounds.width/50)
                                .padding(.top, UIScreen.main.bounds.height/100)
                                .padding(.bottom, 1)
                            HStack{
                                VStack{
                                    HStack{
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: UIScreen.main.bounds.height/75))
                                        
                                        Text("Unlock all sounds")
                                            .foregroundColor(.white)
                                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/80))
                                        
                                        Spacer()
                                    }
                                    
                                    HStack{
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: UIScreen.main.bounds.height/75))
                                        
                                        Text("Remove ads")
                                            .foregroundColor(.white)
                                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/80))
                                        
                                        Spacer()
                                    }
                                    
                                    HStack{
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: UIScreen.main.bounds.height/75))
                                        
                                        Text("Full playlist access")
                                            .foregroundColor(.white)
                                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/80))
                                        
                                        Spacer()
                                    }
                                }.padding(.horizontal, UIScreen.main.bounds.width/50)
                                
                                if iap_plan_number == 2 {
                                    VStack{
                                        Text("just for")
                                            .foregroundColor(Color.white.opacity(0.6))
                                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                                            .padding(.trailing)
                                        Text("$4.99")
                                            .font(.custom("Nunito-ExtraBold", size: UIScreen.main.bounds.height/45))
                                            .foregroundColor(.white)
                                            .padding(.trailing)
                                        
                                    }
                                    .padding(.trailing, UIScreen.main.bounds.height/100)
                                    
                                }else{
                                    VStack{
                                        Text("just for")
                                            .foregroundColor(Color.white.opacity(0.6))
                                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                                            .padding(.trailing)
                                        Text("$4.99")
                                            .font(.custom("Nunito-ExtraBold", size: UIScreen.main.bounds.height/45))
                                            .foregroundColor(.white)
                                            .padding(.trailing)
                                    }
                                }
                                
                            }
                            Spacer()
                        }
                        .background(
                            iap_plan_number == 2 ? AnyView(BackImage(image: "gradient_premium_best", width: UIScreen.main.bounds.width/1.55, height: UIScreen.main.bounds.height/10)) : AnyView(Color.white.opacity(0.2))
                        )
                        .frame(width: iap_plan_number == 2 ? UIScreen.main.bounds.width/1.55 : UIScreen.main.bounds.width/1.6, height: UIScreen.main.bounds.height/10)
                        .padding(.leading, iap_plan_number == 2 ? UIScreen.main.bounds.width/90 : 0)
                        .cornerRadius(UIScreen.main.bounds.height/60)
                    }
                }
                
                Button {
                    iap_plan_number = 3
                    product_purchasing = store.cars[0]
                } label: {
                    VStack{
                        HStack {
                            Text("Lifetime plan")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/48))
                                .padding(.horizontal, UIScreen.main.bounds.width/50)
                                .padding(.top, UIScreen.main.bounds.height/100)
                                .padding(.bottom, 1)
                            
                            if isPurchased{
                                Spacer()
                                Text("Purchased Already")
                                    .foregroundColor(.white)
                                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/90))
                                    .padding(.trailing, 10)
                            }
                        }
                        
                        HStack{
                            VStack{
                                HStack{
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: UIScreen.main.bounds.height/75))
                                    
                                    Text("Unlock all sounds")
                                        .foregroundColor(.white)
                                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/80))
                                    
                                    Spacer()
                                }
                                
                                HStack{
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: UIScreen.main.bounds.height/75))
                                    
                                    Text("Remove ads")
                                        .foregroundColor(.white)
                                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/80))
                                    
                                    Spacer()
                                }
                                
                                HStack{
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: UIScreen.main.bounds.height/75))
                                    
                                    Text("Full playlist access")
                                        .foregroundColor(.white)
                                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/80))
                                    
                                    Spacer()
                                }
                            }.padding(.horizontal, UIScreen.main.bounds.width/50)
                            
                            
                            VStack{
                                Text("just for")
                                    .foregroundColor(Color.white.opacity(0.6))
                                    .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                                    .padding(.trailing)
                                Text("$19.99")
                                    .font(.custom("Nunito-ExtraBold", size: UIScreen.main.bounds.height/45))
                                    .foregroundColor(.white)
                                    .padding(.trailing)
                            }
                            
                        }
                        Spacer()
                    }
                        Spacer()
                    }
                    .background(
                        iap_plan_number == 3 ? AnyView(BackImage(image: "gradient_premium", width: UIScreen.main.bounds.width/1.6, height: UIScreen.main.bounds.height/10)) : AnyView(Color.white.opacity(0.2))
                    )
                    .frame(width: UIScreen.main.bounds.width/1.6, height: UIScreen.main.bounds.height/10)
                    .cornerRadius(UIScreen.main.bounds.height/60)
                    
                
                    Spacer()
                
                Button {
                    print("SUBSCRIBE")
                    
                    if iap_plan_number == 2{
                        product_purchasing = store.subscriptions[1]
                    }
                    
                    
                    Task {
                        await buy(product: product_purchasing)
                    }
                } label: {
                    
                    RoundedRectangle(cornerRadius: 600)
                        .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                        .frame(width: UIScreen.main.bounds.width/2.7, height: UIScreen.main.bounds.height/17)
                        .overlay(
                            Text("SUBSCRIBE")
                                .foregroundColor(.black)
                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/55))
                        )
                }
               // .padding(.top, UIScreen.main.bounds.height/10)
                }
                Spacer()
                VStack{
                    Text("Payment will be charged to iTunes Account at confirmation of purchase. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period. Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal. Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase. No cancelation of the current subscription is allowed during active subscription period. Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable.")
                        .foregroundColor(Color.white.opacity(0.6))
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/80))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                VStack{
                    Text("If you don't have any idea about purchasing Premium")
                        .foregroundColor(Color.white.opacity(0.6))
                        .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                    HStack(spacing: 0){
                        Text("you can read our ")
                            .foregroundColor(Color.white.opacity(0.6))
                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                        
                        
//                         Link("Some label", destination: URL(string: "https://www.mylink.com")!)
                        
                        Link(destination: URL(string: "https://azico.team/terms.html")!) {
                            Text("Terms of Use")
                                //.foregroundColor(Color.white.opacity(0.6))
                                .foregroundColor(.white)
                                .underline()
                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                        }


                        //                        Button {
                        //                            print("Link to Terms Of Use")
                        //
                        //                        } label: {
                        //                            Text("Terms of Use")
                        //                                .foregroundColor(Color.white.opacity(0.6))
                        //                                .underline()
                        //                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                        //
                        //                        }

                        Text(" or ")
                            .foregroundColor(Color.white.opacity(0.6))
                            .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                        
                        
                        Link(destination: URL(string: "https://azico.team/privacy.html")!) {
                            Text("Privacy Policy")
                               // .foregroundColor(Color.white.opacity(0.6))
                                .foregroundColor(.white)
                                .underline()
                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                        }
                        
                        //                        Button {
                        //                            print("Link to Privacy Policy")
                        //                        } label: {
                        //                            Text("Privacy Policy")
                        //                                .foregroundColor(Color.white.opacity(0.6))
                        //                                .underline()
                        //                                .font(.custom("Nunito-SemiBold", size: UIScreen.main.bounds.height/65))
                        //                        }
                    }
                    
                }
                .padding(.bottom, UIScreen.main.bounds.height/30)
                
                // Terms of Use or Privacy Policy
                
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .edgesIgnoringSafeArea(.all)
            
        }
        
        .onAppear {
//            if !(store.subscriptions.count == 0 || store.cars.count == 0){
//                Task {
//                    //When this view appears, get the latest subscription status.
//                    isPurchased = (try? await store.isPurchased(store.cars[0].id)) ?? false
//                    isMonthlySubscribed = (try? await store.isPurchased(store.subscriptions[1].id)) ?? false
//                    isWeeklySubscribed = (try? await store.isPurchased(store.subscriptions[0].id)) ?? false
//                    await updateSubscriptionStatus()
//                }
//            }
            

                   Task {
                       //When this view appears, get the latest subscription status.
                       await updateSubscriptionStatus()
                   }
        }
        .onChange(of: store.purchasedIdentifiers) { _ in
            Task {
                //When `purchasedIdentifiers` changes, get the latest subscription status.
                await updateSubscriptionStatus()
            }
        }
    }
    
    
    func buy(product: Product) async {
        do {
            if try await store.purchase(product) != nil {
                withAnimation {
                    if product == store.cars[0]{
                        isPurchased = true
                        UserDefaults.standard.set(isPurchased, forKey: "isPurchased")
                    }else if product == store.subscriptions[1]{
                        isMonthlySubscribed = true
                        UserDefaults.standard.set(isMonthlySubscribed, forKey: "isMonthlySubscribed")
                        Task {
                            //When `purchasedIdentifiers` changes, get the latest subscription status.
                            await updateSubscriptionStatus()
                        }
                    } else if product == store.subscriptions[0]{
                        isWeeklySubscribed = true
                        UserDefaults.standard.set(isWeeklySubscribed, forKey: "isWeeklySubscribed")
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
            
            status = highestStatus
            currentSubscription = highestProduct
        } catch {
            print("Could not update subscription status \(error)")
        }
    }
    
}

struct BackImage: View {
    
    let image: String
    let width: CGFloat
    let height: CGFloat
    var body: some View {
        Image(image)
            .resizable()
        // .scaledToFit()
            .edgesIgnoringSafeArea(.all)
        // .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(width: width, height: height)
        
    }
}

struct IAPsView_Previews: PreviewProvider {
    @State static var showIAPsView = false
    @State static var isPurchased = false
    static var previews: some View {
        IAPsView(showIAPsView: $showIAPsView,isPurchased: $isPurchased, isMonthlySubscribed: $isPurchased, isWeeklySubscribed: $isPurchased)
    }
}


//Button {
//
//    Task {
//        await buy()
//    }
//
//    showIAPsView = false
//} label: {
//    Text("Purchase all albums and Get Back")
//}


//Image("main_image")
//    .resizable()
//    .scaledToFill()
//    .edgesIgnoringSafeArea(.all)
//    .frame( height: 850)
