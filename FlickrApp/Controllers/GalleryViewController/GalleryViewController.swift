//
//  GalleryViewController.swift
//  FlickrApp
//
//  Created by Юра Маргітич on 30.11.2021.
//

import UIKit

class GalleryViewController: UICollectionViewController {
    var photosPerRow: CGFloat { return 3 }
    var padding: CGFloat { return 8 }
    var currentPage = 1
    var isLoading = false
    var loadingView: LoadingReusableView?
    
    private let dataProvider = DataProvider()
    var photos = [Photo]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    var apiRequest: APIRequest? {
        didSet {
            dataProvider.fetchPhotos(from: apiRequest?.url) { [weak self] result in
                switch result {
                case .success(let photos):
                    self?.photos = photos
                case .failure(let error):
                    print((error as NSError).domain)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        // Cell registration
        collectionView.register(UINib(nibName: PhotoCell.identifier, bundle: nil), forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.register(UINib(nibName: LoadingReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingReusableView.identifier)
    }
    
    // required to override
    func loadMoreData() {
    }
}

