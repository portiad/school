//
//  CardsViewController.swift
//  BitDate
//
//  Created by Portia Dean on 6/6/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, SwipeViewDelegate {
    
    struct Card {
        let cardView: CardView
        let swipeView: SwipeView
        let user: User
    }
    
    let frontCardTopMargin: CGFloat = 0.0
    let backCardTopMargin: CGFloat = 10.0
    
    
    @IBOutlet weak var cardStackView: UIView!
    
    var backCard: Card?
    var frontCard: Card?
    
    var users: [User]?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "nav-header"))
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-back-button"), style: .Plain, target: self, action: "goToProfile:")
        navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        cardStackView.backgroundColor = UIColor.clearColor()
        
//        backCard = createCard(backCardTopMargin)
//        cardStackView.addSubview(backCard!.swipeView)
//        
//        frontCard = createCard(frontCardTopMargin)
//        cardStackView.addSubview(frontCard!.swipeView)
        
        fetchUnviewedUsers { (users) -> () in
            self.users = users
            println(self.users)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Helper functions
    private func createCardFrame(topMargin: CGFloat) -> CGRect {
        return CGRect(x: 0.0, y: frontCardTopMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
    }
    
    private func createCard(user: User) -> Card {
        let cardView = CardView()
        cardView.name = user.name
        user.getPhoto { (image) in
            cardView.image = image
        }
        
        let swipeView = SwipeView(frame: createCardFrame(0))
        swipeView.delegate = self
        swipeView.innerView = cardView
        
        return Card(cardView: cardView, swipeView: swipeView, user: user)
    }
    
    
    private func popCard() -> Card? {
        if users != nil && users?.count > 0 {
            return createCard(users!.removeLast())
        }
        return nil
    }
    
    func goToProfile(button: UIBarButtonItem) {
        pageController.goToPreviousVC()
    }
    
    // MARK: SwipeViewDelegate
    func swipedLeft() {
        println("left")
        
        if let frontCard = frontCard?.swipeView {
            frontCard.removeFromSuperview()
        }
    }
    
    func swipedRight() {
        println("right")
        
        if let frontCard = frontCard?.swipeView {
            frontCard.removeFromSuperview()
        }
    }
}
