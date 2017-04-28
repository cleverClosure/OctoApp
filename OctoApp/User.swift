//
//  User.swift
//  OctoApp
//
//  Created by Tim on 08.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import Foundation


final class User: CustomStringConvertible, ResponseObjectSerializable, ResponseCollectionSerializable {
    
    var login: String
    var avatarURL: String
    var name: String?
    var company: String?
    var bio: String?
    var followers: Int?
    var following: Int?
    
    var description: String {
        return "\(login)"
    }
    
    init(login: String, avatarURL: String, name: String? = nil, company: String? = nil, bio: String? = nil, followers: Int? = nil, following: Int? = nil) {
        self.login = login
        self.avatarURL = avatarURL
        self.name = name
        self.company = company
        self.bio = bio
        self.followers = followers
        self.following = following
    }
    
    convenience required init?(json: [String: Any]) {
        guard let login = json["login"] as? String, let avatarURL = json["avatarURL"] as? String
            else {
                return nil
        }
        let name = json["name"] as? String
        let company = json["company"] as? String
        let bio = json["bio"] as? String
        let followers = json["followers"] as? Int
        let following = json["following"] as? Int
        
        self.init(login: login, avatarURL: avatarURL, name: name, company: company, bio: bio, followers: followers, following: following)
    }
    
    convenience required init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any],
            let login = representation["login"] as? String, let avatarURL = representation["avatar_url"] as? String
            else {
                return nil
        }
        
        let name = representation["name"] as? String
        let company = representation["company"] as? String
        let bio = representation["bio"] as? String
        let followers = representation["followers"] as? Int
        let following = representation["following"] as? Int
        
        self.init(login: login, avatarURL: avatarURL, name: name, company: company, bio: bio, followers: followers, following: following)
    }
}
