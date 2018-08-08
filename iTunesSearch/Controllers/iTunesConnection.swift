//
//  iTunesConnection.swift
//  iTunesSearch
//
//  Created by Cameron Moss on 8/6/18.
//  Copyright © 2018 Cameron Moss. All rights reserved.
//

import UIKit

class iTunesConnection {
    
    static let baseURL = "https://itunes.apple.com"
    
    var medias: [Media] = []
    
    static func getMediasWithSearchTerm(searchTerm: String, mediaType: String, completion: @escaping (_ medias: [Media]) -> Void) {
        
        let escapedSearchTerm = searchTerm.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        var mediaSearchURLString = baseURL + "/search"
        
        mediaSearchURLString = mediaSearchURLString + "?" + "term=" + escapedSearchTerm! + "&" + "media=\(mediaType)"
        
        if let url = URL(string: mediaSearchURLString) {
            NetworkController.dataAtURL(url: url, completion: { (data) -> Void in
                
                if let data = data,
                    let jsonAnyObject = try? JSONSerialization.jsonObject(with: data, options: []),
                    let jsonDictionary = jsonAnyObject as? [String: AnyObject],
                    let resultsArray = jsonDictionary["results"] as? [[String: AnyObject]] {
                    
                    var medias = [Media]()
                    for resultDictionary in resultsArray {
                        
                        if let media = Media(jsonDictionary: resultDictionary) {
                            medias.append(media)
                        }
                    }
                    
                    completion(medias)
                    
                } else {
                    completion([])
                }
            })
        } else {
            completion([])
        }
    }
}
