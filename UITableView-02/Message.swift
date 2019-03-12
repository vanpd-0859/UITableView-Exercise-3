//
//  Message.swift
//  UITableView-02
//
//  Created by Phan Dinh Van on 3/12/19.
//  Copyright © 2019 Phan Dinh Van. All rights reserved.
//

import Foundation

class Message {
    var from: String!
    var to: String!
    var timestamp: TimeInterval!
    var message: String?
    init(from: String, to: String, timestamp: TimeInterval, message: String) {
        self.from = from
        self.to = to
        self.timestamp = timestamp
        self.message = message
    }
    
}
