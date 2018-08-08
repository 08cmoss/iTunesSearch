//
//  SearchViewController.swift
//  iTunesSearch
//
//  Created by Cameron Moss on 8/6/18.
//  Copyright © 2018 Cameron Moss. All rights reserved.
//

import UIKit

protocol SearchViewProtocol: NSObjectProtocol {
    func foundSearchItems(withItems items: [Media])
}

class SearchViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var searchTableView: UITableView!
    
    // MARK: Properties
    
    var presenter: SearchPresenter!
    var searchController = UISearchController()
    var searchResults = [Media]()
    var filteredSearchResults = [Media]()
    var scopeTitles = ["Movie", "Music", "Audiobook", "TV Show", "E-book"]

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchPresenter(withViewController: self)
        searchController.isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchBar()
        setupData()
    }

    // MARK: Helper Methods
    
    func setupData() {
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    func setupSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Media"
        searchTableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = scopeTitles
        searchController.searchBar.delegate = self
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "Movie") {
        presenter.getSearchItems(withSearchText: searchText, andScope: scope)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredSearchResults.count
        }
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "iTunesCell", for: indexPath) as? iTunesTableViewCell {
            let row = filteredSearchResults[indexPath.row]
            cell.mediaGenre.text = row.genre
            cell.mediaTitle.text = row.artist
            cell.imageView?.downloadedFrom(link: row.imageURL)
            cell.layer.cornerRadius = 10
            cell.mask?.layer.cornerRadius = 10
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.black.cgColor
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if let searchText = searchBar.text,
            let scopeTitles = searchBar.scopeButtonTitles {
            filterContentForSearchText(searchText, scope: scopeTitles[selectedScope])
        }
    }
}

extension SearchViewController: SearchViewProtocol {
    func foundSearchItems(withItems items: [Media]) {
        self.filteredSearchResults = items
        DispatchQueue.main.async {
            self.searchTableView.reloadData()
        }
    }
}

