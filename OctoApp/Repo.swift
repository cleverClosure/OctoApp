//
//  Repo.swift
//  OctoApp
//
//  Created by Tim on 07.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import Foundation


final class Repo: CustomStringConvertible, ResponseObjectSerializable, ResponseCollectionSerializable {
    let name: String
    let descr: String
    let owner: User
    var forksCount: Int?
    var watchersCount: Int?
    
    var description: String {
        return "\(name)"
    }
    
    init(name: String, descr: String, owner: User, forksCount: Int? = nil, watchersCount: Int? = nil) {
        self.name = name
        self.descr = descr
        self.owner = owner
        self.forksCount = forksCount
        self.watchersCount = watchersCount
    }
    
    convenience required init?(json: [String: Any]) {
        guard let name = json["name"] as? String, let descr = json["description"] as? String, let ownerJSON = json["owner"] as? [String : Any]
            else {
                return nil
        }
        let owner = User(json: ownerJSON)
        let forks = json["forks_count"] as? Int
        let watchers = json["watchers_count"] as? Int
        
        self.init(name: name, descr: descr, owner: owner!, forksCount: forks, watchersCount: watchers)
    }
    
    convenience required init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any],
            let name = representation["name"] as? String, let descr = representation["description"] as? String, let ownerRep = representation["owner"]
            else {
                return nil
                
        }
        
        let owner = User(response: response, representation: ownerRep)
        
        let forks = representation["forks_count"] as? Int
        let watchers = representation["watchers_count"] as? Int
        
        self.init(name: name, descr: descr, owner: owner!, forksCount: forks, watchersCount: watchers)
    }
    
    class func collection(response: HTTPURLResponse, representation: AnyObject) -> [Repo] {
        let postArray = representation as! [AnyObject]
        return postArray.map({ Repo(response:response, representation: $0)! })
    }
}
