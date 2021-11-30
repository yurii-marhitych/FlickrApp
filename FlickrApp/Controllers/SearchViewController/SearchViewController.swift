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
        searchController.searchBar.placeholder = "Search more photos"
        searchController.definesPresentationContext = true
    }
    
    override func loadMoreData() {
        currentPage += 1
        guard let text = apiRequest?.text else {
            return
        }
        apiRequest = APIRequest(text: text, page: currentPage)
    }
}
