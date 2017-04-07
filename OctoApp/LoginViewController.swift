//
//  LoginViewController.swift
//  OctoApp
//
//  Created by Tim on 06.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit
import SafariServices



class LoginViewController: UIViewController, SFSafariViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func didTapSignIn(_ sender: Any) {
        let url = URL(string: OAuthConfig().authPath!)!
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        self.dismiss(animated: false, completion: nil)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        if !didLoadSuccessfully {
            controller.dismiss(animated: false, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
