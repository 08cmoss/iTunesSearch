//
//  SearchPresenter.swift
//  iTunesSearch
//
//  Created by Cameron Moss on 8/7/18.
//  Copyright © 2018 Cameron Moss. All rights reserved.
//

import Foundation

protocol SearchPresenterProtocol: NSObjectProtocol {
    func getSearchItems(withSearchText searchText: String, andScope scope: String)
}

class SearchPresenter: NSObject, SearchPresenterProtocol {
    
    // MARK: Properties
    
    var view: SearchViewProtocol!
    var filteredMedias = [Media]()
    
    // MARK: Init

    init(withViewController viewController: SearchViewProtocol) {
        self.view = viewController
    }
    
    // MARK: Helper Methods
    
    func getMediaTypeForScope(withString scopeString: String) -> String {
        switch scopeString {
        case "Movie":
            return "movie"
        case "Music":
            return "music"
        case "Audiobook":
            return "audiobook"
        case "TV Show":
            return "tvShow"
        case "E-book":
            return "ebook"
        default:
            return "all"
        }
    }
    
    func getSearchItems(withSearchText searchText: String, andScope scope: String) {
        let mediaType = getMediaTypeForScope(withString: scope)
        iTunesConnection.getMediasWithSearchTerm(searchTerm: searchText, mediaType: mediaType) { (medias) in
            self.filteredMedias = medias
            self.view.foundSearchItems(withItems: self.filteredMedias)
        }
    }
}
