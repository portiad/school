//
//  ViewController.swift
//  FoodTracker
//
//  Created by Portia Dean on 5/31/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    
    var searchController: UISearchController!
    
    let kAppID = "c9bacf36"
    let kAppKey = "58e38595d1506b0aa252547a2b1e19ec"
    
    var suggestedSearchFoods:[String] = []
    var filteredSuggestedSearchFoods:[String] = []
    var apiSearchForFoods:[(name: String, idValue: String)] = []
    var favoritedUSDAItems: [USDAItem] = []
    var filteredFavoritedUSDAItems: [USDAItem] = []
    
    var scopeButtonTitles:[String] = ["Recommended", "Search Results", "Saved"]
    
    var jsonResponse: NSDictionary!
    var dataController = DataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setting up search controller
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        
        // Setting up search bar
        self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchBar.scopeButtonTitles = self.scopeButtonTitles
        self.searchController.searchBar.delegate = self
        
        // Search controller presented in the current ViewController
        self.definesPresentationContext = true
        
        // Search foods
        self.suggestedSearchFoods = ["apple", "bagel", "banana", "beer", "bread", "carrots", "cheddar cheese", "chicken breast", "chili with beans", "chocolate chip cookie", "coffee", "cola", "corn", "egg", "graham cracker", "granola bar", "green beans", "ground beef patty", "hot dog", "ice cream", "jelly doughnut", "ketchup", "milk", "mixed nuts", "mustard", "oatmeal", "orange juice", "peanut butter", "pizza", "pork chop", "potato", "potato chips", "pretzels", "raisins", "ranch salad dressing", "red wine", "rice", "salsa", "shrimp", "spaghetti", "spaghetti sauce", "tuna", "white wine", "yellow cake"]
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "usdaItemDidComplete:", name: kUSDAItemCompleted, object: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetailVCSegue" {
            if sender != nil {
                var detailVC = segue.destinationViewController as! DetailViewController
                detailVC.usdaItem = sender as? USDAItem
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark - UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        var foodName:String
        
        let selectedScopeButtonIndex = self.searchController.searchBar.selectedScopeButtonIndex
        
        if selectedScopeButtonIndex == 0 {
            if self.searchController.active {
                foodName = filteredSuggestedSearchFoods[indexPath.row]
            } else {
                foodName = suggestedSearchFoods[indexPath.row]
            }
        } else if selectedScopeButtonIndex == 1 {
            foodName = apiSearchForFoods[indexPath.row].name
        } else {
            if self.searchController.active {
                foodName = self.filteredFavoritedUSDAItems[indexPath.row].name!
            } else {
                foodName = self.favoritedUSDAItems[indexPath.row].name!
            }
        }
        
        cell.textLabel?.text = foodName
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedScopeButtonIndex = self.searchController.searchBar.selectedScopeButtonIndex
        
        if selectedScopeButtonIndex == 0 {
            if self.searchController.active {
                return filteredSuggestedSearchFoods.count
            }
            return suggestedSearchFoods.count
        } else if selectedScopeButtonIndex == 1 {
            return self.apiSearchForFoods.count
        } else {
            if self.searchController.active {
                return self.filteredFavoritedUSDAItems.count
            } else {
                return favoritedUSDAItems.count
            }
        }
    }
    
    // Mark - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedScopeButtonIndex = self.searchController.searchBar.selectedScopeButtonIndex
        
        if selectedScopeButtonIndex == 0 {
            var searchFoodName: String
            
            if self.searchController.active {
                searchFoodName = filteredSuggestedSearchFoods[indexPath.row]
            } else {
                searchFoodName = suggestedSearchFoods[indexPath.row]
            }
            self.searchController.searchBar.selectedScopeButtonIndex = 1
            makeRequest(searchFoodName)
            
        } else if selectedScopeButtonIndex == 1 {
            self.performSegueWithIdentifier("toDetailVCSegue", sender: nil)
            let idValue = apiSearchForFoods[indexPath.row].idValue
            dataController.saveUSDAItemFromId(idValue, json: self.jsonResponse)
            
        } else if selectedScopeButtonIndex == 2 {
            if self.searchController.active {
                let usdaItem = filteredFavoritedUSDAItems[indexPath.row]
                self.performSegueWithIdentifier("toDetailVCSegue", sender: usdaItem)
            } else {
                let usdaItem = favoritedUSDAItems[indexPath.row]
                self.performSegueWithIdentifier("toDetailVCSegue", sender: usdaItem)
            }
        }
    }
    
    // Mark - UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = self.searchController.searchBar.text
        let selectedScopeButtonIndex = self.searchController.searchBar.selectedScopeButtonIndex
        
        self.filterContentForSearch(searchString, scope: selectedScopeButtonIndex)
        self.tableView.reloadData()
    }
    
    func filterContentForSearch(searchText:String, scope: Int) {
        if scope == 0 {
            self.filteredSuggestedSearchFoods = self.suggestedSearchFoods.filter({ (food: String) -> Bool in
                // iterate over each element in suggestedSearchFoods to see if the search string exists in food
                var foodMatch = food.rangeOfString(searchText)
                return foodMatch != nil
            })
        } else if scope == 2 {
            self.filteredFavoritedUSDAItems = self.favoritedUSDAItems.filter({ (item: USDAItem) -> Bool in
                // iterate over each element in suggestedSearchFoods to see if the search string exists in food
                var stringMatch = item.name!.rangeOfString(searchText)
                return stringMatch != nil
            })
        }
    }
    
    
    // Mark - SearchBarDelegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        // moves the selected option over to index 1 in the scopeButtonArray
        self.searchController.searchBar.selectedScopeButtonIndex = 1
        
        makeRequest(searchBar.text)
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if selectedScope == 2 {
            requestFavoritedUSDAItems()
        }
        
        self.tableView.reloadData()
    }
    
    // Mark - API Requests
    func makeRequest(searchString:String) {
        let url = NSURL(string: "https://api.nutritionix.com/v1_1/search/")
        var request = NSMutableURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var params = [
            "appId": kAppID,
            "appKey": kAppKey,
            "fields": ["item_name", "brand_name", "keywords", "usda_fields"],
            "limit": 50,
            "query": searchString,
            "filters": ["exists" : ["usda_fields": true]]]
        
        var error: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &error)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, err) -> Void in
