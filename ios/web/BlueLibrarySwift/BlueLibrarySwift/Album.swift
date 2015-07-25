//
//  Album.swift
//  BlueLibrarySwift
//
//  Created by Portia Dean on 7/25/15.
//  Copyright (c) 2015 Raywenderlich. All rights reserved.
//

import UIKit

class Album: NSObject, NSCoding {
    var title: String!
    var artist: String!
    var genre: String!
    var coverUrl: String!
    var year: String!
    
    init(title: String, artist: String, genre: String, coverUrl: String, year: String) {
        self.title = title
        self.artist = artist
        self.genre = genre
        self.coverUrl = coverUrl
        self.year = year
    }
    
    required init(coder decoder: NSCoder) {
        super.init()
        self.title = decoder.decodeObjectForKey("title") as! String
        self.artist = decoder.decodeObjectForKey("artist") as! String
        self.genre = decoder.decodeObjectForKey("genre") as! String
        self.coverUrl = decoder.decodeObjectForKey("cover_url") as! String
        self.year = decoder.decodeObjectForKey("year") as! String
    }
    
    
    //Part of the NSCoding protocol, encodeWithCoder will be called when you ask for an Album instance to be archived. Conversely, the init(coder:) initializer will be used to reconstruct or unarchive from a saved instance. It’s simple, yet powerful.
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(artist, forKey: "artist")
        aCoder.encodeObject(genre, forKey: "genre")
        aCoder.encodeObject(coverUrl, forKey: "cover_url")
        aCoder.encodeObject(year, forKey: "year")
    }
    
    override var description: String {
        return "title: \(title)" + "artist: \(artist)" + "genre: \(genre)" + "coverURL: \(coverUrl)" + "year: \(year)"
    }
    
    
}
