//
//  SearchViewController.swift
//  FlickrApp
//
//  Created by Юра Маргітич on 30.11.2021.
//

import UIKit

class SearchViewController: GalleryViewController {
    
    // MARK: - Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }
    
    // MARK: - Helper Methods
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search more photos"
        searchController.searchBar.delegate = self
    }
    
    // For loading more data when user scroll to the end of page
    override func loadMoreData() {
        currentPage += 1
        guard let text = apiRequest?.text else {
            return
        }
        apiRequest = APIRequest(text: text, page: currentPage)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.searchController?.isActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        navigationItem.searchController?.isActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        currentPage = 1
        apiRequest = APIRequest(text: text, page: currentPage)
    }
}
