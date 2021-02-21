//
//  AppDelegate.swift
//  Medha
//
//  Created by Ganesh Musini on 24/11/19.
//  Copyright © 2019 Ganesh Musini. All rights reserved.
//



import UIKit
import CoreData
import IQKeyboardManagerSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customizations after application launch.
        
        IQKeyboardManager.shared.enable = true
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = .clear
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().isTranslucent = true
        
        UINavigationBar.appearance().tintColor = .white
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]                
        
        let profileAvailable = self.isProfileAvailable()
 
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (granted, err) in
            
            guard granted else {return}
            
            DispatchQueue.main.async {
                
                UIApplication.shared.registerForRemoteNotifications()
                
            }
        }

        
        
        if profileAvailable
        {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let homeVC = MainSB.instantiateViewController(withIdentifier: "HomeViewController")
            let navigationController = UINavigationController.init(rootViewController: homeVC)
            self.window?.rootViewController = navigationController
            
        }
        
        return true
    }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("failed to register for remote notifications: \(error.localizedDescription)")
        UserDefaults.standard.setValue("0", forKey: pushKey)
    }

     func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        // 1. Convert device token to string
        let tokenParts = deviceToken.map { data -> String in
        return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        // 2. Print device token to use for PNs payloads
        print("Device Token: \(token)")
        
        let bundleID = Bundle.main.bundleIdentifier;
        print("Bundle ID: \(token) \(bundleID ?? "000")");
        // 3. Save the token to local storage and post to app server to generate Push Notification. ...
        
        UserDefaults.standard.setValue(token, forKey: pushKey)
        
    }
//
//    //Called if unable to register for APNS.
//    private func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
//        print("failed to register for remote notifications: \(error.localizedDescription)")
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//
//    }
    
//    private func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
//        print("Received push notification: \(userInfo)")
//    }

    //MARK: - Fetch Profile Data if Available and login directly
    //MARK: -
    
    func isProfileAvailable() -> Bool
    {
        var isavaialble = false
        
        let request : NSFetchRequest<ProfileData>
        request = ProfileData.fetchRequest()
        do
        {
            let results = try context.fetch(request)
            
            if results.count > 0
            {

               isavaialble = true
           }
           
        }
        catch let err
        {
           print(err.localizedDescription)
        }
        
        return isavaialble
    }
    

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Medha")
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
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      if application.applicationState == .active {
        if let aps = userInfo["aps"] as? NSDictionary {
          if let alertMessage = aps["alert"] as? String {
            let alert = UIAlertController(title: "Notification", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
          }
        }
      }
      completionHandler(.newData)
    }
}
