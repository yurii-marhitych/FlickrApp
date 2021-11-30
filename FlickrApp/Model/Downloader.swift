//
//  Downloader.swift
//  FlickrApp
//
//  Created by Юра Маргітич on 30.11.2021.
//

import Foundation

class Downloader {
    static let errorDomain = "DownloaderDomain"
    static let shared = Downloader()
    
    // create a session with configurations
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.allowsExpensiveNetworkAccess = false
        config.requestCachePolicy = .reloadRevalidatingCacheData
        return URLSession(configuration: config)
    }()
    
    // MARK: - Main Methods
    @discardableResult
    func download(from url: URL?, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask? {
        guard let url = url else {
            completion(.failure(NSError(domain: Downloader.errorDomain, code: 1, userInfo: nil)))
            return nil
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let status = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(status) else {
                completion(.failure(NSError(domain: Downloader.errorDomain, code: 2, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: Downloader.errorDomain, code: 3, userInfo: nil)))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
        return task
    }
    
    private init() {}
}
