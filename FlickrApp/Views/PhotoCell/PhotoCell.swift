//
//  PhotoCell.swift
//  FlickrApp
//
//  Created by Юра Маргітич on 30.11.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    static let identifier = "PhotoCell"
    var task: URLSessionTask?
    
    // MARK: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        imageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 10
        activityIndicator.startAnimating()
    }

    func configure(with photo: Photo) {
        if let image = photo.image {
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = image
            }
            return
        }
        
        let url = photo.url
        task = Downloader.shared.download(from: url) { result in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                photo.image = image
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = image
                    self?.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print((error as NSError).domain)
            }
        }
    }
}
