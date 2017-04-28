//
//  MasterViewController.swift
//  OctoApp
//
//  Created by Tim on 05.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit
import Kingfisher


protocol MasterViewControllerDelegate: class {
    func didSelect(repo: Repo)
}


class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    var delegate: MasterViewControllerDelegate?
    var dataSource: RepoListDataSource?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = dataSource
        refresh()

    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        
        if self.refreshControl == nil {
            self.refreshControl = UIRefreshControl()
            self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
            self.refreshControl?.addTarget(self, action: #selector(MasterViewController.refresh), for: .valueChanged)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    func refresh() {
        self.refreshControl?.beginRefreshing()
        dataSource?.loadMyRepos { [unowned self] _ in
            if self.refreshControl != nil && (self.refreshControl!.isRefreshing) {
                self.refreshControl?.endRefreshing()
            }
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //removed
    }

    // MARK: - Table View

    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let repo = dataSource?.repos[indexPath.row] else {
            print("#### can't find repo")
            return
        }
        
        delegate?.didSelect(repo: repo)
    }

}

