//
//  DetailService.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import Foundation

class DetailService: DetailRepository {
    
    func getDetail(completion: @escaping (Result<GetDetail, Error>) -> Void) {
        networkManager.executeRequest(url: "https://ptitchevreuil.github.io/test.json", method: "get", dataType: GetDetail.self, completion: completion)
    }
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    // MARK: - Private
    
    private let networkManager: NetworkManager
}
