//
//  Voucher.swift
//  Dispatch Groups
//
//  Created by Ahmed Ramy on 6/5/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

/*
 "voucher": "TERoaGVZYjcxNTI2NDg2MTY4",
 "event_id": 1,
 "amount": "8855.00",
 "schedule_date": 1526475601,
 "facility": null,
 "diagnosis": null,
 "voucherText": "This voucher validates approval of Kempton Group Provider coverage for a sepcific service. This voucher cannot be used for any other service except those listed below (see Description of Service)",
 */

import Foundation



struct Voucher: Codable
{
    var valid_to: String?
    var valid_from: String?
    var diagnosis: String?
    var participant_email: String?
    var facility: String?
    var doctorName: String?
    var HDHP: String?
    var precert: String?
    var boltOn: String?
    var voucher: String?
    var amount: String?
    var schedule_date: Int?
    var voucherText: String?
    var participantFirstName: String?
    var participantLastName: String?
    var participant_DOB: String?
    var tpa: String?
    var provider: String?
    
    var cpt: [CPTS]?
}

struct CPTS: Codable
{
    let id: Int?
    let code: String?
    let title: String?
    let description: String?
}
