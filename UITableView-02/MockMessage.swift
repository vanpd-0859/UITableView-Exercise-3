//
//  MockMessage.swift
//  UITableView-02
//
//  Created by Phan Dinh Van on 3/13/19.
//  Copyright © 2019 Phan Dinh Van. All rights reserved.
//

import Foundation

class MockMessage {
    var serverMessage = [Message]()
    
    init() {
        serverMessage.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 100)!, message: "Hello world 1\nHello world 1\nHello world 1"))
        serverMessage.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 120)!, message: "Hello world 2\nHello world 2\nHello world 2"))
        serverMessage.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 140)!, message: "Hello world 3\nHello world 2\nHello world 2"))
        serverMessage.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 160)!, message: "Hello world 4\nHello world 2\nHello world 2"))
        serverMessage.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 170)!, message: "Hello world 5\nHello world 2\nHello world 2"))
        serverMessage.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 180)!, message: "Hello world 6\nHello world 2\nHello world 2"))
        serverMessage.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 190)!, message: "Hello world 7\nHello world 7\nHello world 7"))
        serverMessage.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 200)!, message: "Hello world 8"))
        serverMessage.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 201)!, message: "Hello world 9"))
        serverMessage.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 202)!, message: "Hello world 10"))
        serverMessage.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 203)!, message: "Hello world 11"))
        serverMessage.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 204)!, message: "Hello world 12"))
        serverMessage.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 205)!, message: "Hello world 13"))
        serverMessage.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 206)!, message: "Hello world 14"))
        serverMessage.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 207)!, message: "Hello world 15"))
        serverMessage.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 208)!, message: "Hello world 16"))
        serverMessage.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 209)!, message: "Hello world 17"))
        serverMessage.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 210)!, message: "Hello world 18"))
        serverMessage.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 211)!, message: "Hello world 19"))
        serverMessage.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 212)!, message: "Hello world 20"))
        serverMessage.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 213)!, message: "Hello world 21"))
        serverMessage.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 214)!, message: "Hello world 22"))
        serverMessage.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 215)!, message: "Hello world 23"))
        serverMessage.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 216)!, message: "Hello world 24"))
        serverMessage.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 217)!, message: "Hello world 25"))
        serverMessage.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 218)!, message: "Hello world 26"))
        serverMessage.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 219)!, message: "Hello world 27"))
        serverMessage.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 220)!, message: "Hello world 28"))
        serverMessage.append(Message(from: "2", to: "1", timestamp: TimeInterval.init(exactly: 221)!, message: "Hello world 29"))
        serverMessage.append(Message(from: "1", to: "2", timestamp: TimeInterval.init(exactly: 222)!, message: "Hello world 30"))
        serverMessage = serverMessage.sorted{ $0.timestamp >= $1.timestamp }
    }
    
    func getMessage(limit: Int, page: Int) -> [Message]? {
        if limit*page > serverMessage.count {
            return []
        } else {
            let begin = (page-1)*limit
            let end = page*limit-1
            let arr = serverMessage[begin...end]
            return Array(arr)
        }
    }
}
