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
    
    
    var description: String {
        return "\(login)"
    }
    
    init(login: String, avatarURL: String) {
        self.login = login
        self.avatarURL = avatarURL
    }
    
    convenience required init?(json: [String: Any]) {
        guard let login = json["login"] as? String, let avatarURL = json["avatarURL"] as? String
            else {
                return nil
        }
        self.init(login: login, avatarURL: avatarURL)
    }
    
    convenience required init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any],
            let login = representation["login"] as? String, let avatarURL = representation["avatar_url"] as? String
            else {
                return nil
        }
        
        self.init(login: login, avatarURL: avatarURL)
    }
    
}
