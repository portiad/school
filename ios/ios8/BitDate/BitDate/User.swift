//
//  User.swift
//  BitDate
//
//  Created by Portia Dean on 6/8/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import Foundation

struct User {
    let id: String
    let name: String
    private let pfUser: PFUser
    
    // receiving a photo from parse (nested functions)
    func getPhoto(callback: (UIImage) -> ()) {
        let imageFile = pfUser.objectForKey("picture") as! PFFile
        imageFile.getDataInBackgroundWithBlock({
            data, error in
            if let data = data {
                callback(UIImage(data: data)!)
            }
        })
    }
}

private func pfUserToUser(user: PFUser) -> User {
    return User(id: user.objectId!, name: user.objectForKey("firstName") as! String, pfUser: user)
}

func currentUser() -> User? {
    if let user = PFUser.currentUser() {
        return pfUserToUser(user)
    }
    return nil
}

func fetchUnviewedUsers(callback: ([User]) -> ()) {
    PFUser.query()!
    .whereKey("objectID", notEqualTo: PFUser.currentUser()!.objectId!)
    .findObjectsInBackgroundWithBlock { (objects, error) in
        if let pfUsers = objects as? [PFUser] {
            let users = map(pfUsers, {pfUserToUser($0)})
            callback(users)
        }
    }
}