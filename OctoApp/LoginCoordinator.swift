//
//  LoginCoordinator.swift
//  OctoApp
//
//  Created by Tim on 25.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit
import SafariServices


class LoginCoordinator: Coordinator, NavCoordinator {
    var navigationController: UINavigationController

    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginViewController.delegate = self
        self.navigationController.present(loginViewController, animated: false, completion: nil)
    }
    
}

extension LoginCoordinator: SFSafariViewControllerDelegate {
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        
        if !didLoadSuccessfully {
            
            navigationController.dismiss(animated: false, completion: nil)
        }
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    // presents Github login page
    func didTapSignIn() {
        let url = URL(string: OAuthConfig().authPath!)!
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        navigationController.dismiss(animated: false, completion: nil)
        navigationController.present(safariVC, animated: true, completion: nil)
    }
}
