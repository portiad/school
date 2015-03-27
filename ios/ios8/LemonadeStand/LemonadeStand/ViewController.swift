//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Portia Dean on 3/15/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Classes
    var inventory: Inventory!
    var purchases: Purchases!
    var mix: Mix!
    
    // Messages
    let kmNoMoneyMessage = "You do not have enough money"
    let kmZeroLemons = "You have no more lemons"
    let kmZeroIceCubes = "You have no more ice cubes"
    let kmNegativeLemons = "Lemons can not be less than 0"
    let kmNegativeIceCubes = "Ice cubes can not be less than 0"
    
    
    // UILabels
    var dollarsTotalLabel: UILabel!
    var lemonsTotalLabel: UILabel!
    var iceCubesTotalLabel: UILabel!
    var lemonsAddLabel: UILabel!
    var iceCubesAddLabel: UILabel!
    var mixLemonsLabel: UILabel!
    var mixIceCubesLabel: UILabel!
    var calendarLabel: UILabel!
    var weatherLabel: UILabel!
    var purchaseSuppliesLabel: UILabel!
    
    // Weather
    var weatherEffectOnCustomers = 0
    var weatherTemperature = 72
    var weatherCurrentIcon = "IconMild"
    let kweatherSunnyIcon = "IconSunny"
    let kweatherColdIcon = "IconCold"
    let kweatherMildIcon = "IconMild"
    
    // Calendar
    var day = 0
    
    // Views
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    var fifthContainer: UIView!
    var sixthContainer: UIView!
    var seventhContainer: UIView!
    var eighthContainer: UIView!
    var ninthContainer: UIView!
    var tenthContainer: UIView!

    // Margin for Views
    let kMarginForYStatusBar:CGFloat = 1.0/8.0
    let kMarginForIcons: CGFloat = 1.0/15.0
    let kMarginForLabel: CGFloat = 1.0/25.0
    
    // Constants for Views
    let kTwelfth:CGFloat = 1.0/12.0
    let kHalf:CGFloat = 1.0/2.0
    let kFourth: CGFloat = 1.0/4.0
    let kThirteenHundreds: CGFloat = 13.0/100.0
    let kOneTwentyFifths: CGFloat = 1.0/25.0
    
    
    let kNumberOfInfoBars = 8
    let kNumberOfSkinnyBars = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        resetGame()
        
        // Setting up views
        setupContainerViews()
        setupBackgroundContainer()
        setupFirstContainer()
        setupSecondContainer()
        setupThirdContainer()
        setupFouthContainer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // IBAction functions
    */
    
    @IBAction func addLemonsButtonPressed(sender: UIButton) {
        purchases.setPurchaseLemons(1)
        //setAllLabels()
    }
    
    @IBAction func removeLemonsButtonPressed(sender: UIButton) {
        purchases.setPurchaseLemons(-1)
        //setAllLabels()
    }
    
    @IBAction func addIceCubesButtonPressed(sender: UIButton) {
        purchases.setPurchaseIceCubes(1)
        //setAllLabels()
    }
    
    @IBAction func removeIceCubesButtonPressed(sender: UIButton) {
        purchases.setPurchaseIceCubes(-1)
        //setAllLabels()
    }
    
    @IBAction func mixAddLemonButtonPressed(sender: UIButton) {
        mix.setCurrentLemons(purchases.getAllLemons())
        mix.setMixLemons(1)
        //setAllLabels()
    }
    
    @IBAction func mixRemoveLemonButtonPressed(sender: UIButton) {
        mix.setCurrentLemons(purchases.getAllLemons())
        mix.setMixLemons(-1)
        //setAllLabels()
    }
    
    @IBAction func mixAddIceCubeButtonPressed(sender: UIButton) {
        mix.setCurrentIceCubes(purchases.getAllIceCubes())
        mix.setMixIceCubes(1)
        //setAllLabels()
    }
    
    @IBAction func mixRemoveIceCubeButtonPressed(sender: UIButton) {
        mix.setCurrentIceCubes(purchases.getAllIceCubes())
        mix.setMixIceCubes(-1)
        //setAllLabels()
    }
    
    @IBAction func startDayButtonPressed(sender: UIButton) {
        startToday()
        //setAllLabels()
    }
    
    // Restarting game
    
    func resetGame() {
        inventory = Inventory()
        purchases = Purchases(totalDollar: inventory.getTotalDollars(), totalLemons: inventory.getTotalLemons(), totalIceCubes: inventory.getTotalIceCubes())
        mix = Mix(allLemons: purchases.getAllLemons(), allIceCubes: purchases.getAllIceCubes())
        
        setTodaysWeather()
        
        println("hey")
        println(weatherTemperature)

            
        day = 1
    }
    
    
    // Starting a new day for sales
    
    func startToday() {
        
        var totalSales = 0
        var totalCustomers = 0
        
        let mixRatio = getLemonadeRatio()
        let customers = prepareCustomer()
        
        // Iterate over your customers array and determine who will buy lemonade based on mix ratio
        
        for customer in customers {
            if customer >= 0.0 && customer <= 0.4 && mixRatio == 1 {
                totalCustomers += 1
                totalSales += 1
            } else if customer >= 0.4 && customer <= 0.6 && mixRatio == 0 {
                totalCustomers += 1
                totalSales += 1
            } else if customer >= 0.6 && customer <= 1.0 && mixRatio == -1{
                totalCustomers += 1
                totalSales += 1
            }
        }
        
        inventory.setTotalDollars(totalSales, costs: purchases.getTotalCost())
        inventory.setTotalLemons(mix.getCurrentLemons())
        inventory.setTotalIceCubes(mix.getCurrentIceCubes())
        
        resetDay()
    }
    
    // Setting weather
    
    func setTodaysWeather() {
        var random = Int(arc4random_uniform(UInt32(2)))
        
        switch random {
        case 0: // cloudy
            weatherEffectOnCustomers = -3
            weatherCurrentIcon = kweatherColdIcon
            weatherTemperature = 62
            
        case 1: // sunny
            weatherEffectOnCustomers = 4
            weatherCurrentIcon = kweatherSunnyIcon
            weatherTemperature = 82
        default: // fair
            weatherEffectOnCustomers = 0
            weatherCurrentIcon = kweatherMildIcon
            weatherTemperature = 72
        }
    }
    
    func getWeatherEffect() -> Int {
        return self.weatherEffectOnCustomers
    }
    
    func getCurrentWeatherIcon() -> String {
        return self.weatherCurrentIcon
    }
    
    func getWeatherTemperature() -> Int {
        return self.weatherTemperature
    }
    
    // Preparing 1 - 10 customers for the day with taste preference
    
    func prepareCustomer() -> Array<Float> {
        var totalCustomers = Int(arc4random_uniform(UInt32(9))) + getWeatherEffect()
        var customers: [Float] = []
        for totalCustomers; totalCustomers >= 0 ; --totalCustomers{
            var random = Float(arc4random()) /  Float(UInt32.max)
            customers.append(random)
        }
        return customers
    }
    
    // Prepare lemon to ice cube mix ratio
    
    func getLemonadeRatio() -> Int {
        var iceCubes = mix.getMixIceCubes()
        var lemons = mix.getMixLemons()
        
        if lemons == 0 && iceCubes == 0 {
            return 2
        } else if lemons > iceCubes {
            return 1
        } else if lemons == iceCubes {
            return 0
        } else {
            return -1
        }
    }
    
    // Resetting Day

    func resetDay() {
        inventory = Inventory()
        purchases = Purchases(totalDollar: inventory.getTotalDollars(), totalLemons: inventory.getTotalLemons(), totalIceCubes: inventory.getTotalIceCubes())
        mix = Mix(allLemons: purchases.getAllLemons(), allIceCubes: purchases.getAllIceCubes())
        day += 1
        setTodaysWeather()
        
        
        if inventory.totalDollars + inventory.totalIceCubes + inventory.totalLemons <= 0{
            resetGame()
        }
    }
    
    /*
    // Views
    */
    
    func setupContainerViews() {
        
        self.firstContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.width, height: self.view.bounds.height * kTwelfth))
        self.firstContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(firstContainer)
        
        self.secondContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: firstContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kTwelfth * 1.5))
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(secondContainer)
        
        self.thirdContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y:firstContainer.frame.height + secondContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kTwelfth))
        self.thirdContainer.backgroundColor = UIColor.grayColor()
        self.view.addSubview(thirdContainer)
        
        self.fourthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kTwelfth * 1.5))
        self.fourthContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(fourthContainer)
        
        self.fifthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height + fourthContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kTwelfth))
        self.fifthContainer.backgroundColor = UIColor.grayColor()
        self.view.addSubview(fifthContainer)
        
        self.sixthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height + fourthContainer.frame.height + fifthContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kTwelfth))
        self.sixthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(sixthContainer)
        
        self.seventhContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height + fourthContainer.frame.height + fifthContainer.frame.height + sixthContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kTwelfth))
        self.seventhContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(seventhContainer)
        
        self.eighthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height + fourthContainer.frame.height + fifthContainer.frame.height + sixthContainer.frame.height + seventhContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kTwelfth))
        self.eighthContainer.backgroundColor = UIColor.grayColor()
        self.view.addSubview(eighthContainer)
        
        self.ninthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height + fourthContainer.frame.height + fifthContainer.frame.height + sixthContainer.frame.height + seventhContainer.frame.height + eighthContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kTwelfth * 1.5))
        self.ninthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(ninthContainer)
        
        self.tenthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height + fourthContainer.frame.height + fifthContainer.frame.height + sixthContainer.frame.height + seventhContainer.frame.height + eighthContainer.frame.height + ninthContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kTwelfth * 1.5))
        self.tenthContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(tenthContainer)
    }
    
    func setupBackgroundContainer() {
        let backGroundImage = UIImageView()
        backGroundImage.image = UIImage(named: "AppBackground")
        backGroundImage.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.addSubview(backGroundImage)

    }
    
    func setupFirstContainer() {
        let lemonadeStandTopImage = UIImageView()
        lemonadeStandTopImage.image = UIImage(named: "LemonadeStandLogo")
        lemonadeStandTopImage.frame = CGRect(x: CGRectGetMidX(firstContainer.frame)/2, y: CGRectGetMidY(firstContainer.frame)/1.25, width: firstContainer.frame.width/2, height: firstContainer.frame.height/2)
        self.view.addSubview(lemonadeStandTopImage)
        
        let settingsImage = UIImage(named: "IconSettings")
        let settingsButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        settingsButton.frame = CGRect(x: CGRectGetMaxX(firstContainer.frame) * 0.8, y: CGRectGetMidY(firstContainer.frame)/1.25, width: firstContainer.frame.width/4, height: firstContainer.frame.height/2)
        settingsButton.setImage(settingsImage, forState: .Normal)
        settingsButton.addTarget(self, action: "settingsButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(settingsButton)
    }
    
    func settingsButtonPressed() {
        
    }
    
    func setupSecondContainer() {
        let statusBar = UIImageView()
        statusBar.image = UIImage(named: "HUDBackground")
        statusBar.frame = CGRect(x: CGRectGetMinX(secondContainer.frame), y: CGRectGetMinY(secondContainer.frame) , width: secondContainer.frame.width, height: secondContainer.frame.height)
        self.view.addSubview(statusBar)
        
        let dayIcon = UIImageView()
        dayIcon.image = UIImage(named: "IconCalendar")
        dayIcon.frame = CGRect(x: CGRectGetMinX(secondContainer.frame) + (kMarginForIcons * secondContainer.frame.width), y: CGRectGetMinY(secondContainer.frame) + (kMarginForYStatusBar * secondContainer.frame.height) , width: secondContainer.frame.width/8, height: secondContainer.frame.height/2)
        self.view.addSubview(dayIcon)
 
        let weatherIcon = UIImageView()
        weatherIcon.image = UIImage(named: getCurrentWeatherIcon())
        weatherIcon.frame = CGRect(x: CGRectGetMaxX(dayIcon.frame) + (kMarginForIcons * secondContainer.frame.width), y: CGRectGetMinY(secondContainer.frame) + (kMarginForYStatusBar * secondContainer.frame.height) , width: secondContainer.frame.width/8, height: secondContainer.frame.height/2)
        self.view.addSubview(weatherIcon)
        
        let moneyIcon = UIImageView()
        moneyIcon.image = UIImage(named: "IconMoney")
        moneyIcon.frame = CGRect(x: CGRectGetMaxX(weatherIcon.frame) + (kMarginForIcons * secondContainer.frame.width), y: CGRectGetMinY(secondContainer.frame) + (kMarginForYStatusBar * secondContainer.frame.height) , width: secondContainer.frame.width/8, height: secondContainer.frame.height/2)
        self.view.addSubview(moneyIcon)
        
        let lemonIcon = UIImageView()
        lemonIcon.image = UIImage(named: "IconLemon")
        lemonIcon.frame = CGRect(x: CGRectGetMaxX(moneyIcon.frame) + (kMarginForIcons * secondContainer.frame.width), y: CGRectGetMinY(secondContainer.frame) + (kMarginForYStatusBar * secondContainer.frame.height) , width: secondContainer.frame.width/8, height: secondContainer.frame.height/2)
        self.view.addSubview(lemonIcon)
        
        let iceIcon = UIImageView()
        iceIcon.image = UIImage(named: "IconIceCube")
        iceIcon.frame = CGRect(x: CGRectGetMaxX(lemonIcon.frame) + (kMarginForIcons * secondContainer.frame.width), y: CGRectGetMinY(secondContainer.frame) + (kMarginForYStatusBar * secondContainer.frame.height) , width: secondContainer.frame.width/8, height: secondContainer.frame.height/2)
        self.view.addSubview(iceIcon)
        
        
        calendarLabel = UILabel()
        calendarLabel.frame = CGRect(x: CGRectGetMidX(dayIcon.frame) - secondContainer.frame.width/36, y: CGRectGetMaxY(dayIcon.frame) - (kMarginForLabel * secondContainer.frame.height), width: secondContainer.frame.width/16, height: secondContainer.frame.height/2)
        calendarLabel.textColor = UIColor.yellowColor()
        calendarLabel.adjustsFontSizeToFitWidth = true
        calendarLabel.textAlignment = .Center
        calendarLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        self.view.addSubview(calendarLabel)
        
        weatherLabel = UILabel()
        weatherLabel.frame = CGRect(x: CGRectGetMidX(weatherIcon.frame) - secondContainer.frame.width/36, y: CGRectGetMaxY(dayIcon.frame) - (kMarginForLabel * secondContainer.frame.height), width: secondContainer.frame.width/16, height: secondContainer.frame.height/2)
        weatherLabel.textColor = UIColor.yellowColor()
        weatherLabel.adjustsFontSizeToFitWidth = true
        weatherLabel.textAlignment = .Center
        weatherLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        self.view.addSubview(weatherLabel)
        
        dollarsTotalLabel = UILabel()
        dollarsTotalLabel.frame = CGRect(x: CGRectGetMidX(moneyIcon.frame) - secondContainer.frame.width/36, y: CGRectGetMaxY(dayIcon.frame) - (kMarginForLabel * secondContainer.frame.height), width: secondContainer.frame.width/16, height: secondContainer.frame.height/2)
        dollarsTotalLabel.textColor = UIColor.yellowColor()
        dollarsTotalLabel.adjustsFontSizeToFitWidth = true
        dollarsTotalLabel.textAlignment = .Center
        dollarsTotalLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        self.view.addSubview(dollarsTotalLabel)
        
        lemonsTotalLabel = UILabel()
        lemonsTotalLabel.frame = CGRect(x: CGRectGetMidX(lemonIcon.frame) - secondContainer.frame.width/36, y: CGRectGetMaxY(dayIcon.frame) - (kMarginForLabel * secondContainer.frame.height), width: secondContainer.frame.width/16, height: secondContainer.frame.height/2)
        lemonsTotalLabel.textColor = UIColor.yellowColor()
        lemonsTotalLabel.adjustsFontSizeToFitWidth = true
        lemonsTotalLabel.textAlignment = .Center
        lemonsTotalLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        self.view.addSubview(lemonsTotalLabel)
        
        iceCubesTotalLabel = UILabel()
        iceCubesTotalLabel.frame = CGRect(x: CGRectGetMidX(iceIcon.frame) - secondContainer.frame.width/36, y: CGRectGetMaxY(dayIcon.frame) - (kMarginForLabel * secondContainer.frame.height), width: secondContainer.frame.width/16, height: secondContainer.frame.height/2)
        iceCubesTotalLabel.textColor = UIColor.yellowColor()
        iceCubesTotalLabel.adjustsFontSizeToFitWidth = true
        iceCubesTotalLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        iceCubesTotalLabel.textAlignment = .Center
        self.view.addSubview(iceCubesTotalLabel)
        
        getLabelsSecondContainer()
    }
    
    func getLabelsSecondContainer() {
        calendarLabel.text = "\(day)"
        weatherLabel.text = "\(getWeatherTemperature())\u{00B0}"
        dollarsTotalLabel.text = "$\(inventory.getTotalDollars())"
        lemonsTotalLabel.text = "\(inventory.getTotalLemons())"
        iceCubesTotalLabel.text = "\(inventory.getTotalIceCubes())"
    }
    
    func setupThirdContainer() {
        purchaseSuppliesLabel = UILabel()
        purchaseSuppliesLabel.text = "Purchase Supplies"
        purchaseSuppliesLabel.frame = CGRect(x: CGRectGetMidX(thirdContainer.frame)/2, y: CGRectGetMidY(thirdContainer.frame)/1.1, width: thirdContainer.frame.width/2, height: thirdContainer.frame.height/2)
        purchaseSuppliesLabel.font = UIFont(name: "Lobster 1.4", size: 30)
        purchaseSuppliesLabel.textAlignment = .Center
        purchaseSuppliesLabel.textColor = UIColor(red: 0.23137254900000001, green: 0.10980392160000001, blue: 0.054901960780000002, alpha: 1)
        purchaseSuppliesLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(purchaseSuppliesLabel)
    }
    
    func setupFouthContainer() {
        var backgroundBar = UIView()
        backgroundBar.backgroundColor = UIColor(red: 223/255, green: 207/255, blue: 109/255, alpha: 1)
        backgroundBar.frame = CGRect(x: fourthContainer.frame.origin.x, y: fourthContainer.frame.origin.y, width: fourthContainer.frame.width, height: fourthContainer.frame.height)
        self.view.addSubview(backgroundBar)
        
        var infoBar = UIView()
        infoBar.backgroundColor = UIColor(red: 0.23137254900000001, green: 0.10980392160000001, blue: 0.054901960780000002, alpha: 1)
        infoBar.frame = CGRect(x: fourthContainer.frame.origin.x, y: fourthContainer.frame.origin.y + (fourthContainer.frame.height * 2.0/3.0), width: fourthContainer.frame.width, height: fourthContainer.frame.height/3.0)
        self.view.addSubview(infoBar)
        
        var lemonRemove = UIImageView()
        lemonRemove.image = UIImage(named: "IconMinus")
        lemonRemove.frame = CGRect(x: fourthContainer.frame.origin.x + fourthContainer.frame.width * 1.0/14.0, y: fourthContainer.frame.origin.y + fourthContainer.frame.height * 1.0/3.0, width: fourthContainer.frame.width * 1.0/20.0, height: fourthContainer.frame.height * 1.0/30.0)
        self.view.addSubview(lemonRemove)
        
        var lemon = UIImageView()
        lemon.image = UIImage(named: "IconLemonSolid")
        lemon.frame = CGRect(x: fourthContainer.frame.origin.x + (fourthContainer.frame.width * 1.0/14.0) * 2.0, y: fourthContainer.frame.origin.y + fourthContainer.frame.height * 1.0/6.0, width: fourthContainer.frame.width * 1.0/10.0, height: fourthContainer.frame.height * 1.0/3.0)
        self.view.addSubview(lemon)
        
        var lemonPlus = UIImageView()
        lemonPlus.image = UIImage(named: "IconPlus")
        lemonPlus.frame = CGRect(x: fourthContainer.frame.origin.x + (fourthContainer.frame.width * 1.0/10.0) * 3, y: fourthContainer.frame.origin.y + fourthContainer.frame.height * 1.0/3.0, width: fourthContainer.frame.width * 1.0/20.0, height: fourthContainer.frame.height * 1.0/5.0)
        self.view.addSubview(lemonPlus)
        
    }
    
    
//    func setAllLabels() {
//        mixIceCubesLabel.text = "\(mix.getMixIceCubes())"
//        mixLemonsLabel.text = "\(mix.getMixLemons())"
//        iceCubesAddLabel.text = "\(purchases.getPurchaseIceCubes())"
//        lemonsAddLabel.text = "\(purchases.getPurchaseLemons())"
//        dollarTotalLabel.text = "\(inventory.getTotalDollars())"
//        lemonsTotalLabel.text = "\(inventory.getTotalLemons())"
//        iceCubeTotalLabel.text = "\(inventory.getTotalIceCubes())"
//
//    
//    func showAlertWithText(var header: String = "Warning", var message: String = "Warning", errorCode: Int = 0) {
//        
//        if errorCode == -99 {
//            header = "No money"
//            message = "Purchase fewer items"
//        }
//        else if errorCode == -98 {
//            message = "Cannot buy negative amounts"
//        }
//        else if errorCode == -97 {
//            header = "Unknown Product"
//            message = "Please contact customer support"
//        }
//        
//        
//        
//        
//        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
//        self.presentViewController(alert, animated: true, completion: nil)
//    }
}
