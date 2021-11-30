//
//  Photo.swift
//  FlickrApp
//
//  Created by Юра Маргітич on 30.11.2021.
//

import UIKit

final class Photo {
    private let id: String
    private let secretID: String
    private let serverID: String
    var image: UIImage?
    
    var url: URL? {
        URL(string: "https://live.staticflickr.com/\(serverID)/\(id)_\(secretID)_m.jpg")
    }
    
    init(id: String, secretID: String, serverID: String) {
        self.id = id
        self.secretID = secretID
        self.serverID = serverID
    }
}

// Decodable
extension Photo: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case secretID = "secret"
        case serverID = "server"
    }
}
