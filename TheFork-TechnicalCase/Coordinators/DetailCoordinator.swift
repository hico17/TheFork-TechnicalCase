//
//  DetailCoordinator.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import UIKit

class DetailCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    func start() {
        let detailViewController = DetailViewController()
        let detailPresenter = DetailPresenter(detailRepository: detailRepository, imageRepository: imageRepository)
        detailPresenter.view = detailViewController
        detailViewController.presenter = detailPresenter
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private lazy var detailRepository: DetailService = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let detailRepository = DetailService(networkManager: NetworkManager(decoder: decoder))
        return detailRepository
    }()
    
    private lazy var imageRepository: ImageServiceWithCache = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let imageRepository = ImageServiceWithCache(networkManager: NetworkManager(decoder: decoder))
        return imageRepository
    }()
}
