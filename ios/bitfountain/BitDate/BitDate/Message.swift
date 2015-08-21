//
//  Message.swift
//  BitDate
//
//  Created by Portia Dean on 6/16/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import Foundation

struct Message {
    let message: String
    let senderId: String
    let date: NSDate
}

class MessageListener {
    var currentHandle: UInt?
    
    //setting up firebase and looking a certain match, starting from the date passed in looking for child added
    init (matchID: String, startDate: NSDate, callback: (Message) -> ()) {
        let handle = ref.childByAppendingPath(matchID).queryOrderedByKey().queryStartingAtValue(dateFormatter().stringFromDate(startDate)).observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) in
            let message = snapshotToMessage(snapshot)
            callback(message)
        })
        self.currentHandle = handle
    }
    
    // stop listening for firebase updates when not on that window
    func stop() {
        if let handle = self.currentHandle {
            ref.removeObserverWithHandle(handle)
            self.currentHandle = nil
        }
    }
}

private let ref = Firebase(url: "URL https://bitdatepd.firebaseio.com/messages")
private let dateFormat = "yyyyMMddHHmmss"

private func dateFormatter() -> NSDateFormatter {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter
}

func saveMessage(matchID: String, message: Message) {
    ref.childByAppendingPath(matchID).updateChildValues([dateFormatter().stringFromDate(message.date) : ["message" : message.message, "sender": message.senderId]])
}

private func snapshotToMessage(snapshot: FDataSnapshot) -> Message {
    let date = dateFormatter().dateFromString(snapshot.key)!
    let sender = snapshot.value["sender"] as! String
    let text = snapshot.value["text"] as! String
    
    return Message(message: text, senderId: sender, date: date)
}

func fetchMessages(matchID: String, callback:([Message]) -> ()) {
    ref.childByAppendingPath(matchID).queryLimitedToFirst(25).observeSingleEventOfType(FEventType.Value, withBlock: { (snapshot) in
        
        var messages = Array<Message>()
        let enumerator = snapshot.children
        
        while let data = enumerator.nextObject() as? FDataSnapshot {
            messages.append(snapshotToMessage(data))
            
        }
        callback(messages)
    })
}