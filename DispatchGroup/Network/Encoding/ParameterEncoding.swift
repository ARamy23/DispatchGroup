//
//  ParameterEncoding.swift
//  DispatchGroup
//
//  Created by Ahmed Ramy on 6/10/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder
{
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public struct URLParameterEncoder: ParameterEncoder
{
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty
        {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters
            {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil
        {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}

public struct JSONParameterEncoder: ParameterEncoder
{
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do
        {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil
            {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }
        catch
        {
            throw NetworkError.encodingFailed
        }
        
    }
}
