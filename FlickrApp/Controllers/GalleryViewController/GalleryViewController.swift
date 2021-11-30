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
    
    private let dataProvider = DataProvider()
    var photos = [Photo]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: PhotoCell.identifier, bundle: nil), forCellWithReuseIdentifier: PhotoCell.identifier)
        
        let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=9e8b4769cbd9dd111adbbf2bc3ff46cc&text=Car&radius=1&per_page=20&page=1&format=json&nojsoncallback=1")
        dataProvider.fetchPhotos(from: url) { [weak self] result in
            switch result {
            case .success(let photos):
                self?.photos = photos
            case .failure(let error):
                print((error as NSError).domain)
            }
        }
    }
}

