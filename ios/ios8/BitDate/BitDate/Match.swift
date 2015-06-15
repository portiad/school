//
//  Match.swift
//  BitDate
//
//  Created by Portia Dean on 6/14/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import Foundation


struct Match {
    let id: String
    let user: User
}

func fetchMatches (callBack: ([Match]) -> ()) {
    PFQuery(className: "Action")
        .whereKey("byUser", equalTo: PFUser.currentUser()!.objectId!)
        .whereKey("type", equalTo: "matched")
        .findObjectsInBackgroundWithBlock({
            objects, error in
            if let matches = objects as? [PFObject] {
                var matchedUsers = matches.map ({
                    (object: PFObject) -> (matchID: String, userID: String) in
                    (object.objectId! as String, object.objectForKey("toUser") as! String)
                })
                let userIDs = matchedUsers.map({$0.userID})
                
                PFUser.query()!
                    .whereKey("objectId", containedIn: userIDs)
                    .findObjectsInBackgroundWithBlock({
                        objects, error in
                        if let users = objects as? [PFUser] {
                            var users = reverse(users)
                            var m = Array<Match>()
                            for (index, user) in enumerate(users) {
                                m.append(Match(id: matchedUsers[index].matchID, user: pfUserToUser(user)))
                            }
                            callBack(m)
                        }
                    })
            }
        })
}