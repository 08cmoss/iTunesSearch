//
//  Media.swift
//  iTunesSearch
//
//  Created by Cameron Moss on 8/6/18.
//  Copyright © 2018 Cameron Moss. All rights reserved.
//

import Foundation

struct Media {

    private let kArtist = "artistName"
    private let kGenre = "primaryGenreName"
    private let kImageURL = "artworkUrl60"
    
    var artist: String = ""
    var genre: String = ""
    var imageURL: String = ""
    
    init?(jsonDictionary: [String: AnyObject]) {
        
        self.artist = jsonDictionary[kArtist] as? String ?? ""
        self.genre = jsonDictionary[kGenre] as? String ?? ""
        self.imageURL = jsonDictionary[kImageURL] as? String ?? ""
    }
}
