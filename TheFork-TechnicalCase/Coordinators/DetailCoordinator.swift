//
//  DetailCoordinator.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import UIKit

protocol DetailCoordinatorDelegate: class {
    func detailCoordinatorDidPressBack(_ detailCoordinator: DetailCoordinator)
}

class DetailCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var delegate: DetailCoordinatorDelegate?
    
    func start() {
        let detailViewController = DetailViewController()
        let detailPresenter = DetailPresenter(detailRepository: detailRepository, imageRepository: imageRepository)
        detailPresenter.view = detailViewController
        detailPresenter.delegate = self
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

// MARK: - DetailPresenterDelegate

extension DetailCoordinator: DetailPresenterDelegate {
    
    func detailPresenterDidPressBackButton(_ detailPresenter: DetailPresenter) {
        navigationController.popViewController(animated: true)
        delegate?.detailCoordinatorDidPressBack(self)
    }
}
