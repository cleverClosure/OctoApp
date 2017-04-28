//
//  ProfileViewController.swift
//  OctoApp
//
//  Created by Tim on 11.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var avatarView: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var company: UILabel!

    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var following: UILabel!
    
    @IBOutlet var activityIndicatorView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView!.startAnimating()
        
        GitHubAPI().fetchMyself { user in
            self.configureView(user: user!)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func configureView(user: User) {
        avatarView.kf.setImage(with: URL(string: user.avatarURL), placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            self.activityIndicatorView.stopAnimating()
        }
        login.text = "@\(user.login)"
        name.text = user.name ?? ""
        company.text = user.company ?? ""
        bio.text = user.bio ?? ""
        
        if let fr = user.followers {
            followers.text = "\(fr)"
        }
        if let fg = user.following {
            following.text = "\(fg)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
