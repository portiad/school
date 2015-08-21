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
    var moneyLabel: UILabel!
    var lemonsTotalLabel: UILabel!
    var iceCubesTotalLabel: UILabel!
    var lemonsAddLabel: UILabel!
    var iceCubesAddLabel: UILabel!
    var mixLemonsLabel: UILabel!
    var mixIceCubesLabel: UILabel!
    var dayLabel: UILabel!
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
    var heightContainers: CGFloat = 0.0
    
    // Views
    var titleContainer: UIView!
    var iconStatusContainer: UIView!
    var purchaseTitleContainer: UIView!
    var purchaseInventoryContainer: UIView!
    var mixTitleContainer: UIView!
    var mixQuestionContainer: UIView!
    var mixInventoryContainer: UIView!
    var sellLemonadeTitleContainer: UIView!
    var sellLemonadeInfoContainer: UIView!
    var sellButtonContainer: UIView!
    
    var weatherIcon: UIImageView!
    
    // Constants for Views
    let kTwentyFifths: CGFloat = 1.0/25.0
    let kTwelvth: CGFloat = 1.0/12.0
    let kTenths: CGFloat = 1.0/10.0
    let kNinths: CGFloat = 1.0/9.0
    let kSixth: CGFloat = 1.0/6.0
    let kFourth: CGFloat = 1.0/4.0
    let kThird: CGFloat = 1.0/3.0
    let kHalf: CGFloat = 1.0/2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        resetGame()
        
        // Setting up views
        setupContainerViews()
        setupBackgroundContainer()
        setupTitleContainer()
        setupIconStatusContainer()
        setupPurchaseTitleContainer()
        setupPurchaseInventoryContainer()
        setupMixTitleContainer()
        setupMixQuestionContainer()
        setupMixInventoryContainer()
        setupSellLemonadeTitleContainer()
        setupSellLemonadeInfoContainer()
        setupSellButtonContainer()
        
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
        getLabelsContainer()
    }
    
    @IBAction func removeLemonsButtonPressed(sender: UIButton) {
        purchases.setPurchaseLemons(-1)
        getLabelsContainer()
    }
    
    @IBAction func addIceCubesButtonPressed(sender: UIButton) {
        purchases.setPurchaseIceCubes(1)
        getLabelsContainer()
    }
    
    @IBAction func removeIceCubesButtonPressed(sender: UIButton) {
        purchases.setPurchaseIceCubes(-1)
        getLabelsContainer()
    }
    
    @IBAction func mixAddLemonButtonPressed(sender: UIButton) {
        mix.setCurrentLemons(purchases.getAllLemons())
        mix.setMixLemons(1)
        getLemonadeRatio()
        getLabelsContainer()
    }
    
    @IBAction func mixRemoveLemonButtonPressed(sender: UIButton) {
        mix.setCurrentLemons(purchases.getAllLemons())
        mix.setMixLemons(-1)
        getLemonadeRatio()
        getLabelsContainer()
    }
    
    @IBAction func mixAddIceCubeButtonPressed(sender: UIButton) {
        mix.setCurrentIceCubes(purchases.getAllIceCubes())
        mix.setMixIceCubes(1)
        getLemonadeRatio()
        getLabelsContainer()
    }
    
    @IBAction func mixRemoveIceCubeButtonPressed(sender: UIButton) {
        mix.setCurrentIceCubes(purchases.getAllIceCubes())
        mix.setMixIceCubes(-1)
        mixIceCubesLabel.text = "\(mix.getMixIceCubes())"
        getLemonadeRatio()
        tasteLabel.text = "\(taste)"
    }
    
    @IBAction func startDayButtonPressed(sender: UIButton) {
        startToday()
        getLabelsContainer()
    }
    
    // Restarting game
    func resetGame() {
        inventory = Inventory()
        purchases = Purchases(totalDollar: inventory.getTotalDollars(), totalLemons: inventory.getTotalLemons(), totalIceCubes: inventory.getTotalIceCubes())
        mix = Mix(allLemons: purchases.getAllLemons(), allIceCubes: purchases.getAllIceCubes())
        
        setTodaysWeather()
  
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
    
    // Resetting Day
    func resetDay() {
        purchases = Purchases(totalDollar: inventory.getTotalDollars(), totalLemons: inventory.getTotalLemons(), totalIceCubes: inventory.getTotalIceCubes())
        mix = Mix(allLemons: purchases.getAllLemons(), allIceCubes: purchases.getAllIceCubes())
        day += 1
        setTodaysWeather()
        setupIconStatusContainer()
        tasteLabel.hidden = true
        
        if inventory.totalDollars + inventory.totalIceCubes + inventory.totalLemons <= 0{
            resetGame()
        }
    }
    
    func getLabelsContainer() {
        dayLabel.text = "\(day)"
        weatherLabel.text = "\(getWeatherTemperature())\u{00B0}"
        moneyLabel.text = "$\(inventory.getTotalDollars())"
        lemonsTotalLabel.text = "\(inventory.getTotalLemons())"
        iceCubesTotalLabel.text = "\(inventory.getTotalIceCubes())"
        lemonsAddLabel.text = "\(purchases.getPurchaseLemons())"
        iceCubesAddLabel.text = "\(purchases.getPurchaseIceCubes())"
        mixIceCubesLabel.text = "\(mix.getMixIceCubes())"
        mixLemonsLabel.text = "\(mix.getMixLemons())"
        tasteLabel.text = "\(taste)"
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
    
    // Views
    func setupContainerViews() {
        titleContainer = setupViewContainerFramework(1.5)
        iconStatusContainer = setupViewContainerFramework(1.5)
        purchaseTitleContainer = setupViewContainerFramework(1)
        purchaseInventoryContainer = setupViewContainerFramework(1.5)
        mixTitleContainer = setupViewContainerFramework(1)
        mixQuestionContainer = setupViewContainerFramework(kHalf)
        mixInventoryContainer = setupViewContainerFramework(1.5)
        sellLemonadeTitleContainer = setupViewContainerFramework(1)
        sellLemonadeInfoContainer = setupViewContainerFramework(kHalf)
        sellButtonContainer = setupViewContainerFramework(1.75)
    }
    
    func setupBackgroundContainer() {
        let backGroundImage = UIImageView()
        backGroundImage.image = UIImage(named: "AppBackground")
        backGroundImage.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.addSubview(backGroundImage)
    }
    
    func setupTitleContainer() {
        let lemonadeStandTopImage = UIImageView()
        lemonadeStandTopImage.image = UIImage(named: "LemonadeStandLogo")
        lemonadeStandTopImage.frame = CGRect(x: titleContainer.frame.width * kSixth, y: titleContainer.frame.height * kNinths * 4.0, width: titleContainer.frame.width * kThird * 2.0, height: titleContainer.frame.height * kHalf)
        self.view.addSubview(lemonadeStandTopImage)
        
        let settingsImage = UIImage(named: "IconSettings")
        let settingsButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        settingsButton.frame = CGRect(x: titleContainer.frame.width * kTenths * 9.0, y: titleContainer.frame.height * kNinths * 4.0, width: titleContainer.frame.width * kTwentyFifths * 2.0, height: titleContainer.frame.height * kHalf)
        settingsButton.setImage(settingsImage, forState: .Normal)
        settingsButton.addTarget(self, action: "settingsButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(settingsButton)
    }
    
    func setupIconStatusContainer() {
        let statusBar = UIImageView()
        statusBar.image = UIImage(named: "HUDBackground")
        statusBar.frame = CGRect(x: iconStatusContainer.frame.origin.x, y: iconStatusContainer.frame.origin.y, width: iconStatusContainer.frame.width, height: iconStatusContainer.frame.height)
        self.view.addSubview(statusBar)
        
        let dayIcon = setupContainerIcons("IconCalendar", iconHeight: iconStatusContainer.frame.origin.x, container:iconStatusContainer)
        let weatherIcon = setupContainerIcons(getCurrentWeatherIcon(), iconHeight: dayIcon.frame.maxX, container: iconStatusContainer)
        let moneyIcon = setupContainerIcons("IconMoney", iconHeight: weatherIcon.frame.maxX, container:iconStatusContainer)
        let lemonIcon = setupContainerIcons("IconLemon", iconHeight: moneyIcon.frame.maxX, container:iconStatusContainer)
        let iceIcon = setupContainerIcons("IconIceCube", iconHeight: lemonIcon.frame.maxX, container:iconStatusContainer)
        
        var labelContainer = CGRect(x: iconStatusContainer.frame.width * 1.0/36.0, y: iconStatusContainer.frame.height * kTwentyFifths * 3.0, width: iconStatusContainer.frame.width * 1.0/16.0, height: iconStatusContainer.frame.height * kSixth)
        
        dayLabel = setupContainerLabels(dayIcon, x: -labelContainer.origin.x, y: labelContainer.origin.y, width: labelContainer.width, height: labelContainer.height)
        weatherLabel = setupContainerLabels(weatherIcon, x: -labelContainer.origin.x, y: labelContainer.origin.y, width: labelContainer.width, height: labelContainer.height)
        moneyLabel = setupContainerLabels(moneyIcon, x: -labelContainer.origin.x, y: labelContainer.origin.y, width: labelContainer.width, height: labelContainer.height)
        lemonsTotalLabel = setupContainerLabels(lemonIcon, x: -labelContainer.origin.x, y: labelContainer.origin.y, width: labelContainer.width, height: labelContainer.height)
        iceCubesTotalLabel = setupContainerLabels(iceIcon, x: -labelContainer.origin.x, y: labelContainer.origin.y, width: labelContainer.width, height: labelContainer.height)
    }

    func setupPurchaseTitleContainer() {
        purchaseSuppliesLabel = setupSubHeaderTitles("Purchase Supplies", container: purchaseTitleContainer, size: 25.0)
    }
    
    func setupActionButtons() {
        
    }
    
    func setupPurchaseInventoryContainer() {
        var backgroundBar = setupHighlightBackgroud(purchaseInventoryContainer, multiplier: kThird * 2.0)
        var infoBar = setupInformationBar(purchaseInventoryContainer)

        let lemonRemoveImage = UIImage(named: "IconMinus")
        let lemonRemoveButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        lemonRemoveButton.frame = CGRect(x: backgroundBar.frame.minX + backgroundBar.frame.width * kTwentyFifths * 1.5, y: backgroundBar.frame.midY - backgroundBar.frame.height * kTwentyFifths, width: backgroundBar.frame.width * kTwentyFifths * 1.5, height: backgroundBar.frame.height * kTwentyFifths * 2.0)
        lemonRemoveButton.setImage(lemonRemoveImage, forState: .Normal)
        lemonRemoveButton.addTarget(self, action: "removeLemonsButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(lemonRemoveButton)
        
        let lemon = UIImageView()
        lemon.image = UIImage(named: "IconLemonSolid")
        lemon.frame = CGRect(x: lemonRemoveButton.frame.maxX + backgroundBar.frame.width * kTwentyFifths, y: backgroundBar.frame.midY - purchaseInventoryContainer.frame.height * kSixth, width: purchaseInventoryContainer.frame.width * kTenths, height: purchaseInventoryContainer.frame.height * kThird)
        self.view.addSubview(lemon)
        
        let lemonPlusImage = UIImage(named: "IconPlus")
        let lemonPlusButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        lemonPlusButton.frame = CGRect(x: lemon.frame.maxX + backgroundBar.frame.width * kTwentyFifths, y: backgroundBar.frame.midY - purchaseInventoryContainer.frame.height * kSixth, width: backgroundBar.frame.width * kTwentyFifths * 1.5, height: purchaseInventoryContainer.frame.height * kThird)
        lemonPlusButton.setImage(lemonPlusImage, forState: .Normal)
        lemonPlusButton.addTarget(self, action: "addLemonsButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(lemonPlusButton)
        
        let icePlusImage = UIImage(named: "IconPlus")
        let icePlusButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        icePlusButton.frame = CGRect(x: backgroundBar.frame.maxX - backgroundBar.frame.width * kTwentyFifths * 3, y: backgroundBar.frame.midY - purchaseInventoryContainer.frame.height * kSixth, width: backgroundBar.frame.width * kTwentyFifths * 1.5, height: purchaseInventoryContainer.frame.height * kThird)
        icePlusButton.setImage(icePlusImage, forState: .Normal)
        icePlusButton.addTarget(self, action: "addIceCubesButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(icePlusButton)
        
        let ice = UIImageView()
        ice.image = UIImage(named: "IconIceCubesSolid")
        ice.frame = CGRect(x: icePlusButton.frame.minX - (backgroundBar.frame.width * kTwentyFifths) - purchaseInventoryContainer.frame.width * kTenths, y: backgroundBar.frame.midY - purchaseInventoryContainer.frame.height * kSixth, width: purchaseInventoryContainer.frame.width * kNinths, height: purchaseInventoryContainer.frame.height * kThird)
        self.view.addSubview(ice)
        
        let iceRemoveImage = UIImage(named: "IconMinus")
        let iceRemoveButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        iceRemoveButton.frame = CGRect(x: ice.frame.minX - backgroundBar.frame.width * kTenths, y: backgroundBar.frame.midY - backgroundBar.frame.height * kTwentyFifths, width: backgroundBar.frame.width * kTwentyFifths * 1.5, height: backgroundBar.frame.height * kTwentyFifths * 2.0)
        iceRemoveButton.setImage(iceRemoveImage, forState: .Normal)
        iceRemoveButton.addTarget(self, action: "removeIceCubesButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(iceRemoveButton)
        
        lemonsAddLabel = setupContainerLabels(lemon, x: -lemon.frame.width * kFourth, y: lemon.frame.height * kFourth, width: lemon.frame.width * kHalf, height: lemon.frame.height * kHalf, yMax: false)
        iceCubesAddLabel = setupContainerLabels(ice, x: -ice.frame.width * kFourth, y: ice.frame.height * kFourth, width: ice.frame.width * kHalf, height: ice.frame.height * kHalf, yMax: false)
        
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
    
    func setupMixTitleContainer() {
        let mixLemonadeLabel = setupSubHeaderTitles("Mix Lemonade", container: mixTitleContainer, size: 23.0)
    }
    
    func setupMixQuestionContainer() {
       let mixMessage = UILabel()
        mixMessage.frame = CGRect(x: self.view.frame.width * kTwentyFifths * 1.5, y: mixQuestionContainer.frame.minY, width: mixQuestionContainer.frame.width * kTwelvth * 11, height: mixQuestionContainer.frame.height * kHalf)
        mixMessage.textColor = UIColor(red: 0.23137254900000001, green: 0.10980392160000001, blue: 0.054901960780000002, alpha: 1)
        mixMessage.adjustsFontSizeToFitWidth = true
        mixMessage.text = "Mix your lemons and ice"
        mixMessage.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        mixMessage.textAlignment = .Center
        self.view.addSubview(mixMessage)
    }
    
    func setupMixInventoryContainer() {
        var backgroundBar = setupHighlightBackgroud(mixInventoryContainer, multiplier: kThird * 2.0)
        var infoBar = setupInformationBar(mixInventoryContainer)
        
        let lemonRemoveImage = UIImage(named: "IconMinus")
        let lemonRemoveButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        lemonRemoveButton.frame = CGRect(x: backgroundBar.frame.origin.x + backgroundBar.frame.width * kTwentyFifths * 1.5, y: backgroundBar.frame.midY - backgroundBar.frame.height * kTwentyFifths, width: backgroundBar.frame.width * kTwentyFifths * 1.5, height: backgroundBar.frame.height * kTwentyFifths * 2.0)
        lemonRemoveButton.setImage(lemonRemoveImage, forState: .Normal)
        lemonRemoveButton.addTarget(self, action: "mixRemoveLemonButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(lemonRemoveButton)
        
        let lemon = UIImageView()
        lemon.image = UIImage(named: "IconLemonSolid")
        lemon.frame = CGRect(x: lemonRemoveButton.frame.maxX + backgroundBar.frame.width * kTwentyFifths, y: backgroundBar.frame.midY - mixInventoryContainer.frame.height * kSixth, width: mixInventoryContainer.frame.width * kTenths, height: mixInventoryContainer.frame.height * kThird)
        self.view.addSubview(lemon)
        
        let lemonPlusImage = UIImage(named: "IconPlus")
        let lemonPlusButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        lemonPlusButton.frame = CGRect(x: lemon.frame.maxX + backgroundBar.frame.width * kTwentyFifths, y: backgroundBar.frame.midY - mixInventoryContainer.frame.height * kSixth, width: backgroundBar.frame.width * kTwentyFifths * 1.5, height: mixInventoryContainer.frame.height * kThird)
        lemonPlusButton.setImage(lemonPlusImage, forState: .Normal)
        lemonPlusButton.addTarget(self, action: "mixAddLemonButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(lemonPlusButton)
        
        let icePlusImage = UIImage(named: "IconPlus")
        let icePlusButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        icePlusButton.frame = CGRect(x: backgroundBar.frame.maxX - backgroundBar.frame.width * kTwentyFifths * 3, y: backgroundBar.frame.midY - mixInventoryContainer.frame.height * kSixth, width: backgroundBar.frame.width * kTwentyFifths * 1.5, height: mixInventoryContainer.frame.height * kThird)
        icePlusButton.setImage(icePlusImage, forState: .Normal)
        icePlusButton.addTarget(self, action: "mixAddIceCubeButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(icePlusButton)
        
        let ice = UIImageView()
        ice.image = UIImage(named: "IconIceCubesSolid")
        ice.frame = CGRect(x: icePlusButton.frame.minX - (backgroundBar.frame.width * kTwentyFifths) - mixInventoryContainer.frame.width * kTenths, y: backgroundBar.frame.midY - mixInventoryContainer.frame.height * kSixth, width: mixInventoryContainer.frame.width * kNinths, height: mixInventoryContainer.frame.height * kThird)
        self.view.addSubview(ice)
        
        let iceRemoveImage = UIImage(named: "IconMinus")
        let iceRemoveButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        iceRemoveButton.frame = CGRect(x: ice.frame.minX - backgroundBar.frame.width * kTenths, y: backgroundBar.frame.midY - backgroundBar.frame.height * kTwentyFifths, width: backgroundBar.frame.width * kTwentyFifths * 1.5, height: backgroundBar.frame.height * kTwentyFifths * 2.0)
        iceRemoveButton.setImage(iceRemoveImage, forState: .Normal)
        iceRemoveButton.addTarget(self, action: "mixRemoveIceCubeButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(iceRemoveButton)
        
        mixLemonsLabel = setupContainerLabels(lemon, x: -lemon.frame.width * kFourth, y: lemon.frame.height * kFourth, width: lemon.frame.width * kHalf, height: lemon.frame.height * kHalf, yMax: false)
        mixIceCubesLabel = setupContainerLabels(ice, x: -ice.frame.width * kFourth, y: ice.frame.height * kFourth, width: ice.frame.width * kHalf, height: ice.frame.height * kHalf, yMax: false)
        
        tasteLabel = UILabel()
        tasteLabel.text = "\(taste) Taste"
        tasteLabel.frame = CGRect(x: infoBar.frame.midX - infoBar.frame.width * kThird, y: infoBar.frame.minY + infoBar.frame.height * kSixth, width: infoBar.frame.width * kThird * 2.0, height: infoBar.frame.height * 2 * kThird)
        tasteLabel.textColor = UIColor.yellowColor()
        tasteLabel.font = UIFont(name: "Lobster 1.4", size: 13)
        tasteLabel.textAlignment = .Center
        tasteLabel.adjustsFontSizeToFitWidth = true
        tasteLabel.hidden = true
        self.view.addSubview(tasteLabel)
    }
    
    func setupSellLemonadeTitleContainer() {
        let sellLemonadeLabel = setupSubHeaderTitles("Sell Lemonade", container: sellLemonadeTitleContainer, size: 23.0)
    }
    
    func setupSellLemonadeInfoContainer() {
        let mixMessage = UILabel()
        mixMessage.frame = CGRect(x: self.view.frame.width * kTwentyFifths * 1.5, y: sellLemonadeInfoContainer.frame.minY, width: sellLemonadeInfoContainer.frame.width * kTwelvth * 11, height: sellLemonadeInfoContainer.frame.height * kHalf)
        mixMessage.textColor = UIColor(red: 0.23137254900000001, green: 0.10980392160000001, blue: 0.054901960780000002, alpha: 1)
        mixMessage.adjustsFontSizeToFitWidth = true
        mixMessage.text = "Each day you'll either make or lose money."
        mixMessage.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        mixMessage.textAlignment = .Center
        self.view.addSubview(mixMessage)
    }
    
    func setupSellButtonContainer() {
        var backgroundBar = setupHighlightBackgroud(sellButtonContainer, multiplier: 1.0)
        
        var startDayButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        startDayButton.frame = CGRect(x: sellButtonContainer.frame.width * kTwentyFifths, y: sellButtonContainer.frame.minY + sellButtonContainer.frame.height * kSixth, width: sellButtonContainer.frame.width * kTwentyFifths * 23, height: sellButtonContainer.frame.height * kThird * 2.0)
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
    
    //Helper View Functions
    func setupViewContainerFramework(multiplier: CGFloat) -> UIView {
        var newContainer = UIView()
        newContainer.frame = CGRect(x: self.view.bounds.origin.x, y: heightContainers, width: self.view.bounds.width, height: self.view.bounds.height * kTwelvth * multiplier)
        heightContainers += newContainer.frame.height
        return newContainer
    }
    
    func setupInformationBar(container: UIView) -> UIView{
        var bar = UIView()
        bar.backgroundColor = UIColor(red: 0.23137254900000001, green: 0.10980392160000001, blue: 0.054901960780000002, alpha: 1)
        bar.frame = CGRect(x: container.frame.origin.x, y: container.frame.origin.y + container.frame.height * kThird * 2.0, width: container.frame.width, height: container.frame.height * kThird)
        self.view.addSubview(bar)
        return bar
    }
    
    func setupHighlightBackgroud(container: UIView, multiplier: CGFloat) -> UIView {
        var backgroundBar = UIView()
        backgroundBar.backgroundColor = UIColor(red: 223/255, green: 207/255, blue: 109/255, alpha: 1)
        backgroundBar.frame = CGRect(x: container.frame.origin.x, y: container.frame.origin.y, width: container.frame.width, height: container.frame.height * multiplier)
        self.view.addSubview(backgroundBar)
        return backgroundBar
    }
    
    func setupSubHeaderTitles(titleName: String, container: UIView, size: CGFloat) -> UILabel{
        var label = UILabel()
        label.text = titleName
        label.frame = CGRect(x: container.frame.width * kFourth, y: container.frame.minY, width: container.frame.width * kHalf, height: container.frame.height)
        label.font = UIFont(name: "Lobster 1.4", size: size)
        label.textAlignment = .Center
        label.textColor = UIColor(red: 0.23137254900000001, green: 0.10980392160000001, blue: 0.054901960780000002, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        self.view.addSubview(label)
        return label
    }
    
    func setupContainerIcons(name: String, iconHeight: CGFloat, container: UIView) -> UIImageView {
        var newIcon = UIImageView()
        newIcon.image = UIImage(named:  name)
        newIcon.frame = CGRect(x: iconHeight + container.frame.width * kTwentyFifths * 1.75, y: container.frame.origin.y + container.frame.height * kTwentyFifths * 2.0, width: container.frame.width * kTwentyFifths * 3.0, height: container.frame.height * kNinths * 5.0)
        self.view.addSubview(newIcon)
        return newIcon
    }
    
    func setupContainerLabels(icon:UIImageView, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, yMax: Bool = true, size: CGFloat = 15, font: String = "AppleSDGothicNeo-Bold", hidden: Bool = false) -> UILabel {
        var yFrame = icon.frame.maxY
        if yMax == false {
            yFrame = icon.frame.minY
        }
        
        var label = UILabel()
        label.frame = CGRect(x: icon.frame.midX + x, y: yFrame + y, width: width, height: height)
        label.textColor = UIColor.yellowColor()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .Center
        label.font = UIFont(name: font, size: size)
        label.hidden = hidden
        self.view.addSubview(label)
        return label
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
