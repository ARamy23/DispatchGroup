//
//  Thread.swift
//  Dispatch Groups
//
//  Created by Ahmed Ramy on 6/6/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

/*
 "threadId": 5,
 "topic": "infrared vision augmentation",
 "participant": "AHP100-7605-1",
 "participantName": "MORGAN SMITH",
 "tpa": 1,
 "tpaName": "Kempton Group",
 "provider": null,
 "providerName": null,
 "lastMessageBody": "",
 "lastMessageTimestamp": 1527627149,
 "threadStartTimeStamp": 1526555382,
 "threadStartString": "2018-05-17 13:09:42",
 "lastAccessTime": 1527675850
 */

typealias Thread = [ThreadElement]

struct ThreadElement: Codable {
    let threadID: String?
    let topic: String?
    let participant: String?
    let participantName: String?
    let tpa: String?
    let tpaName: String?
    let provider: String?
    let providerName: String?
    let lastMessageBody: String?
    let lastMessageTimestamp: String?
    let threadStartTimeStamp: String?
    let threadStartString: String?
    let lastAccessTime: String?
    
    enum CodingKeys: String, CodingKey {
        case threadID = "threadId"
        case topic = "topic"
        case participant = "participant"
        case participantName = "participantName"
        case tpa = "tpa"
        case tpaName = "tpaName"
        case provider = "provider"
        case providerName = "providerName"
        case lastMessageBody = "lastMessageBody"
        case lastMessageTimestamp = "lastMessageTimestamp"
        case threadStartTimeStamp = "threadStartTimeStamp"
        case threadStartString = "threadStartString"
        case lastAccessTime = "lastAccessTime"
    }
}
