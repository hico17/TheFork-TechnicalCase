//
//  NetworkManager.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import Foundation

class NetworkManager {
    
    public func executeRequest<T: Decodable>(url: String, method: String, dataType: T.Type, completion: @escaping (Swift.Result<T, Error>) -> Void) {
        
        guard let url = URL(string: url) else {
            return completion(.failure(NetworkManagerError.urlCreationError))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else {
                return completion(.failure(NetworkManagerError.generic))
            }
            if let error = error {
                if (error as NSError).code == -1009 {
                    return completion(.failure(NetworkManagerError.offline))
                }
                return completion(.failure(error))
            }
            guard let data = data else {
                return completion(.failure(NetworkManagerError.missingData))
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode > 299, httpResponse.statusCode < 200 {
                    return completion(.failure(NetworkManagerError.notValidStatusCode))
                }
            }
            
            do {
                let decodedData = try self.decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    public func executeRequest(url: String, method: String, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
            
        guard let url = URL(string: url) else {
            return completion(.failure(NetworkManagerError.urlCreationError))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                if (error as NSError).code == -1009 {
                    return completion(.failure(NetworkManagerError.offline))
                }
                return completion(.failure(error))
            }
            guard let data = data else {
                return completion(.failure(NetworkManagerError.missingData))
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode > 299, httpResponse.statusCode < 200 {
                    return completion(.failure(NetworkManagerError.notValidStatusCode))
                }
            }
            completion(.success(data))
        }
        task.resume()
    }
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    // MARK: - Private
    
    private let decoder: JSONDecoder
}
