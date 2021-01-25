//
//  DetailCoordinator.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import UIKit

struct DetailCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    func start() {
        let detailViewController = DetailViewController()
        let detailPresenter = DetailPresenter(detailView: detailViewController, detailRepository: detailRepository)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    init(navigationController: UINavigationController, detailRepository: DetailRepository) {
        self.navigationController = navigationController
        self.detailRepository = detailRepository
    }
    
    // MARK: - Private
    
    private let detailRepository: DetailRepository
}
