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
    
    required init(coder aDecoder: NSCoder) {
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
        println("usdaItemDidComplete in DetailViewController")
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func eatItBarButtonPressed(sender: UIBarButtonItem) {
        
    }
    
    func usdaItemDidComplete(notification: NSNotification) {
        usdaItem = notification.object as? USDAItem
        
        if self.isViewLoaded() && self.view.window != nil {
            textView.attributedText = createAttributedString(usdaItem!)
        }
    }
    
    func createAttributedString(usdaItem: USDAItem!) -> NSAttributedString {
        var itemAttributedString = NSMutableAttributedString()
        
        var centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = NSTextAlignment.Center
        centeredParagraphStyle.lineSpacing = 10.0
        
        var titleAttributesDictionary = [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont.boldSystemFontOfSize(22.0), NSParagraphStyleAttributeName: centeredParagraphStyle]
        let titleString = NSAttributedString(string: "\(usdaItem.name!)\n", attributes: titleAttributesDictionary)
        
        itemAttributedString.appendAttributedString(titleString)
        
        var leftAlignedParagraphStyle = NSMutableParagraphStyle()
        leftAlignedParagraphStyle.alignment = NSTextAlignment.Left
        leftAlignedParagraphStyle.lineSpacing = 20.0
        
        var styleFirstWordAttributesDictionary = [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont.boldSystemFontOfSize(18.0), NSParagraphStyleAttributeName: leftAlignedParagraphStyle]
        var styleOneAttributesDictionary = [NSForegroundColorAttributeName: UIColor.darkGrayColor(), NSFontAttributeName: UIFont.systemFontOfSize(18.0), NSParagraphStyleAttributeName: leftAlignedParagraphStyle]
        var styleTwoAttributesDictionary = [NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSFontAttributeName: UIFont.systemFontOfSize(18.0), NSParagraphStyleAttributeName: leftAlignedParagraphStyle]
        
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
                println("User authorization success")
            } else {
                println("User canceled request")
            }
        })
    }
}
