//
//  ImageServiceWithCache.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import UIKit

class ImageServiceWithCache: ImageRepository {
    
    func getImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            return completion(.success(cachedImage))
        } else {
            networkManager.executeRequest(url: url, method: "GET") { result in
                switch result {
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        completion(.failure(NetworkManagerError.generic))
                        return
                    }
                    self.imageCache.setObject(image, forKey: url as NSString)
                    completion(.success(image))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        
    }
    
    // MARK: - Private
    
    private let networkManager: NetworkManager
    private let imageCache = NSCache<NSString, UIImage>()
}
