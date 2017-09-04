//
//  AppDelegate.swift
//  JTAnimations
//
//  Created by BJT on 2017/9/3.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeController = JTHomeController()
        let navigationController = JTNavigationController(rootViewController: homeController, isHideNavBar: true);
        
        if let window = window {
            
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            
        }
        
        
        
        return true
    }
    

}