//            var stringData = NSString(data: data, encoding: NSUTF8StringEncoding)
            var conversionError: NSError?
            var jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &conversionError) as? NSDictionary
            
            if conversionError != nil {
                println(conversionError?.localizedDescription)
                let errorString = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error in Parsing: \(errorString)")
            } else {
                if jsonDictionary != nil {
                    self.jsonResponse = jsonDictionary!
                    self.apiSearchForFoods = DataController.jsonAsUSDIDNameSearchResults(self.jsonResponse)
                    
                    // update on the main thread prioritizes it so that it reloads immediately
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                } else {
                    let errorString = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON \(errorString)")
                }
            }
        })
        task.resume()
        
        
            // How to make an HTTP get request
    //        let url = NSURL(string: "https://api.nutritionix.com/v1_1/search/\(searchString)?results=0%3A20&cal_min=0&cal_max=50000&fields=item_name%2Cbrand_name%2Citem_id%2Cbrand_id&appId=\(kAppID)&appKey=\(kAppKey)")
    //        // setup request
    //        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
    //            println(data)
    //            var stringData = NSString(data: data, encoding: NSUTF8StringEncoding)
    //            println(response)
    //            println(stringData)
    //        })
    //        // execute request
    //        task.resume()
   }
    
    
    // Mark - Setup Core Data
    
    func requestFavoritedUSDAItems() {
        let fetchRequest = NSFetchRequest(entityName: "USDAItem")
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        self.favoritedUSDAItems = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as! [USDAItem]
    }
    
    // Mark - NSNotification Center
    
    func usdaItemDidComplete(notification: NSNotification) {
        println("usdaItemDidComplete in ViewController")
        requestFavoritedUSDAItems()
        let selectedScopeButtonIndex = self.searchController.searchBar.selectedScopeButtonIndex
        
        if selectedScopeButtonIndex == 2 {
            self.tableView.reloadData()
        }
    }
}

