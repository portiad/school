//
//  FeedItem.swift
//  ExchangeAGram
//
//  Created by Portia Dean on 4/17/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import Foundation
import CoreData

@objc(FeedItem)
class FeedItem: NSManagedObject {

    @NSManaged var caption: String
    @NSManaged var image: NSData

}
