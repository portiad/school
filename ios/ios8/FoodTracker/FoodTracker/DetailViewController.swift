//
//  DetailViewController.swift
//  FoodTracker
//
//  Created by Portia Dean on 5/31/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

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
        
//        // calcium
//        let calciumTitleString = NSAttributedString(string: "Calcium ", attributes: styleFirstWordAttributesDictionary)
//        let calciumBodyString = NSAttributedString(string: stringConverter(usdaItem.calcium), attributes: styleOneAttributesDictionary)
//        itemAttributedString.appendAttributedString(calciumTitleString)
//        itemAttributedString.appendAttributedString(calciumBodyString)
//        
//        //carbohydrate
//        let carbohydrateTitleString = NSAttributedString(string: "Carbohydrate ", attributes: styleFirstWordAttributesDictionary)
//        let carbohydrateBodyString = NSAttributedString(string: stringConverter(usdaItem.carbohydrate), attributes: styleTwoAttributesDictionary)
//        itemAttributedString.appendAttributedString(carbohydrateTitleString)
//        itemAttributedString.appendAttributedString(carbohydrateBodyString)
//        
//        //cholesterol
//        let cholesterolTitleString = NSAttributedString(string: "Cholesterol ", attributes: styleFirstWordAttributesDictionary)
//        let cholesterolBodyString = NSAttributedString(string: stringConverter(usdaItem.cholesterol), attributes: styleOneAttributesDictionary)
//        itemAttributedString.appendAttributedString(cholesterolTitleString)
//        itemAttributedString.appendAttributedString(cholesterolBodyString)
//        
//        //energy
//        let energyTitleString = NSAttributedString(string: "Energy ", attributes: styleFirstWordAttributesDictionary)
//        let energyBodyString = NSAttributedString(string: stringConverter(usdaItem.energy), attributes: styleTwoAttributesDictionary)
//        itemAttributedString.appendAttributedString(energyTitleString)
//        itemAttributedString.appendAttributedString(energyBodyString)
//        
//        //fat
//        let fatTitleString = NSAttributedString(string: "Fat ", attributes: styleFirstWordAttributesDictionary)
//        let fatBodyString = NSAttributedString(string: stringConverter(usdaItem.fatTotal), attributes: styleOneAttributesDictionary)
//        itemAttributedString.appendAttributedString(fatTitleString)
//        itemAttributedString.appendAttributedString(fatBodyString)
//        
//        //protein
//        let proteinTitleString = NSAttributedString(string: "Protein ", attributes: styleFirstWordAttributesDictionary)
//        let proteinBodyString = NSAttributedString(string: stringConverter(usdaItem.protein), attributes: styleTwoAttributesDictionary)
//        itemAttributedString.appendAttributedString(proteinTitleString)
//        itemAttributedString.appendAttributedString(proteinBodyString)
//        
//        //sugar
//        let sugarTitleString = NSAttributedString(string: "Sugar ", attributes: styleFirstWordAttributesDictionary)
//        let sugarBodyString = NSAttributedString(string: stringConverter(usdaItem.sugar), attributes: styleOneAttributesDictionary)
//        itemAttributedString.appendAttributedString(sugarTitleString)
//        itemAttributedString.appendAttributedString(sugarBodyString)
//        
//        //vitman c
//        let vitaminCTitleString = NSAttributedString(string: "Vitamin C ", attributes: styleFirstWordAttributesDictionary)
//        let vitaminCBodyString = NSAttributedString(string: stringConverter(usdaItem.vitaminC), attributes: styleTwoAttributesDictionary)
//        itemAttributedString.appendAttributedString(vitaminCTitleString)
//        itemAttributedString.appendAttributedString(vitaminCBodyString)
        
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
}
