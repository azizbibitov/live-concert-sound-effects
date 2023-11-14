//
//  Live_ConcertApp.swift
//  Live Concert
//
//  Created by Aziz Bibitov on 22.06.2022.
//

import SwiftUI
import GoogleMobileAds
import Siren
import FirebaseCore

@main
struct Live_ConcertApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window?.makeKeyAndVisible()
        
        application.beginReceivingRemoteControlEvents()
        
        GADMobileAds.sharedInstance().start(completionHandler: nil )
        
        FirebaseApp.configure()
        
        Siren.shared.wail() // Line 2
        
        return true
        
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = FSSceneDelegate.self // 👈🏻
        return sceneConfig
    }
    
}

//NSObject
class FSSceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions){
        window?.makeKeyAndVisible()
        
        Siren.shared.wail() // Line 2
        
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // ...
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // ...
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // ...
    }
    
    // ...
}
