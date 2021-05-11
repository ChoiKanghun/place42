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
import FirebaseMessaging
import BackgroundTasks

let googleApiKey = "AIzaSyBJvaTwMGsIVqMkZ7kyN6fcvDkdBHyz9ug"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var fetchCount: Int = 0
    
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
        GIDSignIn.sharedInstance()?.clientID = GooglePrivateInfo.shared.clientId
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
        
        Messaging.messaging().delegate = self
    
        // 앱 푸시 알림 끝
        
        // 백그라운드 fetch 설정
        
        
//        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.kchoi.place42.test", using: nil) { (task) in
//
//            self.scheduleAppRefresh()
//
//            let queue = OperationQueue()
//            queue.maxConcurrentOperationCount = 1
//            queue.addOperation {
//                self.fetchCount += 1
//                print(self.fetchCount)
//            }
//            task.setTaskCompleted(success: true)
//
//        }
        registerBackgroundTasks()
        return true
    }
    
    
// MARK:- background tasks
    func registerBackgroundTasks() {
        if #available(iOS 13.0 , *) {
            //Register the BGAppRereshTask
            print("Entered to registering tasks function")
            
            BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.kchoi.place42.refresh", using: nil) { task in
                self.handleAppRefresh(task: task as! BGAppRefreshTask)
            }
            
            BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.kchoi.place42.dataprocessing", using: nil) { task in
                self.handleDataProcessing(task: task as! BGProcessingTask)
            }
        }
    }
    
    func scheduleAppRefresh() {
        print("Entered to scheduleAppRefresh")
        let request = BGAppRefreshTaskRequest(identifier: "com.kchoi.place42.refresh")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 1 * 60)
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Couldn't schedule app refresh : \(error)")
        }
    }
    
    func scheduleDataProcessing() {
        print("Entered to dataprocessing")

        let request = BGProcessingTaskRequest(identifier: "com.kchoi.place42.dataprocessing")
        request.requiresNetworkConnectivity = true
        // request.requiresExternalPower = true
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("couldn't schedule database cleaning : \(error)")
        }
    }
    
    func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleAppRefresh()
        
        var completionStatus = true
        print("handler App Refresh called")
        
        task.expirationHandler = {
            print("handler app refresh done")
        }
        task.setTaskCompleted(success: completionStatus)
    }
    
    func handleDataProcessing(task: BGProcessingTask) {
        var completionStatus = true
        
        print("handler dataprocessing called")

        task.expirationHandler = {
            print("handleDataProcessing done")
        }
        
        task.setTaskCompleted(success: completionStatus)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Application Did Enter Background")
        scheduleAppRefresh()
        scheduleDataProcessing()
    }
//    func applicationDidEnterBackground(_ application: UIApplication) {
//        scheduleAppRefresh()
//    }
//
//    func scheduleAppRefresh() {
//        let request = BGAppRefreshTaskRequest(identifier: "com.kchoi.place42.test")
//
//        request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60)
//
//        do {
//            try BGTaskScheduler.shared.submit(request)
//        } catch {
//            print("Couldn't schedule app refresh: \(error)")
//        }
//    }
//
    
    // 앱 푸시 등록 실패시
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for notifications: \(error.localizedDescription)")
    }
    // 앱 푸시 등록 성공 시
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        /*클라우드 푸시 등록 성공 시*/
        
        /* 로컬 푸시 등록 성공 시
        let tokenParts = deviceToken.map{data in String(format:"%02.2hhx", data)}
        let token = tokenParts.joined()
        print("Device token: \(token)")
         */
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

// MARK:- 메시징 FIREBASE
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        Messaging.messaging().token {
            (token, error) in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
            
            }
        }
        
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }
}
