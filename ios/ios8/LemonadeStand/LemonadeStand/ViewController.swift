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
    var tasteLabel: UILabel!
    
    // Weather
    var weatherEffectOnCustomers = 0
    var weatherTemperature = 72
    var weatherCurrentIcon = "IconMild"
    let kweatherSunnyIcon = "IconSunny"
    let kweatherColdIcon = "IconCold"
    let kweatherMildIcon = "IconMild"
    
    // Calendar
    var day = 0
    
    var taste = ""
    
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
    let kMarginForYStatusBar: CGFloat = 1.0/8.0
    let kMarginForIcons: CGFloat = 1.0/15.0
    
    // Constants for Views
    let kTwelfth: CGFloat = 1.0/12.0
    let kHalf: CGFloat = 1.0/2.0
    let kThird: CGFloat = 1.0/3.0
    let kFourth: CGFloat = 1.0/4.0
    let kSixth: CGFloat = 1.0/6.0
    let kNinths: CGFloat = 1.0/9.0
    let kTenths: CGFloat = 1.0/10.0
    let kThirteenHundreds: CGFloat = 13.0/100.0
    let kTwentyFifths: CGFloat = 1.0/25.0
    
    
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
        setupFifthContainer()
        setupSixthContainer()
        setupSeventhContainer()
        setupEighthContainer()
        setupNinthContainer()
        setupTenthContainer()
        
        
        getLabelsContainer()
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
        setAllLabels()
    }
    
    @IBAction func removeLemonsButtonPressed(sender: UIButton) {
        purchases.setPurchaseLemons(-1)
        setAllLabels()
    }
    
    @IBAction func addIceCubesButtonPressed(sender: UIButton) {
        purchases.setPurchaseIceCubes(1)
        setAllLabels()
    }
    
    @IBAction func removeIceCubesButtonPressed(sender: UIButton) {
        purchases.setPurchaseIceCubes(-1)
        setAllLabels()
    }
    
    @IBAction func mixAddLemonButtonPressed(sender: UIButton) {
        mix.setCurrentLemons(purchases.getAllLemons())
        mix.setMixLemons(1)
        setAllLabels()
    }
    
    @IBAction func mixRemoveLemonButtonPressed(sender: UIButton) {
        mix.setCurrentLemons(purchases.getAllLemons())
        mix.setMixLemons(-1)
        setAllLabels()
    }
    
    @IBAction func mixAddIceCubeButtonPressed(sender: UIButton) {
        mix.setCurrentIceCubes(purchases.getAllIceCubes())
        mix.setMixIceCubes(1)
        setAllLabels()
    }
    
    @IBAction func mixRemoveIceCubeButtonPressed(sender: UIButton) {
        mix.setCurrentIceCubes(purchases.getAllIceCubes())
        mix.setMixIceCubes(-1)
        setAllLabels()
    }
    
    @IBAction func startDayButtonPressed(sender: UIButton) {
        startToday()
        setAllLabels()
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
        
        tasteLabel.hidden = false
        
        if lemons == 0 && iceCubes == 0 {
            tasteLabel.hidden = true
            return 2
        } else if lemons > iceCubes {
            taste = "Acidic"
            return 1
        } else if lemons == iceCubes {
            taste = "Neutral"
            return 0
        } else {
            taste = "Watery"
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
        
        self.firstContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.width, height: self.view.bounds.height * kTwelfth * 1.5))
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
        
        self.sixthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height + fourthContainer.frame.height + fifthContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kTwelfth * kHalf))
        self.sixthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(sixthContainer)
        
        self.seventhContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height + fourthContainer.frame.height + fifthContainer.frame.height + sixthContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kTwelfth * 1.5))
        self.seventhContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(seventhContainer)
        
        self.eighthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height + fourthContainer.frame.height + fifthContainer.frame.height + sixthContainer.frame.height + seventhContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kTwelfth))
        self.eighthContainer.backgroundColor = UIColor.grayColor()
        self.view.addSubview(eighthContainer)
        
        self.ninthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height + fourthContainer.frame.height + fifthContainer.frame.height + sixthContainer.frame.height + seventhContainer.frame.height + eighthContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kTwelfth * kHalf))
        self.ninthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(ninthContainer)
        
        self.tenthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height + fourthContainer.frame.height + fifthContainer.frame.height + sixthContainer.frame.height + seventhContainer.frame.height + eighthContainer.frame.height + ninthContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kTwelfth * 1.75))
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
        lemonadeStandTopImage.frame = CGRect(x: firstContainer.frame.width * kNinths * 1.5, y: firstContainer.frame.height * kNinths * 4.0, width: firstContainer.frame.width * kNinths * 6.0, height: firstContainer.frame.height * kHalf)
        self.view.addSubview(lemonadeStandTopImage)
        
        let settingsImage = UIImage(named: "IconSettings")
        let settingsButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        settingsButton.frame = CGRect(x: firstContainer.frame.width * (kTenths * 9.0), y: firstContainer.frame.height * kNinths * 4.0, width: firstContainer.frame.width * (kTwentyFifths * 2), height: firstContainer.frame.height * kHalf)
        settingsButton.setImage(settingsImage, forState: .Normal)
        settingsButton.addTarget(self, action: "settingsButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(settingsButton)
    }
    
    func settingsButtonPressed() {
        
    }
    
    func setupSecondContainer() {
        let statusBar = UIImageView()
        statusBar.image = UIImage(named: "HUDBackground")
        statusBar.frame = CGRect(x: secondContainer.frame.origin.x, y: secondContainer.frame.origin.y, width: secondContainer.frame.width, height: secondContainer.frame.height)
        self.view.addSubview(statusBar)
        
        let dayIcon = UIImageView()
        dayIcon.image = UIImage(named: "IconCalendar")
        dayIcon.frame = CGRect(x: secondContainer.frame.origin.x + (kTwentyFifths * secondContainer.frame.width) * 1.5, y: secondContainer.frame.origin.y + (kTwentyFifths * secondContainer.frame.height) * 2.0 , width: secondContainer.frame.width * (kTwentyFifths * 3.0), height: secondContainer.frame.height * (kNinths * 5.0))
        self.view.addSubview(dayIcon)
 
        let weatherIcon = UIImageView()
        weatherIcon.image = UIImage(named: getCurrentWeatherIcon())
        weatherIcon.frame = CGRect(x: dayIcon.frame.maxX + (kTwentyFifths * secondContainer.frame.width) * 2.0, y: secondContainer.frame.origin.y + (kTwentyFifths * secondContainer.frame.height) * 2.0, width: secondContainer.frame.width * (kTwentyFifths * 3.0), height: secondContainer.frame.height * (kNinths * 5.0))
        self.view.addSubview(weatherIcon)
        
        let moneyIcon = UIImageView()
        moneyIcon.image = UIImage(named: "IconMoney")
        moneyIcon.frame = CGRect(x: weatherIcon.frame.maxX + (kTwentyFifths * secondContainer.frame.width) * 2.0, y: secondContainer.frame.origin.y + (kTwentyFifths * secondContainer.frame.height) * 2.0 , width: secondContainer.frame.width * (kTwentyFifths * 3.0), height: secondContainer.frame.height * (kNinths * 5.0))
        self.view.addSubview(moneyIcon)
        
        let lemonIcon = UIImageView()
        lemonIcon.image = UIImage(named: "IconLemon")
        lemonIcon.frame = CGRect(x: moneyIcon.frame.maxX + (kTwentyFifths * secondContainer.frame.width) * 2.0, y: secondContainer.frame.origin.y + (kTwentyFifths * secondContainer.frame.height) * 2.0, width: secondContainer.frame.width * (kTwentyFifths * 3.0), height: secondContainer.frame.height * (kNinths * 5.0))
        self.view.addSubview(lemonIcon)
        
        let iceIcon = UIImageView()
        iceIcon.image = UIImage(named: "IconIceCube")
        iceIcon.frame = CGRect(x: lemonIcon.frame.maxX + (kTwentyFifths * secondContainer.frame.width), y: secondContainer.frame.origin.y + (kTwentyFifths * secondContainer.frame.height) * 2.0, width: secondContainer.frame.width * (kTwentyFifths * 3.0), height: secondContainer.frame.height * (kNinths * 5.0))
        self.view.addSubview(iceIcon)
        
        
        calendarLabel = UILabel()
        calendarLabel.frame = CGRect(x: dayIcon.frame.midX - secondContainer.frame.width/36, y: dayIcon.frame.maxY + (kTwentyFifths * secondContainer.frame.height) * 3.0, width: secondContainer.frame.width/16, height: secondContainer.frame.height * kSixth)
        calendarLabel.textColor = UIColor.yellowColor()
        calendarLabel.adjustsFontSizeToFitWidth = true
        calendarLabel.textAlignment = .Center
        calendarLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        self.view.addSubview(calendarLabel)
        
        weatherLabel = UILabel()
        weatherLabel.frame = CGRect(x: weatherIcon.frame.midX - secondContainer.frame.width/36, y: dayIcon.frame.maxY + (kTwentyFifths * secondContainer.frame.height) * 3.0, width: secondContainer.frame.width/16, height: secondContainer.frame.height * kSixth)
        weatherLabel.adjustsFontSizeToFitWidth = true
        weatherLabel.textAlignment = .Center
        weatherLabel.textColor = UIColor.yellowColor()
        weatherLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        self.view.addSubview(weatherLabel)
        
        dollarsTotalLabel = UILabel()
        dollarsTotalLabel.frame = CGRect(x: moneyIcon.frame.midX - secondContainer.frame.width/36, y: dayIcon.frame.maxY + (kTwentyFifths * secondContainer.frame.height) * 3.0, width: secondContainer.frame.width/16, height: secondContainer.frame.height * kSixth)
        dollarsTotalLabel.textColor = UIColor.yellowColor()
        dollarsTotalLabel.adjustsFontSizeToFitWidth = true
        dollarsTotalLabel.textAlignment = .Center
        dollarsTotalLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        self.view.addSubview(dollarsTotalLabel)
        
        lemonsTotalLabel = UILabel()
        lemonsTotalLabel.frame = CGRect(x: lemonIcon.frame.midX - secondContainer.frame.width/36, y: dayIcon.frame.maxY - (kTwentyFifths * secondContainer.frame.height), width: secondContainer.frame.width/16, height: secondContainer.frame.height/2)
        lemonsTotalLabel.textColor = UIColor.yellowColor()
        lemonsTotalLabel.adjustsFontSizeToFitWidth = true
        lemonsTotalLabel.textAlignment = .Center
        lemonsTotalLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        self.view.addSubview(lemonsTotalLabel)
        
        iceCubesTotalLabel = UILabel()
        iceCubesTotalLabel.frame = CGRect(x: iceIcon.frame.midX - secondContainer.frame.width/36, y: dayIcon.frame.maxY - (kTwentyFifths * secondContainer.frame.height), width: secondContainer.frame.width/16, height: secondContainer.frame.height/2)
        iceCubesTotalLabel.textColor = UIColor.yellowColor()
        iceCubesTotalLabel.adjustsFontSizeToFitWidth = true
        iceCubesTotalLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        iceCubesTotalLabel.textAlignment = .Center
        self.view.addSubview(iceCubesTotalLabel)
    }
    
    func getLabelsContainer() {
        calendarLabel.text = "\(day)"
        weatherLabel.text = "\(getWeatherTemperature())\u{00B0}"
        dollarsTotalLabel.text = "$\(inventory.getTotalDollars())"
        lemonsTotalLabel.text = "\(inventory.getTotalLemons())"
        iceCubesTotalLabel.text = "\(inventory.getTotalIceCubes())"
        lemonsAddLabel.text = "\(purchases.getPurchaseLemons())"
        iceCubesAddLabel.text = "\(purchases.getPurchaseIceCubes())"
        mixIceCubesLabel.text = "\(mix.getMixIceCubes())"
        mixLemonsLabel.text = "\(mix.getMixLemons())"
    }
    
    func setupThirdContainer() {
        
        purchaseSuppliesLabel = UILabel()
        purchaseSuppliesLabel.text = "Purchase Supplies"
        purchaseSuppliesLabel.frame = CGRect(x: thirdContainer.frame.width * kFourth, y: thirdContainer.frame.minY, width: thirdContainer.frame.width * kHalf, height: thirdContainer.frame.height)
        purchaseSuppliesLabel.font = UIFont(name: "Lobster 1.4", size: 25)
        purchaseSuppliesLabel.textAlignment = .Center
        purchaseSuppliesLabel.textColor = UIColor(red: 0.23137254900000001, green: 0.10980392160000001, blue: 0.054901960780000002, alpha: 1)
        purchaseSuppliesLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(purchaseSuppliesLabel)
    }
    
    func setupFouthContainer() {
        var backgroundBar = UIView()
        backgroundBar.backgroundColor = UIColor(red: 223/255, green: 207/255, blue: 109/255, alpha: 1)
        backgroundBar.frame = CGRect(x: fourthContainer.frame.origin.x, y: fourthContainer.frame.origin.y, width: fourthContainer.frame.width, height: fourthContainer.frame.height * kThird * 2.0)
        self.view.addSubview(backgroundBar)
        
        var infoBar = UIView()
        infoBar.backgroundColor = UIColor(red: 0.23137254900000001, green: 0.10980392160000001, blue: 0.054901960780000002, alpha: 1)
        infoBar.frame = CGRect(x: fourthContainer.frame.origin.x, y: fourthContainer.frame.origin.y + (fourthContainer.frame.height * 2.0/3.0), width: fourthContainer.frame.width, height: fourthContainer.frame.height/3.0)
        self.view.addSubview(infoBar)
        
        let lemonRemoveImage = UIImage(named: "IconMinus")
        let lemonRemoveButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        lemonRemoveButton.frame = CGRect(x: backgroundBar.frame.origin.x + backgroundBar.frame.width * kTwentyFifths * 1.5, y: backgroundBar.frame.midY - backgroundBar.frame.height * kTwentyFifths, width: backgroundBar.frame.width * kTwentyFifths * 1.5, height: backgroundBar.frame.height * kTwentyFifths * 2.0)
        lemonRemoveButton.setImage(lemonRemoveImage, forState: .Normal)
        lemonRemoveButton.addTarget(self, action: "removeLemonsButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(lemonRemoveButton)
        
        let lemon = UIImageView()
        lemon.image = UIImage(named: "IconLemonSolid")
        lemon.frame = CGRect(x: lemonRemoveButton.frame.maxX + backgroundBar.frame.width * kTwentyFifths, y: backgroundBar.frame.midY - fourthContainer.frame.height * kSixth, width: fourthContainer.frame.width * kTenths, height: fourthContainer.frame.height * kThird)
        self.view.addSubview(lemon)
        
        let lemonPlusImage = UIImage(named: "IconPlus")
        let lemonPlusButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        lemonPlusButton.frame = CGRect(x: lemon.frame.maxX + backgroundBar.frame.width * kTwentyFifths, y: backgroundBar.frame.midY - fourthContainer.frame.height * kSixth, width: backgroundBar.frame.width * kTwentyFifths * 1.5, height: fourthContainer.frame.height * kThird)
        lemonPlusButton.setImage(lemonPlusImage, forState: .Normal)
        lemonPlusButton.addTarget(self, action: "addLemonsButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(lemonPlusButton)
        
        let icePlusImage = UIImage(named: "IconPlus")
        let icePlusButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        icePlusButton.frame = CGRect(x: backgroundBar.frame.maxX - backgroundBar.frame.width * kTwentyFifths * 3, y: backgroundBar.frame.midY - fourthContainer.frame.height * kSixth, width: backgroundBar.frame.width * kTwentyFifths * 1.5, height: fourthContainer.frame.height * kThird)
        icePlusButton.setImage(icePlusImage, forState: .Normal)
        icePlusButton.addTarget(self, action: "addIceCubesButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(icePlusButton)
        
        let ice = UIImageView()
        ice.image = UIImage(named: "IconIceCubesSolid")
        ice.frame = CGRect(x: icePlusButton.frame.minX - (backgroundBar.frame.width * kTwentyFifths) - fourthContainer.frame.width * kTenths, y: backgroundBar.frame.midY - fourthContainer.frame.height * kSixth, width: fourthContainer.frame.width * kNinths, height: fourthContainer.frame.height * kThird)
        self.view.addSubview(ice)
        
        let iceRemoveImage = UIImage(named: "IconMinus")
        let iceRemoveButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        iceRemoveButton.frame = CGRect(x: ice.frame.minX - backgroundBar.frame.width * kTwentyFifths * 2.5, y: backgroundBar.frame.midY - backgroundBar.frame.height * kTwentyFifths, width: backgroundBar.frame.width * kTwentyFifths * 1.5, height: backgroundBar.frame.height * kTwentyFifths * 2.0)
        iceRemoveButton.setImage(iceRemoveImage, forState: .Normal)
        iceRemoveButton.addTarget(self, action: "removeIceCubesButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(iceRemoveButton)
        
        lemonsAddLabel = UILabel()
        lemonsAddLabel.frame = CGRect(x: lemon.frame.midX - lemon.frame.width * kFourth, y: lemon.frame.minY + lemon.frame.height * kFourth, width: lemon.frame.width * kHalf, height: lemon.frame.height * kHalf)
        lemonsAddLabel.textColor = UIColor.yellowColor()
        lemonsAddLabel.adjustsFontSizeToFitWidth = true
        lemonsAddLabel.textAlignment = .Center
        lemonsAddLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        self.view.addSubview(lemonsAddLabel)
        
        iceCubesAddLabel = UILabel()
        iceCubesAddLabel.frame = CGRect(x: ice.frame.midX - ice.frame.width * kFourth, y: ice.frame.minY + ice.frame.height * kFourth, width: ice.frame.width * kHalf, height: ice.frame.height * kHalf)
        iceCubesAddLabel.textColor = UIColor.yellowColor()
        iceCubesAddLabel.adjustsFontSizeToFitWidth = true
        iceCubesAddLabel.textAlignment = .Center
        iceCubesAddLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        self.view.addSubview(iceCubesAddLabel)
        
        let lemonsCostLabel = UILabel()
        lemonsCostLabel.text = "Lemons: $2"
        lemonsCostLabel.frame = CGRect(x: lemon.frame.midX - infoBar.frame.width * kTenths, y: infoBar.frame.midY - infoBar.frame.height * kThird, width: infoBar.frame.width * kFourth, height: infoBar.frame.height * kThird * 2.0)
        lemonsCostLabel.textColor = UIColor.yellowColor()
        lemonsCostLabel.font = UIFont(name: "Lobster 1.4", size: 16)
        self.view.addSubview(lemonsCostLabel)
        
        let iceCostLabel = UILabel()
        iceCostLabel.text = "Ice: $1"
        iceCostLabel.frame = CGRect(x: ice.frame.midX - infoBar.frame.width * kTwentyFifths * 1.5, y: infoBar.frame.midY - infoBar.frame.height * kThird, width: infoBar.frame.width * kFourth, height: infoBar.frame.height * kThird * 2.0)
        iceCostLabel.textColor = UIColor.yellowColor()
        iceCostLabel.font = UIFont(name: "Lobster 1.4", size: 16)
        self.view.addSubview(iceCostLabel)
    }
    
    func setupFifthContainer() {
        
        let mixLemonadeLabel = UILabel()
        mixLemonadeLabel.text = "Mix Lemonade"
        mixLemonadeLabel.frame = CGRect(x: fifthContainer.frame.width * kFourth, y: fifthContainer.frame.minY, width: fifthContainer.frame.width * kHalf, height: fifthContainer.frame.height)
        mixLemonadeLabel.font = UIFont(name: "Lobster 1.4", size: 23)
        mixLemonadeLabel.textAlignment = .Center
        mixLemonadeLabel.textColor = UIColor(red: 0.23137254900000001, green: 0.10980392160000001, blue: 0.054901960780000002, alpha: 1)
        mixLemonadeLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(mixLemonadeLabel)
        
    }
    
    func setupSixthContainer() {
       let mixMessage = UILabel()
        mixMessage.frame = CGRect(x: self.view.frame.width * kTwentyFifths * 1.5, y: sixthContainer.frame.minY, width: sixthContainer.frame.width * 11 * kTwelfth, height: sixthContainer.frame.height * kHalf)
        mixMessage.textColor = UIColor(red: 0.23137254900000001, green: 0.10980392160000001, blue: 0.054901960780000002, alpha: 1)
        mixMessage.adjustsFontSizeToFitWidth = true
        mixMessage.text = "Mix your lemons and ice"
        mixMessage.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        mixMessage.textAlignment = .Center
        self.view.addSubview(mixMessage)
        
    }
    
    func setupSeventhContainer() {
        
        var backgroundBar = UIView()
        backgroundBar.backgroundColor = UIColor(red: 223/255, green: 207/255, blue: 109/255, alpha: 1)
        backgroundBar.frame = CGRect(x: seventhContainer.frame.origin.x, y: seventhContainer.frame.origin.y, width: seventhContainer.frame.width, height: seventhContainer.frame.height * kThird * 2.0)
        self.view.addSubview(backgroundBar)
        
        var infoBar = UIView()
        infoBar.backgroundColor = UIColor(red: 0.23137254900000001, green: 0.10980392160000001, blue: 0.054901960780000002, alpha: 1)
        infoBar.frame = CGRect(x: seventhContainer.frame.origin.x, y: seventhContainer.frame.origin.y + (seventhContainer.frame.height * 2.0/3.0), width: seventhContainer.frame.width, height: seventhContainer.frame.height/3.0)
        self.view.addSubview(infoBar)
        
        let lemonRemoveImage = UIImage(named: "IconMinus")
        let lemonRemoveButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        lemonRemoveButton.frame = CGRect(x: backgroundBar.frame.origin.x + backgroundBar.frame.width * kTwentyFifths * 1.5, y: backgroundBar.frame.midY - backgroundBar.frame.height * kTwentyFifths, width: backgroundBar.frame.width * kTwentyFifths * 1.5, height: backgroundBar.frame.height * kTwentyFifths * 2.0)
        lemonRemoveButton.setImage(lemonRemoveImage, forState: .Normal)
        lemonRemoveButton.addTarget(self, action: "mixRemoveLemonButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(lemonRemoveButton)
        
        let lemon = UIImageView()
        lemon.image = UIImage(named: "IconLemonSolid")
        lemon.frame = CGRect(x: lemonRemoveButton.frame.maxX + backgroundBar.frame.width * kTwentyFifths, y: backgroundBar.frame.midY - seventhContainer.frame.height * kSixth, width: seventhContainer.frame.width * kTenths, height: seventhContainer.frame.height * kThird)
        self.view.addSubview(lemon)
        
        let lemonPlusImage = UIImage(named: "IconPlus")
        let lemonPlusButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        lemonPlusButton.frame = CGRect(x: lemon.frame.maxX + backgroundBar.frame.width * kTwentyFifths, y: backgroundBar.frame.midY - seventhContainer.frame.height * kSixth, width: backgroundBar.frame.width * kTwentyFifths * 1.5, height: seventhContainer.frame.height * kThird)
        lemonPlusButton.setImage(lemonPlusImage, forState: .Normal)
        lemonPlusButton.addTarget(self, action: "mixAddLemonButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(lemonPlusButton)
        
        let icePlusImage = UIImage(named: "IconPlus")
        let icePlusButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        icePlusButton.frame = CGRect(x: backgroundBar.frame.maxX - backgroundBar.frame.width * kTwentyFifths * 3, y: backgroundBar.frame.midY - seventhContainer.frame.height * kSixth, width: backgroundBar.frame.width * kTwentyFifths * 1.5, height: seventhContainer.frame.height * kThird)
        icePlusButton.setImage(icePlusImage, forState: .Normal)
        icePlusButton.addTarget(self, action: "mixAddIceCubeButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(icePlusButton)
        
        let ice = UIImageView()
        ice.image = UIImage(named: "IconIceCubesSolid")
        ice.frame = CGRect(x: icePlusButton.frame.minX - (backgroundBar.frame.width * kTwentyFifths) - seventhContainer.frame.width * kTenths, y: backgroundBar.frame.midY - seventhContainer.frame.height * kSixth, width: seventhContainer.frame.width * kNinths, height: seventhContainer.frame.height * kThird)
        self.view.addSubview(ice)
        
        let iceRemoveImage = UIImage(named: "IconMinus")
        let iceRemoveButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        iceRemoveButton.frame = CGRect(x: ice.frame.minX - backgroundBar.frame.width * kTwentyFifths * 2.5, y: backgroundBar.frame.midY - backgroundBar.frame.height * kTwentyFifths, width: backgroundBar.frame.width * kTwentyFifths * 1.5, height: backgroundBar.frame.height * kTwentyFifths * 2.0)
        iceRemoveButton.setImage(iceRemoveImage, forState: .Normal)
        iceRemoveButton.addTarget(self, action: "mixRemoveIceCubeButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(iceRemoveButton)
        
        mixLemonsLabel = UILabel()
        mixLemonsLabel.frame = CGRect(x: lemon.frame.midX - lemon.frame.width * kFourth, y: lemon.frame.minY + lemon.frame.height * kFourth, width: lemon.frame.width * kHalf, height: lemon.frame.height * kHalf)
        mixLemonsLabel.textColor = UIColor.yellowColor()
        mixLemonsLabel.adjustsFontSizeToFitWidth = true
        mixLemonsLabel.textAlignment = .Center
        mixLemonsLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        self.view.addSubview(mixLemonsLabel)
        
        mixIceCubesLabel = UILabel()
        mixIceCubesLabel.frame = CGRect(x: ice.frame.midX - ice.frame.width * kFourth, y: ice.frame.minY + ice.frame.height * kFourth, width: ice.frame.width * kHalf, height: ice.frame.height * kHalf)
        mixIceCubesLabel.textColor = UIColor.yellowColor()
        mixIceCubesLabel.adjustsFontSizeToFitWidth = true
        mixIceCubesLabel.textAlignment = .Center
        mixIceCubesLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        self.view.addSubview(mixIceCubesLabel)
        
        tasteLabel = UILabel()
        tasteLabel.text = "\(taste) Taste"
        tasteLabel.frame = CGRect(x: infoBar.frame.midX - infoBar.frame.width * kThird, y: infoBar.frame.minY + infoBar.frame.height * kSixth, width: infoBar.frame.width * kThird * 2, height: infoBar.frame.height * 2 * kThird)
        tasteLabel.textColor = UIColor.yellowColor()
        tasteLabel.font = UIFont(name: "Lobster 1.4", size: 13)
        tasteLabel.textAlignment = .Center
        tasteLabel.adjustsFontSizeToFitWidth = true
        tasteLabel.hidden = true
        self.view.addSubview(tasteLabel)
    }
    
    func setupEighthContainer() {
        
        let sellLemonadeLabel = UILabel()
        sellLemonadeLabel.text = "Sell Lemonade"
        sellLemonadeLabel.frame = CGRect(x: eighthContainer.frame.width * kFourth, y: eighthContainer.frame.minY, width: eighthContainer.frame.width * kHalf, height: eighthContainer.frame.height)
        sellLemonadeLabel.font = UIFont(name: "Lobster 1.4", size: 23)
        sellLemonadeLabel.textAlignment = .Center
        sellLemonadeLabel.textColor = UIColor(red: 0.23137254900000001, green: 0.10980392160000001, blue: 0.054901960780000002, alpha: 1)
        sellLemonadeLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(sellLemonadeLabel)
        
    }
    
    func setupNinthContainer() {
        let mixMessage = UILabel()
        mixMessage.frame = CGRect(x: self.view.frame.width * kTwentyFifths * 1.5, y: ninthContainer.frame.minY, width: ninthContainer.frame.width * 11 * kTwelfth, height: ninthContainer.frame.height * kHalf)
        mixMessage.textColor = UIColor(red: 0.23137254900000001, green: 0.10980392160000001, blue: 0.054901960780000002, alpha: 1)
        mixMessage.adjustsFontSizeToFitWidth = true
        mixMessage.text = "Each day you'll either make or lose money."
        mixMessage.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        mixMessage.textAlignment = .Center
        self.view.addSubview(mixMessage)
    }
    
    func setupTenthContainer() {
        var backgroundBar = UIView()
        backgroundBar.backgroundColor = UIColor(red: 223/255, green: 207/255, blue: 109/255, alpha: 1)
        backgroundBar.frame = CGRect(x: tenthContainer.frame.origin.x, y: tenthContainer.frame.origin.y, width: tenthContainer.frame.width, height: tenthContainer.frame.height)
        self.view.addSubview(backgroundBar)
        
        var startDayButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        startDayButton.frame = CGRect(x: tenthContainer.frame.width * kTwentyFifths, y: tenthContainer.frame.minY + tenthContainer.frame.height * kSixth, width: tenthContainer.frame.width * 23 * kTwentyFifths, height: tenthContainer.frame.height * 4 * kSixth)
        startDayButton.backgroundColor = UIColor(red: 0.23137254900000001, green: 0.10980392160000001, blue: 0.054901960780000002, alpha: 1)
        startDayButton.layer.cornerRadius = 5
        startDayButton.layer.borderWidth = 1
        startDayButton.layer.borderColor = UIColor.blackColor().CGColor
        startDayButton.setTitle("Start Day", forState: .Normal)
        startDayButton.titleLabel!.font =  UIFont(name: "Lobster 1.4", size: 30)
        startDayButton.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        startDayButton.addTarget(self, action: "startDayButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(startDayButton)
    }
    
    
    func setAllLabels() {
        mixIceCubesLabel.text = "\(mix.getMixIceCubes())"
        mixLemonsLabel.text = "\(mix.getMixLemons())"
        iceCubesAddLabel.text = "\(purchases.getPurchaseIceCubes())"
        lemonsAddLabel.text = "\(purchases.getPurchaseLemons())"
        dollarsTotalLabel.text = "\(inventory.getTotalDollars())"
        lemonsTotalLabel.text = "\(inventory.getTotalLemons())"
        iceCubesTotalLabel.text = "\(inventory.getTotalIceCubes())"
        tasteLabel.text = "\(taste)"
    }
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
