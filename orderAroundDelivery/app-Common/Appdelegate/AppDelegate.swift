//
//  AppDelegate.swift
//  Goheavy
//
//  Created by CSS on 19/05/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps
import UserNotifications
import Fabric
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setLocalization(language: .english)
        setGoogleMapKey()
        FirebaseApp.configure()
        self.appearence()
        window?.rootViewController = Router.setWireFrame()
        window?.makeKeyAndVisible()
        self.registerPush(forApp: application)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       //print("-->>>>>",UIApplication.shared.backgroundTimeRemaining)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    
    private func setGoogleMapKey(){
        
        GMSServices.provideAPIKey(googleMapKey)
        
    }
    
    // MARK:- Register Push
    private func registerPush(forApp application : UIApplication){
//        let center = UNUserNotificationCenter.current()
//
//        center.requestAuthorization(options:[.alert, .sound]) { (granted, error) in
//
//            if granted {
//                DispatchQueue.main.async {
//                    application.registerForRemoteNotifications()
//                }
//            }
//        }
        
        let content = UNMutableNotificationContent()

        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "alert_tone.mp3"))

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: "TestIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate {

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Pass device token to auth
        // Auth.auth().setAPNSToken(deviceToken, type: AuthAPNSTokenType.sandbox)
        // Messaging.messaging().apnsToken = deviceToken
        deviceTokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Apn Token ", deviceToken.map { String(format: "%02.2hhx", $0) }.joined())
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification notification: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Notification  :  ", notification)
        
        completionHandler(.newData)
        
    }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("Error in Notification  \(error.localizedDescription)")
    }
    
    
}

extension AppDelegate {
    // MARK:- Appearence
    private func appearence() {
        
//        if let languageStr = UserDefaults.standard.value(forKey: Keys.list.language) as? String, let language = Language(rawValue: languageStr) {
//            setLocalization(language: language)
//        }else {
//            setLocalization(language: .english)
//        }
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .darkGray
        var attributes = [NSAttributedString.Key : Any]()
        attributes.updateValue(UIColor.black, forKey: .foregroundColor)
        attributes.updateValue(UIFont(name: FontCustom.bold.rawValue, size: 16.0)!, forKey : NSAttributedString.Key.font)
        UINavigationBar.appearance().titleTextAttributes = attributes
        attributes.updateValue(UIFont(name:FontCustom.meduim.rawValue, size: 18.0)!, forKey : NSAttributedString.Key.font)
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().largeTitleTextAttributes = attributes
        }
        
        UIPageControl.appearance().pageIndicatorTintColor = .lightGray
        UIPageControl.appearance().currentPageIndicatorTintColor = .primary
        UIPageControl.appearance().backgroundColor = .clear
        
    }
    
}
