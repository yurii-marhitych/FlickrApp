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
    
    private let dataProvider = DataProvider()
    var photos = [Photo]()
    
    var apiRequest: APIRequest? {
        didSet {
            dataProvider.fetchPhotos(from: apiRequest?.url) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let newPhotos):
                    let indexPaths = (self.photos.count..<self.photos.count + newPhotos.count).map { IndexPath(item: $0, section: 0) }
                
                    if self.currentPage == 1 {
                        self.photos = newPhotos
                    } else {
                        self.photos += newPhotos
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadItems(at: indexPaths)
                    }
                case .failure(let error):
                    print((error as NSError).domain)
                }
            }
        }
    }
    
    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.prefetchDataSource = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        // Cell registration
        collectionView.register(UINib(nibName: PhotoCell.identifier, bundle: nil), forCellWithReuseIdentifier: PhotoCell.identifier)
    }
    
    // required to override
    func loadMoreData() {
    }
}

