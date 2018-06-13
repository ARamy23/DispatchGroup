//
//  Router.swift
//  DispatchGroup
//
//  Created by Ahmed Ramy on 6/10/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter
{
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do
        {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
        } catch
        {
            completion(nil, nil, error)
        }
        
        self.task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest
    {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 15)
        request.httpMethod = route.httpMethod.rawValue
        do
        {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestWithParamters(bodyParameters: let bodyParams, urlParameters: let urlParams):
                try self.configureParameters(bodyParameters: bodyParams, urlParameters: urlParams, request: &request)
            case .requestWithParametersAndHeaders(bodyParameters: let bodyParams, urlParameters: let urlParams, additionHeaders: let headers):
                self.addAdditionalHeaders(headers, request: &request)
                try self.configureParameters(bodyParameters: bodyParams, urlParameters: urlParams, request: &request)
            
            }
            return request
        }
        catch
        {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws
    {
        do
        {
            if let bodyParams = bodyParameters
            {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParams)
            }
            
            if let urlParams = urlParameters
            {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParams)
            }
        }
        catch
        {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ headers: HTTPHeaders?, request: inout URLRequest)
    {
        if let headers = headers
        {
            for (key, value) in headers
            {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
    }
}
