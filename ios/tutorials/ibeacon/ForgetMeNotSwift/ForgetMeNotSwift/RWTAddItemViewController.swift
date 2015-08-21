//
//  RWTAddItemViewController.swift
//  ForgetMeNotSwift
//
//  Created by Portia Dean on 8/7/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class RWTAddItemViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var uuidTextField: UITextField!
    @IBOutlet weak var minorIDTextField: UITextField!
    @IBOutlet weak var majorIDTextField: UITextField!
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    
    var nameFieldValid: Bool?
    var UUIDFieldValid: Bool?
    var uuidRegex: NSRegularExpression!
    
    var itemAddedCompletion: ((newItem: RWTItem) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.saveBarButtonItem.enabled = false
        self.nameTextField.addTarget(self, action: "nameTextFieldChanged:", forControlEvents: UIControlEvents.EditingChanged)
        self.uuidTextField.addTarget(self, action: "uuidTextFieldChanged:", forControlEvents: UIControlEvents.EditingChanged)
        // Checks the UUID pattern for a valid entry
        var uuidPatternString: String = "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$"
        self.uuidRegex = NSRegularExpression(pattern: uuidPatternString, options:NSRegularExpressionOptions.CaseInsensitive, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nameTextFieldChanged(textField: UITextField) {
        if count(textField.text) > 0 {
            self.nameFieldValid = true
        } else {
            self.nameFieldValid = false
        }
        self.saveBarButtonItem.enabled = self.nameFieldValid == true && self.UUIDFieldValid == true
    }
    
    func uuidTextFieldChanged(textField: UITextField) {
        var numberOfMatches = self.uuidRegex.numberOfMatchesInString(textField.text, options: nil, range: NSMakeRange(0, count(textField.text)))
        
        if numberOfMatches > 0 {
            self.UUIDFieldValid = true
        } else {
            self.UUIDFieldValid = false
        }
        self.saveBarButtonItem.enabled = self.nameFieldValid == true && self.UUIDFieldValid == true
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        if (self.itemAddedCompletion != nil) {
            var uuid: NSUUID = NSUUID(UUIDString: uuidTextField.text)!
            var newItem = RWTItem(name: self.nameTextField.text, uuid: uuid, major: self.majorIDTextField.text.toInt(), minor: self.minorIDTextField.text.toInt())
            self.itemAddedCompletion!(newItem: newItem)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}