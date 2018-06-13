//
//  NetworkManager.swift
//  DispatchGroup
//
//  Created by Ahmed Ramy on 6/12/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

struct NetworkManager
{
    static let enviroment: NetworkEnviroment = .dev
    static let router = Router<MessagingAPI>()
}

enum NetworkResponse: String
{
    case success
    case authenticationError = "You need to be authenticated first"
    case badRequest = "Bad Request"
    case outdated = "The url you requested is outdated"
    case failed = "Network Request Failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We couldn't decode the response"
}

enum Result<String>
{
    case success
    case failure(String)
}
