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
        
        if let results: [AnyObject] = json["hits"] as? [AnyObject] {
            
            for result in results {
                if let idValue: String = result["_id"] as? String {
                    if result["fields"] != nil {
                        let fieldsDictionary = result["fields"] as! NSDictionary
                        
                        if let name: String = fieldsDictionary["item_name"] as? String {
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
        
        if let results: [AnyObject]? = json["hits"] as? [AnyObject] {

            for result in results! {
                if result["_id"] as? String == idValue {
                    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
                    var requestForUSDAItem = NSFetchRequest(entityName: "USDAItem")
                    
                    let resultId = result["_id"]! as! String
                    
                    // check if there is an exisiting id value in core data
                    let predicate = NSPredicate(format: "idValue == %@", resultId)
                    requestForUSDAItem.predicate = predicate
                    
                    var error: NSError?
                    var items = managedObjectContext?.executeFetchRequest(requestForUSDAItem, error: &error)
                    
                    //var count = managedObjectContext?.countForFetchRequest(requestForUSDAItem, error: &error)
                    
                    if items?.count != 0 {
                        // item is already saved
                        return
                    } else {
                        println("Lets save this to core data!")
                        
                        let entityDescription = NSEntityDescription.entityForName("USDAItem", inManagedObjectContext: managedObjectContext!)
                        let usdaItem = USDAItem(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
                        
                        usdaItem.idValue = result["_id"]! as! String
                        
                        usdaItem.dateAdded = NSDate()
                        
                        if let fieldsDictionary = result["fields"] as? NSDictionary {
                            
                            usdaItem.name = fieldsDictionary["item_name"] as? String
                            
                            if let usdaFields = fieldsDictionary["usda_fields"] as? NSDictionary{
                                
                                if let calciumFields = usdaFields["CA"] as? NSDictionary {
                                    let calciumValue: AnyObject = calciumFields["value"]! as AnyObject
                                    usdaItem.calcium = "\(calciumValue)"
                                } else {
                                    usdaItem.calcium = "0"
                                }
                                
                                if let carbohydrateFields = usdaFields["CHOCDF"] as? NSDictionary {
                                    let carbohydrateValue: AnyObject = carbohydrateFields["value"]! as AnyObject
                                    usdaItem.carbohydrate = "\(carbohydrateValue)"
                                } else {
                                    usdaItem.carbohydrate = "0"
                                }
                                
                                if let cholesterolFields = usdaFields["CHOLE"] as? NSDictionary {
                                    let cholesterolValue: AnyObject = cholesterolFields["value"]! as AnyObject
                                    usdaItem.cholesterol = "\(cholesterolValue)"
                                } else {
                                    usdaItem.cholesterol = "0"
                                }
                                
                                if let energyFields = usdaFields["ENERC_KCAL"] as? NSDictionary {
                                    let energyValue: AnyObject = energyFields["value"]! as AnyObject
                                    usdaItem.energy = "\(energyValue)"
                                } else {
                                    usdaItem.energy = "0"
                                }
                                
                                if let fatTotalFields = usdaFields["FAT"] as? NSDictionary {
                                    let fatTotalValue: AnyObject = fatTotalFields["value"]! as AnyObject
                                    usdaItem.fatTotal = "\(fatTotalValue)"
                                } else {
                                    usdaItem.fatTotal = "0"
                                }
                                
                                if let proteinFields = usdaFields["PROCNT"] as? NSDictionary {
                                    let proteinValue: AnyObject = proteinFields["value"]! as AnyObject
                                    usdaItem.protein = "\(proteinValue)"
                                } else {
                                    usdaItem.protein = "0"
                                }
                                
                                if let sugarFields = usdaFields["SUGAR"] as? NSDictionary {
                                    let sugarValue: AnyObject = sugarFields["value"]! as AnyObject
                                    usdaItem.sugar = "\(sugarValue)"
                                } else {
                                    usdaItem.sugar = "0"
                                }
                                
                                if let vitaminCFields = usdaFields["VITC"] as? NSDictionary {
                                    let vitaminCValue: AnyObject = vitaminCFields["value"]! as AnyObject
                                    usdaItem.vitaminC = "\(vitaminCValue)"
                                } else {
                                    usdaItem.vitaminC = "0"
                                }
                                
                                (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
                                println("test")
                            }
                        }
                    }
                }
            }
        }
    }
}