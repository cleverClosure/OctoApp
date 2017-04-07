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
                    print("YYYYYYY")
                    try Locksmith.updateData(data: ["token": valueToSave], forUserAccount: "github")
                } catch {
                    let _ = try? Locksmith.deleteDataForUserAccount(userAccount: "github")
                }
            }
            else { // they set it to nil, so delete it
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
    
    var hasToken: Bool {
        return OAuthToken != nil
    }
    
    init(token: String) {
        setOAuthToken(token: token)
    }
    
    init() {
        
    }
    
    func setOAuthToken(token: String?) {
        self.OAuthToken = token
    }

}
