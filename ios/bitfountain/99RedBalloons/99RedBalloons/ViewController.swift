//
//  ViewController.swift
//  99RedBalloons
//
//  Created by Portia Dean on 3/10/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var balloonLabel: UILabel!
    @IBOutlet weak var ballonImage: UIImageView!
    
    var balloonsArray:[Balloons] = []
    var randomNumber = 0
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        balloonAdd()
        
        chooseBalloon(balloonsArray)
//        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nextButtonPressed(sender: UIBarButtonItem) {
        chooseBalloon(balloonsArray)
        
    }
    
    func balloonAdd() {
        for var i = 1; i <= 99; i++ {
            var balloon = Balloons()
          
            randomNumber = randomGenerator(4)
            switch randomNumber {
            case 0:
                balloon.image = UIImage(named: "RedBalloon1.jpg")
            case 1:
                balloon.image = UIImage(named: "RedBalloon2.jpg")
            case 2:
                balloon.image = UIImage(named: "RedBalloon3.jpg")
            default:
                balloon.image = UIImage(named: "RedBalloon4.jpg")
            }
            
            balloon.num = i
            
            self.balloonsArray += [balloon]
        }
    }
    
    func randomGenerator(num:Int) -> Int {
        return Int(arc4random_uniform(UInt32(num)))
    }
    
    func chooseBalloon(total:Array<Balloons>) {
        var randomIndex = randomGenerator(total.count)
        
        var chosenBalloon = total[randomIndex]
        
        ballonImage.image = chosenBalloon.image
        balloonLabel.text = "\(chosenBalloon.num) balloons"
        
    }

}

