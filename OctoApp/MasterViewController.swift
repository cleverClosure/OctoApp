//
//  MasterViewController.swift
//  OctoApp
//
//  Created by Tim on 05.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit
import Kingfisher


class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Repo]()
    
    let gitHubAPI = GitHubAPI(config: TokenConfig())

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRepos()
    }
    
    func loadRepos() {
        GitHubAPI().fetchMyRepos { repos in
            
            if self.refreshControl != nil && self.refreshControl!.isRefreshing {
                self.refreshControl?.endRefreshing()
            }
            
            if let repos = repos {
                self.objects = repos
                self.tableView.reloadData()
                
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
        if self.refreshControl == nil {
            self.refreshControl = UIRefreshControl()
            self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
            self.refreshControl?.addTarget(self, action: #selector(MasterViewController.refresh), for: .valueChanged)
        }

    }
    
    func refresh() {
        loadRepos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! Repo
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.repository = object
//                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RepoCell

        let object = objects[indexPath.row]
        
        cell.title.text = object.name
        cell.subtitle.text = object.descr
        cell.avatarView.kf.setImage(with: URL(string: object.owner.avatarURL))
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

