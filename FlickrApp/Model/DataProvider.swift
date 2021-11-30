//
//  DataProvider.swift
//  FlickrApp
//
//  Created by Юра Маргітич on 30.11.2021.
//

import Foundation

class DataProvider {
    static let errorDomain = "DataProviderDomain"
    
    // MARK: - Main Methods
    func fetchPhotos(from url: URL?, completion: @escaping (Result<[Photo], Error>) -> Void) {
        Downloader.shared.download(from: url) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let apiResponse = try decoder.decode(APIResponse.self, from: data)
                    let photos = apiResponse.response.photos
                    completion(.success(photos))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
