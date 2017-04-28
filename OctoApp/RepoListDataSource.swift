//
//  RepoDataSource.swift
//  OctoApp
//
//  Created by Tim on 26.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit


class RepoListDataSource: NSObject, UITableViewDataSource {
    var repos = [Repo]()
    
    public var gitApi: GitHubAPI? = nil
    
    
    init(gitApi: GitHubAPI) {
        self.gitApi = gitApi
    }
    
    func loadMyRepos(completionHandler: @escaping () -> Void) {
        gitApi?.fetchMyRepos { repos in
            if let repos = repos {
                self.repos = repos
            }
            completionHandler()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("#### repos.count \(repos.count)")
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RepoCell
        
        let repo = repos[indexPath.row]
        
        cell.title.text = repo.name
        cell.subtitle.text = repo.descr
        cell.avatarView.kf.setImage(with: URL(string: repo.owner.avatarURL))
        
        return cell
    }
    
}
