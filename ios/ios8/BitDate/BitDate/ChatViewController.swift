//
//  ChatViewController.swift
//  BitDate
//
//  Created by Portia Dean on 6/15/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import Foundation

class ChatViewViewController: JSQMessagesViewController {
    
    var messages: [JSQMessage] = []
    var matchID: String?
    var messageListener: MessageListener?
    
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // do any additional setup after loading view
        
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        
        // Set sender information
        self.senderId = currentUser()!.id
        self.senderDisplayName = currentUser()!.name
        
        if let id = matchID {
            fetchMessages(matchID!, { (messages) in
                for m in messages {
                    self.messages.append(JSQMessage(senderId: m.senderId, senderDisplayName: m.senderId, date: m.date, text: m.message))
                }
                self.finishReceivingMessage()
            })
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if let id = matchID {
            messageListener = MessageListener(matchID: id, startDate: NSDate(), callback: { (message) in
                self.messages.append(JSQMessage(senderId: message.senderId, senderDisplayName: message.senderId, date: message.date, text: message.message))
                self.finishReceivingMessage()
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        messageListener?.stop()
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
    
        var data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        var data = self.messages[indexPath.row]
        if data.senderId == PFUser.currentUser()!.objectId {
            return outgoingBubble
        } else {
            return incomingBubble
        }
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        let m = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        self.messages.append(m)
        
        if let id = matchID {
            saveMessage(id, Message(message: text, senderId: senderId, date: date))
        }
        finishSendingMessage()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count;
    }
}