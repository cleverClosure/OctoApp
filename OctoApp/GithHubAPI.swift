//
//  GithHubAPI.swift
//  OctoApp
//
//  Created by Tim on 05.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import Foundation
import Alamofire

class GitHubAPI {
    
    var config: TokenConfig?
    
    convenience init(config: TokenConfig) {
        self.init()
        self.config = config
    }
    
    init(){}
    
    func fetchMyRepos(completionHandler: @escaping ([Repo]?) -> Void) {
        fetchRepos(repoRouter: .getMyOwn(), completionHandler: completionHandler)
    }
    
    func fetchRepos(repoRouter: RepoRouter,  completionHandler: @escaping ([Repo]?) -> Void) {
        Alamofire.request(repoRouter).responseCollection { (response: DataResponse<[Repo]>) in
            if let repos = response.value {
                completionHandler(repos)
            } else {
                completionHandler(nil)
            }
        }
    }
    
}

