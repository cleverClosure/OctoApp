//
//  DetailViewController.swift
//  OctoApp
//
//  Created by Tim on 05.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var avatarView: UIImageView!
    
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    
    var repository: Repo?
    

    func configureView() {
        // Update the user interface for the detail item.
        if let repository = repository {
            avatarView.kf.setImage(with: URL(string:repository.owner.avatarURL))
            if let forksCount = repository.forksCount {
                forksCountLabel.text = "\(forksCount)"
            }
            if let watchersCount = repository.watchersCount {
                forksCountLabel.text = "\(watchersCount)"
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GitHubAPI().fetchRepoDetails(repo: repository!) { fullRepo in
            self.repository = fullRepo
            self.configureView()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

