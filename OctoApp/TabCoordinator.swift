//
//  TabCoordinator.swift
//  OctoApp
//
//  Created by Tim on 26.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit


protocol TabCoordinator {
    var tabBarController: UITabBarController { get set }
    
    init(tabBarController: UITabBarController)
}

extension TabCoordinator {
    
}
