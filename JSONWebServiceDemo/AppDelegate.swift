//
//  AppDelegate.swift
//  JSONWebServiceDemo
//
//  Created by Donald Angelillo on 2/19/16.
//  Copyright © 2016 Donald Angelillo. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityIndicator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?;

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        NetworkActivityIndicatorManager.sharedManager.isEnabled = true
        
        let mainViewController = MainViewController()
        let navController = UINavigationController(rootViewController: mainViewController)
        navController.navigationBar.barTintColor = UIColor(red: 46.0 / 255.0, green: 47.0 / 255.0, blue: 53.0 / 255.0, alpha: 1.0)
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        GenreManager.sharedGenreManager.getMusicGenres { (results) -> Void in
            
        }
    }

}

