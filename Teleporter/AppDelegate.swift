//
//  AppDelegate.swift
//  Teleporter
//
//  Created by Michael Duong on 4/12/2019.
//  Copyright © 2019 Michael Duong. All rights reserved.
//

import UIKit
import TextAttributes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupAppearance()
        return true
    }
    
    fileprivate func setupAppearance() {
        let navigationBar = UINavigationBar.appearance();
        navigationBar.tintColor = UIColor.white
        navigationBar.barTintColor = UIColor.primaryColor()
        navigationBar.isTranslucent = false
        let titleAttrs = TextAttributes()
            .font(UIFont.defaultFont(size: 19))
            .foregroundColor(UIColor.white)
        navigationBar.titleTextAttributes = titleAttrs.dictionary
        
        let barButtonItem = UIBarButtonItem.appearance()
        let barButtonAttrs = TextAttributes()
            .font(UIFont.defaultFont(size: 15))
            .foregroundColor(UIColor.white)
        barButtonItem.setTitleTextAttributes(barButtonAttrs.dictionary, for: .normal)
        barButtonItem.setTitleTextAttributes(barButtonAttrs.dictionary, for: .highlighted)
        
    }

    var orientationLock = UIInterfaceOrientationMask.all
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

