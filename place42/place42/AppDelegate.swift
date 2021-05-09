//
//  AppDelegate.swift
//  place42
//
//  Created by 최강훈 on 2021/02/26.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase
import GoogleSignIn
import Messages

let googleApiKey = "AIzaSyBJvaTwMGsIVqMkZ7kyN6fcvDkdBHyz9ug"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    // 구글 로그인 관련.
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // sign함수 내 if let error ~ let credential 변수 까지는
        // google 공식 문서를 따름.
        if let error = error {
            print ("error: \(error)")
            return
        }
        
        guard let authentication = user.authentication
        else {
            print("can't get user.authentication")
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
    
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                let authError = error as NSError
            
                print("authError: \(authError)")
                return
            }
            print("sign in success")
        }
        
        
        guard let userProileEmail = user.profile.email
        else {
            print ("couldn't geet user email")
            return
        }
        print(userProileEmail)
    }
    

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(googleApiKey)
        GMSPlacesClient.provideAPIKey(googleApiKey)
        
        // 구글 로그인 관련.
        GIDSignIn.sharedInstance()?.clientID = "944731256906-uer210vtvfg4r8nrsdjbirg6cvk4iirs.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
        
        // Firebase 초기화.
        FirebaseApp.configure()
        
        // 화면에 앱 이미지를 1초 동안 띄웁니다.
        Thread.sleep(forTimeInterval: 1.0)
        
        // 앱 푸쉬 알림
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
            
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
    
        // 앱 푸시 알림 끝
        
        return true
    }
    // 앱 푸시 등록 실패시
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for notifications: \(error.localizedDescription)")
    }
    // 앱 푸시 등록 성공 시
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map{data in String(format:"%02.2hhx", data)}
        let token = tokenParts.joined()
        print("Device token: \(token)")
        
    }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    

    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}


