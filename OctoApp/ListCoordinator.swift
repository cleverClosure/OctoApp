//
//  ListCoordinator.swift
//  OctoApp
//
//  Created by Tim on 26.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit


class ListCoordinator: Coordinator, NavCoordinator, MainCoordinatorDelegate, MasterViewControllerDelegate {
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {}
    
    func didSelect(repo: Repo) {
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailRepo") as! DetailViewController
        detailVC.repository = repo
        navigationController.pushViewController(detailVC, animated: true)
    }
}

