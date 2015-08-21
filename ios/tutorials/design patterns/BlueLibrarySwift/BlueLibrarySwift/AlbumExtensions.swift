//
//  AlbumExtensions.swift
//  BlueLibrarySwift
//
//  Created by Portia Dean on 7/25/15.
//  Copyright (c) 2015 Raywenderlich. All rights reserved.
//

// Classes can of course override a superclass’s method, but with extensions you can’t. Methods or properties in an extension cannot have the same name as methods or properties in the original class.

import Foundation

extension Album {
    /*
    Notice there’s a ae_ at the beginning of the method name, as an abbreviation of the name of the extension: AlbumExtension. Conventions like this will help prevent collisions with methods (including possible private methods you might not know about) in the original implementation.
    */
    
    func ae_tableRepresentation() -> (titles:[String], values:[String]) {
        return (["Artist", "Album", "Genre", "Year"], [artist, title, genre, year])
    }
    
}