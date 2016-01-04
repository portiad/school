//
//  DetailViewController.swift
//  FoodTracker
//
//  Created by Portia Dean on 5/31/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit
import HealthKit

class DetailViewController: UIViewController {
    
    var usdaItem: USDAItem?

    @IBOutlet weak var textView: UITextView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "usdaItemDidComplete:", name: kUSDAItemCompleted, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        requestAuthorizationForHealthStore()
        
        if usdaItem != nil {
            textView.attributedText = createAttributedString(usdaItem!)
        }
    }
    
    // best pratice to remove observer once you have completed
    deinit {
        print("usdaItemDidComplete in DetailViewController")
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func eatItBarButtonPressed(sender: UIBarButtonItem) {
        saveFoodItem(usdaItem!)
    }
    
    func usdaItemDidComplete(notification: NSNotification) {
        usdaItem = notification.object as? USDAItem
        
        if self.isViewLoaded() && self.view.window != nil {
            textView.attributedText = createAttributedString(usdaItem!)
        }
    }
    
    func createAttributedString(usdaItem: USDAItem!) -> NSAttributedString {
        let itemAttributedString = NSMutableAttributedString()
        
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = NSTextAlignment.Center
        centeredParagraphStyle.lineSpacing = 10.0
        
        let titleAttributesDictionary = [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont.boldSystemFontOfSize(22.0), NSParagraphStyleAttributeName: centeredParagraphStyle]
        let titleString = NSAttributedString(string: "\(usdaItem.name!)\n", attributes: titleAttributesDictionary)
        
        itemAttributedString.appendAttributedString(titleString)
        
        let leftAlignedParagraphStyle = NSMutableParagraphStyle()
        leftAlignedParagraphStyle.alignment = NSTextAlignment.Left
        leftAlignedParagraphStyle.lineSpacing = 20.0
        
        let styleFirstWordAttributesDictionary = [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont.boldSystemFontOfSize(18.0), NSParagraphStyleAttributeName: leftAlignedParagraphStyle]
        let styleOneAttributesDictionary = [NSForegroundColorAttributeName: UIColor.darkGrayColor(), NSFontAttributeName: UIFont.systemFontOfSize(18.0), NSParagraphStyleAttributeName: leftAlignedParagraphStyle]
        let styleTwoAttributesDictionary = [NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSFontAttributeName: UIFont.systemFontOfSize(18.0), NSParagraphStyleAttributeName: leftAlignedParagraphStyle]
        
        itemAttributedString.appendAttributedString(generateAttributeString("Calcium", usdaValue: usdaItem.calcium, styleTitleAttribute: styleFirstWordAttributesDictionary, styleBobyAttribute: styleOneAttributesDictionary))
        itemAttributedString.appendAttributedString(generateAttributeString("Carbohydrate", usdaValue: usdaItem.carbohydrate, styleTitleAttribute: styleFirstWordAttributesDictionary, styleBobyAttribute: styleTwoAttributesDictionary))
        itemAttributedString.appendAttributedString(generateAttributeString("Cholesterol", usdaValue: usdaItem.cholesterol, styleTitleAttribute: styleFirstWordAttributesDictionary, styleBobyAttribute: styleOneAttributesDictionary))
        itemAttributedString.appendAttributedString(generateAttributeString("Energy", usdaValue: usdaItem.energy, styleTitleAttribute: styleFirstWordAttributesDictionary, styleBobyAttribute: styleTwoAttributesDictionary))
        itemAttributedString.appendAttributedString(generateAttributeString("Fat", usdaValue: usdaItem.fatTotal, styleTitleAttribute: styleFirstWordAttributesDictionary, styleBobyAttribute: styleOneAttributesDictionary))
        itemAttributedString.appendAttributedString(generateAttributeString("Protein", usdaValue: usdaItem.protein, styleTitleAttribute: styleFirstWordAttributesDictionary, styleBobyAttribute: styleTwoAttributesDictionary))
        itemAttributedString.appendAttributedString(generateAttributeString("Sugar", usdaValue: usdaItem.sugar, styleTitleAttribute: styleFirstWordAttributesDictionary, styleBobyAttribute: styleOneAttributesDictionary))
        itemAttributedString.appendAttributedString(generateAttributeString("Vitamin C", usdaValue: usdaItem.vitaminC, styleTitleAttribute: styleFirstWordAttributesDictionary, styleBobyAttribute: styleTwoAttributesDictionary))
        
        return itemAttributedString
    }
    
    func generateAttributeString(usdaName: String, usdaValue: NSString, styleTitleAttribute: [NSObject: AnyObject], styleBobyAttribute: [NSObject: AnyObject] ) -> NSMutableAttributedString {
        var attributeString = NSMutableAttributedString()
        
        let usdaTitleString = NSAttributedString(string: "\(usdaName.capitalizedString) ", attributes:styleTitleAttribute)
        let usdaBodyString = NSAttributedString(string: String(format: "%.2f%% \n", usdaValue.doubleValue), attributes: styleBobyAttribute )
        
        attributeString.appendAttributedString(usdaTitleString)
        attributeString.appendAttributedString(usdaBodyString)
        
        return attributeString
    }
    
    func requestAuthorizationForHealthStore() {
        let dataTypesToWrite = [
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCalcium),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCarbohydrates),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCholesterol),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryFatTotal),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryProtein),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySugar),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryVitaminC)
        ]
        
        let dataTypesToRead = [
                HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCalcium),
                HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCarbohydrates),
                HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCholesterol),
                HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed),
                HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryFatTotal),
                HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryProtein),
                HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySugar),
                HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryVitaminC)
        ]
        
        var store: HealthStoreConstant = HealthStoreConstant()
        
        store.healthStore?.requestAuthorizationToShareTypes(NSSet(array: dataTypesToWrite) as Set, readTypes: NSSet(array: dataTypesToRead) as Set, completion: { (success, error) -> Void in
            if success {
                print("User authorization success")
            } else {
                print("User canceled request")
            }
        })
    }
    
    func saveFoodItem(foodItem: USDAItem) {
        if HKHealthStore.isHealthDataAvailable() {
            let timeFoodWasEntered = NSDate()
            
            let foodMetaData = NSDictionary(dictionaryLiteral: foodItem.name!, HKMetadataKeyFoodType, "USDA Item", "HKBrandName", foodItem.idValue, "HKFoodTypeId") as [NSObject: AnyObject]
            
//            let foodMetaData = [
//                HKMetadataKeyFoodType : foodItem.name,
//                "HKBrandName" : "USDAItem",
//                "HKFoodTypeID" : foodItem.idValue
//            ]
            
            let calciumUnit = HKQuantity(unit: HKUnit.gramUnitWithMetricPrefix(HKMetricPrefix.Milli), doubleValue: (foodItem.calcium as NSString).doubleValue)
            let calcium = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCalcium), quantity: calciumUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let carborhydrateUnit = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: (foodItem.carbohydrate as NSString).doubleValue)
            let carborhydrate = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCarbohydrates), quantity: carborhydrateUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let cholesterolUnit = HKQuantity(unit: HKUnit.gramUnitWithMetricPrefix(HKMetricPrefix.Milli), doubleValue: (foodItem.cholesterol as NSString).doubleValue)
            let cholesterol = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCholesterol), quantity: cholesterolUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let energyUnit = HKQuantity(unit: HKUnit.kilocalorieUnit(), doubleValue:(foodItem.energy as NSString).doubleValue)
            let calories = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed), quantity: energyUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let fatUnit = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: (foodItem.fatTotal as NSString).doubleValue)
            let fat = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryFatTotal), quantity: fatUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let proteinUnit = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: (foodItem.protein as NSString).doubleValue)
            let protein = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryProtein), quantity: proteinUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let sugarUnit = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: (foodItem.sugar as NSString).doubleValue)
            let sugar = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySugar), quantity: sugarUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let vitaminCUnit = HKQuantity(unit: HKUnit.gramUnitWithMetricPrefix(HKMetricPrefix.Milli), doubleValue: (foodItem.vitaminC as NSString).doubleValue)
            let vitaminC = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryVitaminC), quantity: vitaminCUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let foodDataSet = NSSet(array: [calories, calcium, carborhydrate, cholesterol, fat, protein, sugar, vitaminC]) as Set
            
            let foodCorrelation = HKCorrelation(type: HKCorrelationType.correlationTypeForIdentifier(HKCorrelationTypeIdentifierFood), startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, objects: foodDataSet, metadata: foodMetaData)
            
            //store to health kit
            var store:HealthStoreConstant = HealthStoreConstant()
            store.healthStore?.saveObject(foodCorrelation, withCompletion: { (success, error) -> Void in
                if success {
                    print("Saved successfully")
                }
                else {
                    print("Error Occured: \(error)")
                }
            })
            
        }
    }
}
