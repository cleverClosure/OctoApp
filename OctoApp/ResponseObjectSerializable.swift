//
//  ResponseObjectSerializable.swift
//  OctoApp
//
//  Created by Tim on 07.04.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import Foundation


public protocol ResponseObjectSerializable {
    init?(response: HTTPURLResponse, representation: Any)
}
