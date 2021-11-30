//
//  APIResponse.swift
//  FlickrApp
//
//  Created by Юра Маргітич on 30.11.2021.
//

import Foundation

struct APIResponse {
    let response: PhotoData
}

// Decodable
extension APIResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case response = "photos"
    }
}
