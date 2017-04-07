//
//  OAuthConfig.swift
//  OctoApp
//
//  Created by Tim on 06.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import Foundation
import Alamofire


// gets oauth token
class OAuthConfig {
    
    let clientID: String
    let clientSecret: String
    let authPath: String?
    
    init() {
        let path = Bundle.main.path(forResource: plistname, ofType: "plist")!
        let url = URL(fileURLWithPath: path)
        let dict = NSDictionary(contentsOf: url)
        self.clientSecret = dict!.value(forKey: "secret") as! String
        self.clientID = dict!.value(forKey: "id") as! String
        authPath = "https://github.com/login/oauth/authorize" + "?client_id=\(clientID)&scope=public_repo%20repo%20read:org%20user&state=TEST_STATE"
    }
    

    
    
    func authenticate(url: URL, complitionHandler: @escaping (TokenConfig?) -> Void) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var code: String?
        
        //
        if let queryItems = components?.queryItems {
            for qItem in queryItems {
                if qItem.name.lowercased() == "code" {
                    code = qItem.value
                }
            }
        }
    
        if let receivedCode = code {
            swapCodeForToken(receivedCode: receivedCode) { token in
                if let token = token {
                    let tokenConfig = TokenConfig(token: token)
                    complitionHandler(tokenConfig)
                } else {
                    print("Error: token is not valid")
                    complitionHandler(nil)
                }
                
            }
        }
    }
    
    
    func swapCodeForToken(receivedCode: String, completionHandler: @escaping (String?) -> Void) {
        let tokenURL = "https://github.com/login/oauth/access_token"
        let tokenParams = ["client_id": clientID, "client_secret": clientSecret, "code": receivedCode]
        let jsonHeader = ["Accept": "application/json"]
        
        Alamofire.request(tokenURL, method: .post, parameters: tokenParams, headers: jsonHeader).responseJSON { response in
            
            if let error = response.error {
                print("Error: \(error)")
                completionHandler(nil)
                return
            }
            
            if let receivedResults = response.result.value {
                let jsonData = receivedResults as! [String:String]
                print(jsonData)
                if let error = jsonData["error"] {
                    print("\(error), \(jsonData["error_description"])")
                    completionHandler(nil)
                    return
                }
                if let token = jsonData["access_token"] {
                    
                    completionHandler(token)
                }
            }
        }
        
    }
}
