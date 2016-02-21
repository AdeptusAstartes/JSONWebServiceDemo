//
//  AppDelegate.swift
//  JSONWebServiceDemo
//
//  Created by Donald Angelillo on 2/19/16.
//  Copyright © 2016 Donald Angelillo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?;

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let mainViewController = MainViewController()
        let navController = UINavigationController(rootViewController: mainViewController)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

