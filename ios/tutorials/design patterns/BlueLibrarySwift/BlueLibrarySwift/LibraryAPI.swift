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
    
    //Create a class variable as a computed type property. The class variable, like class methods in Objective-C, is something you can call without having to instantiate the class LibraryAPI For more information about type properties please refer to Apple’s Swift documentation on properties
    //https://github.com/hpique/SwiftSingleton
    
    class var sharedInstance: LibraryAPI {
        //Nested within the class variable is a struct called Singleton.
        struct Singleton {
            //Singleton wraps a static constant variable named instance. Declaring a property as static means this property only exists once. Also note that static properties in Swift are implicitly lazy, which means that Instance is not created until it’s needed. Also note that since this is a constant property, once this instance is created, it’s not going to create it a second time. This is the essence of the Singleton design pattern. The initializer is never called again once it has been instantiated.
            static let instance = LibraryAPI()
        }
        //Returns the computed type property.
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"downloadImage:", name: "BLDownloadImageNotification", object: nil)
    }
    
    // However, before you implement downloadImage() you must remember to unsubscribe from this notification when your class is deallocated. If you do not properly unsubscribe from a notification your class registered for, a notification might be sent to a deallocated instance. This can result in application crashes.
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
    
    func saveAlbums() {
        persistencyManager.saveAlbums()
    }
    
    func downloadImage(notification: NSNotification) {
        // downloadImage is executed via notifications and so the method receives the notification object as a parameter. The UIImageView and image URL are retrieved from the notification.
        let userInfo = notification.userInfo as! [String: AnyObject]
        var imageView = userInfo["imageView"] as! UIImageView?
        let coverUrl = userInfo["coverUrl"] as! String
        
        // Retrieve the image from the PersistencyManager if it’s been downloaded previously.
        if let imageViewUnWrapped = imageView {
            imageViewUnWrapped.image = persistencyManager.getImage(coverUrl.lastPathComponent)
            if imageViewUnWrapped.image == nil {
                //If the image hasn’t already been downloaded, then retrieve it using HTTPClient.
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                    let downloadedImage = self.httpClient.downloadImage(coverUrl as String)
                    //When the download is complete, display the image in the image view and use the PersistencyManager to save it locally.
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        imageViewUnWrapped.image = downloadedImage
                        self.persistencyManager.saveImage(downloadedImage, filename: coverUrl.lastPathComponent)
                    })
                })
            }
        }
    }
    
}
