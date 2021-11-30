//
//  UICollectionViewExtensions.swift
//  FlickrApp
//
//  Created by Юра Маргітич on 30.11.2021.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension GalleryViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        let photo = photos[indexPath.item]
        cell.configure(with: photo)
        
        return cell
    }
}

// MARK: - UICollectionViewDataSourcePrefetching
extension GalleryViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell else {
                return
            }
            
            let photo = photos[indexPath.item]
            cell.configure(with: photo)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension GalleryViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let reviewController = storyboard?.instantiateViewController(withIdentifier: ReviewViewController.storyboardID) as? ReviewViewController else {
            return
        }
        
        let photo = photos[indexPath.item]
        reviewController.photo = photo
        
        navigationController?.pushViewController(reviewController, animated: true)
    }
    
    // Pagination
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == photos.count - 1 {
            loadMoreData()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / photosPerRow) - padding - (padding / 2)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
}
