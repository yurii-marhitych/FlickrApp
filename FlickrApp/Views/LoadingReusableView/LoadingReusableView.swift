//
//  LoadingReusableView.swift
//  FlickrApp
//
//  Created by Юра Маргітич on 30.11.2021.
//

import UIKit

class LoadingReusableView: UICollectionReusableView {
    static let identifier = "LoadingReusableView"
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
