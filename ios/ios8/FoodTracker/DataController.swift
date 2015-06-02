//
//  DataController.swift
//  FoodTracker
//
//  Created by Portia Dean on 6/1/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataController {
    
    class func jsonAsUSDIDNameSearchResults(json: NSDictionary) -> [(name: String, idValue:String)] {
        
        var usdaItemSearchResults: [(name:String, idValue: String)] = []
        var searchResult: (name:String, idValue:String)
        
        if json["hits"] != nil {
            let results: [AnyObject] = json["hits"] as! [AnyObject]
            
            for result in results {
                if result["_id"] != nil {
                    if result["fields"] != nil {
                        let fieldsDictionary = result["fields"] as! NSDictionary
                        
                        if fieldsDictionary["item_name"] != nil {
                            let idValue: String = result["_id"] as! String
                            let name: String = fieldsDictionary["item_name"] as! String
                            searchResult = (name: name, idValue: idValue)
                            usdaItemSearchResults += [searchResult]
                        }
                    }
                }
            }
        }
        return usdaItemSearchResults
    }
    
    func saveUSDAItemFromId(idValue:String, json: NSDictionary) {
        
        if json["hits"] != nil {
            let results: [AnyObject] = json["hits"] as! [AnyObject]
            
            for result in results {
                if result["_id"] != nil && result["_id"] as! String == idValue{
                    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
                    var requestForUSDAItem = NSFetchRequest(entityName: "USDAItem")
                    
                    let itemDictionaryId = result["_id"]! as! String
                    
                    // check if there is an exisiting id value in core data
                    let predicate = NSPredicate(format: "idValue == %@", itemDictionaryId)
                    requestForUSDAItem.predicate = predicate
                    
                    var error: NSError?
                    var items = managedObjectContext?.executeFetchRequest(requestForUSDAItem, error: &error)
                    
                    //var count = managedObjectContext?.countForFetchRequest(requestForUSDAItem, error: &error)
                    
                    if items?.count != 0 {
                        // item is already saved
                        return
                    } else {
                        println("Lets save this to core data!")
                    }
                
                }
            }
        }
    }
}