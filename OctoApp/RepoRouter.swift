//
//  RepoRouter.swift
//  OctoApp
//
//  Created by Tim on 07.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import Foundation
import Alamofire

enum RepoRouter: URLRequestConvertible {
    
    static let baseURLString: String = "https://api.github.com"
    
    case getPublic()
    case getMyOwn()
    
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .getPublic:
                return .get
            case .getMyOwn:
                return .get
            }
        }
        
        let url: URL = {
            let relativePath: String
            switch self {
            case .getPublic:
                relativePath = "/repositories"
            case .getMyOwn:
                relativePath = "/user/repos"

            }
            
            var url = URL(string: RepoRouter.baseURLString)!
            url.appendPathComponent(relativePath)
            return url
        }()
        
        let params: ([String: Any]?) = {
            switch self {
            case .getPublic, .getMyOwn:
                return nil
            }
        }()
        
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        // Set OAuth token if we have one
        if let token = TokenConfig().OAuthToken {
            urlRequest.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        }
        let encoding = JSONEncoding.default
        return try encoding.encode(urlRequest, with: params)
    }
    
    
}

