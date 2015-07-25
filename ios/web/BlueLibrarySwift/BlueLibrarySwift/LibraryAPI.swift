//
//  LibraryAPI.swift
//  BlueLibrarySwift
//
//  Created by Portia Dean on 7/25/15.
//  Copyright (c) 2015 Raywenderlich. All rights reserved.
//

/* Facade: LibraryAPI will be exposed to other code, but will hide the HTTPClient and PersistencyManager complexity from the rest of the app.
*/

import UIKit

class LibraryAPI: NSObject {
    
    class var sharedInstance: LibraryAPI {
        struct Singleton {
            static let instance = LibraryAPI()
        }
        return Singleton.instance
    }
    private let persistencyManager: PersistencyManager
    private let httpClient: HTTPClient
    private let isOnline: Bool
    
    override init() {
        persistencyManager = PersistencyManager()
        httpClient = HTTPClient()
        isOnline = false
        
        super.init()
    }
    
    func getAlbums() -> [Album] {
        return persistencyManager.getAlbums()
    }
    
    /*
    Take a look at addAlbum(_:index:). The class first updates the data locally, and then if there’s an internet connection, it updates the remote server. This is the real strength of the Facade; when some class outside of your system adds a new album, it doesn’t know — and doesn’t need to know — of the complexity that lies underneath.
    */
    
    func addAlbum(album: Album, index: Int) {
        persistencyManager.addAlbum(album, index: index)
        if isOnline {
            httpClient.postRequest("/api/addAlbum", body: album.description)
        }
    }
    
    func deleteAlbum(index: Int) {
        persistencyManager.deleteAlbumAtIndex(index)
        if isOnline {
            httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
        }
    }
    
}
