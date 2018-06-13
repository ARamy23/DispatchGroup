//
//  ThreadsEndPoint.swift
//  DispatchGroup
//
//  Created by Ahmed Ramy on 6/12/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

enum NetworkEnviroment
{
    case dev
    case release
}

enum MessagingAPI
{
    case threads
}

extension MessagingAPI: EndPointType
{
    var baseURL: URL {
        guard let url = URL(string: enviromentBaseURL) else { fatalError("baseURL Couldn't be configured")}
        return url
    }
    
    var path: String {
        switch self
        {
        case .threads:
            return Constants.threadsExtension.rawValue
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self
        {
        case .threads:
            return .requestWithParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionHeaders: ["deviceid": "8a66abce571674f8" ,
                                                                                                               "token": "efT8-ORohzo:APA91bHSHHP5jEoRxax4KXYbJN8pUO_B6SX-iazDVeJ74cxHe6FP3nMGOHUYE2ZjrPT7Pmc39MTmZVCe3dwiX_lAaIjoUw7vh6mJvimeswXb-pwGLvM6N4Ho-8iii7LepT-cJy27VCYd",
                                                                                                               "APP-ID":"com.coral.kempton"])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return ["deviceid": "8a66abce571674f8" ,
                "token": "efT8-ORohzo:APA91bHSHHP5jEoRxax4KXYbJN8pUO_B6SX-iazDVeJ74cxHe6FP3nMGOHUYE2ZjrPT7Pmc39MTmZVCe3dwiX_lAaIjoUw7vh6mJvimeswXb-pwGLvM6N4Ho-8iii7LepT-cJy27VCYd",
                "APP-ID":"com.coral.kempton"]
    }
    
    var enviromentBaseURL: String
    {
        switch NetworkManager.enviroment
        {
        case .dev:
            return Constants.mainURLString.rawValue
        case .release:
            return Constants.mainURLString.rawValue
        }
    }
}
