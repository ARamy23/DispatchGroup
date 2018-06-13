//
//  Constants.swift
//  Dispatch Groups
//
//  Created by Ahmed Ramy on 6/5/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

enum Constants: String
{
    case mainURLString = "https://dev.wifimetropolis.com:8060/api/"
    case voucherExtension = "getVouchers?user_id=AHP100-7605-1"
    case threadsExtension = "messaging/threads"
    
}

enum Navigation: String
{
    case goToDetails = "goToDetails"
    
}

enum StoryboardsID: String
{
    case HomeViewController = "HomeViewController"
    case DetailsViewController = "DetailsViewController"
}
