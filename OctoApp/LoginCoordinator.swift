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
            print("#### dismiss safari")
            navigationController.dismiss(animated: false, completion: nil)
        }
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func didTapSignIn() {
        print("#### DID TAP")
        let url = URL(string: OAuthConfig().authPath!)!
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        navigationController.dismiss(animated: false, completion: nil)
//        self.present(safariVC, animated: true, completion: nil)
//        navigationController.pushViewController(safariVC, animated: true)
        navigationController.present(safariVC, animated: true, completion: nil)
    }
}
