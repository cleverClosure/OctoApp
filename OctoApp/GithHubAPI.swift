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
    
    func get() {
        Alamofire.request("https://api.github.com/repositories", method: .get).responseJSON { response in
            print(response)
        }
    }
    
    
}

