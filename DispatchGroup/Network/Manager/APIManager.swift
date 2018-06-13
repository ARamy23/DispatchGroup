//
//  APIManager.swift
//  Dispatch Groups
//
//  Created by Ahmed Ramy on 6/5/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

class APIManager: NSObject
{
    var defaultURLSession: URLSession
    {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(15)
        configuration.timeoutIntervalForResource = TimeInterval(15)
        return URLSession(configuration: configuration)
    }
    
    func getVouchers(completionHandler: @escaping ([Voucher]?, URLResponse?, Error?) -> ())
    {
        guard let url = URL(string: Constants.mainURLString.rawValue + Constants.voucherExtension.rawValue) else {print("coudln't process the url"); return;}
        
        defaultURLSession.dataTask(with: url){ (data, response, error) in
            if error != nil
            {
                print(error.debugDescription)
                completionHandler(nil, nil, error)
                return
            }
            
            guard let vouchers = try? JSONDecoder().decode([Voucher].self, from: data!) else {fatalError("couldn't decode json object")}
            print(vouchers.map{($0.doctorName ?? "nil")})
            completionHandler(vouchers, response, nil)
    
            
        }.resume()
    }
    
    func getThreads(completionHandler: @escaping ([ThreadElement]?, URLResponse?, Error?) -> ())
    {
        guard let url = URL(string: Constants.mainURLString.rawValue + Constants.threadsExtension.rawValue) else {fatalError("couldn't create url")}
        var request: URLRequest = URLRequest(url: url)
        // FIXME:- Change this to the proper header values
        request.addValue("8a66abce571674f8", forHTTPHeaderField: "deviceid")
        request.addValue("efT8-ORohzo:APA91bHSHHP5jEoRxax4KXYbJN8pUO_B6SX-iazDVeJ74cxHe6FP3nMGOHUYE2ZjrPT7Pmc39MTmZVCe3dwiX_lAaIjoUw7vh6mJvimeswXb-pwGLvM6N4Ho-8iii7LepT-cJy27VCYd", forHTTPHeaderField: "token")
        request.addValue("com.coral.kempton", forHTTPHeaderField: "APP-ID")
        
        defaultURLSession.dataTask(with: request)
        {
            (data, response, error) in
            if error != nil
            {
                print(error.debugDescription)
                completionHandler(nil, nil, error)
            } else {
                print(url.absoluteString)
                let decoder = JSONDecoder()
                if let threads = try? decoder.decode(Thread.self, from: data!)
                {
                    print(threads)
                    completionHandler(threads, response, nil)

                }
                else
                {
                    print("didn't work")
                }
            }
            }.resume()
        
    }
    
    
    func getData<T: Codable>(endpoint: String, method: HTTPMethod?, params: [String: Any]?, headers: [String: String]?, model: T.Type, completion: @escaping (T?, URLResponse?, Error?) -> Void)
    {
        //1
        guard let url = URL(string: Constants.mainURLString.rawValue + endpoint) else {print("error with creating url"); return;}
        var request = URLRequest(url: url)
        
        //2
        request.httpMethod = method?.rawValue ?? "GET"
        
        //3
        if let headers = headers
        {
            for (key, value) in headers
            {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        //4
        if let parameters = params
        {
            do
            {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
            }
            catch let error
            {
                completion(nil, nil, error)
                return
            }
        }
        
        //5
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            //6
            if error != nil
            {
                completion(nil, nil, error)
                return
            }
            
            //7
            do
            {
                let jsonData = try JSONDecoder().decode(model, from: data!)
                completion(jsonData, response, nil)
            }
            catch let error
            {
                completion(nil, nil, error)
            }
        }.resume()
    }
    
    
}







