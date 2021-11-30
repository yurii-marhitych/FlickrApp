//
//  PhotoData.swift
//  FlickrApp
//
//  Created by Юра Маргітич on 30.11.2021.
//

import Foundation

struct PhotoData {
    let photos: [Photo]
}

// Decodable
extension PhotoData: Decodable {
    enum CodingKeys: String, CodingKey {
        case photos = "photo"
    }
}
