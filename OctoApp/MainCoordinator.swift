//
//  MainCoordinator.swift
//  OctoApp
//
//  Created by Tim on 25.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit

protocol MainCoordinatorDelegate {
    
}


class MainCoordinator: Coordinator, TabCoordinator {
    
    var tabBarController: UITabBarController
    
    required init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start(config: TokenConfig) {
        // Setting tabs
        
        let navigationController = UINavigationController(nibName: nil, bundle: nil)
        
        let masterVC = instantiateMasterVC(navigationController: navigationController, config: config)
        
//        navigationController.viewControllers = [ masterVC ]
        navigationController.pushViewController(masterVC, animated: false)
        navigationController.tabBarItem = UITabBarItem(title: "My repos", image: UIImage(named: "folder"), tag: 0)
        
        let profileVC = instantiateProfileVC()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 1)
        
        tabBarController.viewControllers = [ navigationController, profileVC ]
    
    }
    
    
    func instantiateMasterVC(navigationController: UINavigationController, config: TokenConfig) -> MasterViewController {
        let masterVC = storyboard.instantiateViewController(withIdentifier: "MasterRepo") as! MasterViewController
        masterVC.dataSource = RepoListDataSource(gitApi: GitHubAPI(config: config))
        let delegate = ListCoordinator(navigationController: navigationController) as? MasterViewControllerDelegate
        masterVC.delegate = delegate
        return masterVC
    }
    
    func instantiateProfileVC() -> ProfileViewController {
        let profileVC = storyboard.instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController
        return profileVC
    }
    
    
    
}
