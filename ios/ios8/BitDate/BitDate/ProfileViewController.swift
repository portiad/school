//
//  ProfileViewController.swift
//  BitDate
//
//  Created by Portia Dean on 6/9/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // create the bar button items at the top of the screen
        navigationItem.titleView = UIImageView(image: UIImage(named: "profile-header"))
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-back-button"), style: .Plain, target: self, action: "goToCards:")
        navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameLabel.text = currentUser()?.name
        currentUser()?.getPhoto({ (image) in
            self.imageView.layer.masksToBounds = true
            self.imageView.contentMode = .ScaleAspectFill
            self.imageView.image = image
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToCards(button: UIBarButtonItem) {
        
        pageController.goToNextVC()
        
    }

}
