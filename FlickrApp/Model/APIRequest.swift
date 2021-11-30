//
//  APIRequest.swift
//  FlickrApp
//
//  Created by Юра Маргітич on 30.11.2021.
//

import Foundation

struct APIRequest {
    private let base = "https://www.flickr.com/services/rest/?method=flickr.photos.search"
    private let API_KEY = ""
    
    let url: URL?
    private(set) var text = ""
    private(set) var latitude = 0.0
    private(set) var longitude = 0.0
    
    // MARK: - Initializers
    init(text: String, page: Int) {
        self.text = text
        
        let stringURL = base + "&api_key=\(API_KEY)&text=\(text)&radius=1&per_page=100&page=\(page)&format=json&nojsoncallback=1"
        url = URL(string: stringURL)
    }
    
    init(latitude: Double, longitude: Double, page: Int) {
        self.latitude = latitude
        self.longitude = longitude
        
        let stringURL = base + "&api_key=\(API_KEY)&lat=\(latitude)&lon=\(longitude)&radius=1&per_page=100&page=\(page)&format=json&nojsoncallback=1"
        url = URL(string: stringURL)
    }
}
