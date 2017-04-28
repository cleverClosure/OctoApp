//
//  AppCoordinator.swift
//  OctoApp
//
//  Created by Tim on 25.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    let window: UIWindow
    var rootViewController: UIViewController
    let childCoordinators: NSMutableArray
    
    init(window: UIWindow) {
        self.childCoordinators = NSMutableArray()
        self.rootViewController = UINavigationController()
        self.window = window
        
        self.window.backgroundColor = UIColor.white
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        // TokenConfig().OAuthToken = nil
        if TokenConfig().OAuthToken != nil {
            startMain(config: TokenConfig())
        } else {
            startLogin()
        }
    }
    
    func startLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: self.rootViewController as! UINavigationController)
        self.childCoordinators.add(loginCoordinator)
        loginCoordinator.start()
    }
    
    func startMain(config: TokenConfig) {
        self.rootViewController = UITabBarController(nibName: nil, bundle: nil)
        self.window.rootViewController = self.rootViewController
        let mainCoordinator = MainCoordinator(tabBarController: rootViewController as! UITabBarController)
        self.childCoordinators.add(mainCoordinator)
        mainCoordinator.start(config: config)
    }
    
    // after logging in to Github
    func returnFromSafari(with url: URL) {
        OAuthConfig().authenticate(url: url) { tokenConfig in
            self.startMain(config: tokenConfig!)
        }
    }
}
