//
//  UICollectionViewExtensions.swift
//  FlickrApp
//
//  Created by Юра Маргітич on 30.11.2021.
//

import UIKit

// MARK: - UITableViewDataSource
extension SearchResultsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? sortedRequests.count : requests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath)
        
        if let requestLabel = cell.viewWithTag(1000) as? UILabel {
            let request = isFiltering ? sortedRequests[indexPath.row] : requests[indexPath.row]
            requestLabel.text = request
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchResultsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let request = navigationItem.searchController?.searchBar.text, !request.isEmpty {
            requests.append(request)
        }
        
        navigationItem.searchController?.animationEnded(true)
    }
}
