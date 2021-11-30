//
//  SearchViewController.swift
//  FlickrApp
//
//  Created by Юра Маргітич on 30.11.2021.
//

import UIKit

class SearchViewController: GalleryViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }
    
    // MARK: - Helper Methods
    private func setupSearchController() {
        guard let searchResultsController = storyboard?.instantiateViewController(withIdentifier: "SearchResultsController") as? SearchResultsViewController else {
            return
        }
        
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController
        searchResultsController.searchBar = searchController.searchBar
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search more photos"
        searchController.definesPresentationContext = true
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print(#function)
        navigationItem.searchController?.searchResultsController?.dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        navigationItem.searchController?.searchResultsController?.dismiss(animated: true, completion: nil)
    }
}
