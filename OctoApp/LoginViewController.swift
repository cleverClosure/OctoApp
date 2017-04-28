//
//  LoginViewController.swift
//  OctoApp
//
//  Created by Tim on 06.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit



protocol LoginViewControllerDelegate {
    func didTapSignIn()
}


class LoginViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapSignIn(_ sender: Any) {
        delegate?.didTapSignIn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
