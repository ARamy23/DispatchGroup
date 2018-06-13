//
//  HTTPTask.swift
//  DispatchGroup
//
//  Created by Ahmed Ramy on 6/10/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation


public typealias HTTPHeaders = [String: String]

enum HTTPTask
{
    case request
    case requestWithParamters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestWithParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}
