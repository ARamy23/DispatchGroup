//
//  Network Errors.swift
//  DispatchGroup
//
//  Created by Ahmed Ramy on 6/10/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

public enum NetworkError: String, Error
{
    case parametersWereNil = "Parameters were nil"
    case encodingFailed = "Parameters encoding failed"
    case missingURL = "URL is nil"
}
