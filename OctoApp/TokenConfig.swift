//
//  TokenConfig.swift
//  OctoApp
//
//  Created by Tim on 06.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import Foundation
import Locksmith

let plistname = "githubapi"

class TokenConfig {

    var OAuthToken: String? {
        set {
            if let valueToSave = newValue {
                do {
                    try Locksmith.updateData(data: ["token": valueToSave], forUserAccount: "github")
                } catch {
                    let _ = try? Locksmith.deleteDataForUserAccount(userAccount: "github")
                }
            }
            else {
                let _ = try? Locksmith.deleteDataForUserAccount(userAccount: "github")
            }
        }
        
        get {
            // try to load from keychain
            let dictionary = Locksmith.loadDataForUserAccount(userAccount: "github")
            if let token = dictionary?["token"] as? String {
                return token
            }
            return nil
        }
    }
    
    init(token: String) {
        OAuthToken = token
    }
    
    init() {}
}
