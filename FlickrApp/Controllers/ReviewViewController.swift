//
//  ReviewViewController.swift
//  FlickrApp
//
//  Created by Юра Маргітич on 30.11.2021.
//

import UIKit

class ReviewViewController: UIViewController {
    static let storyboardID = "ReviewController"
    var photo: Photo?
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        review(photo)
    }
    
    func review(_ photo: Photo?) {
        imageView.image = photo?.image
    }
}
