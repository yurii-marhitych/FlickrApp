//
//  SearchResultsViewController.swift
//  FlickrApp
//
//  Created by Юра Маргітич on 30.11.2021.
//

import UIKit

class SearchResultsViewController: UITableViewController {
    var requests = ["Kyiv", "Kharkiv", "Kherson", "Lviv"]
    var sortedRequests = [String]()
    
    var searchBar: UISearchBar?
    
    var isSearchBarEmpty: Bool {
        return searchBar?.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Helper Methods
    private func filterContentForSearchText(_ searchText: String) {
        sortedRequests = requests.filter { $0.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
}

// MARK: - UISearchResultsUpdating
extension SearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        filterContentForSearchText(searchText)
    }
}
