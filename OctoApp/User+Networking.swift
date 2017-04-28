//
//  User+Networking.swift
//  OctoApp
//
//  Created by Tim on 08.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import Foundation
import Alamofire

extension User {
    private class func repoFromResponse(response: DataResponse<Any>) -> Result<Repo> {
        guard response.result.error == nil else {
            print(response.result.error!)
            return .failure(response.result.error!)
        }
        guard let json = response.result.value as? [String: Any] else {
            print("didn't get repo object as JSON from API")
            return .failure(BackendError.objectSerialization(reason:"Did not get JSON dictionary in response"))
        }
        guard let todo = Repo(json: json) else {
            return .failure(BackendError.objectSerialization(reason:"Could not create Repo object from JSON"))
        }
        return .success(todo)
    }
    
}
