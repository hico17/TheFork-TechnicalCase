//
//  ListCoordinator.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import UIKit

class ListCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    func start() {
        let listViewController = ListViewController()
        let listPresenter = ListPresenter()
        listPresenter.listView = listViewController
        listPresenter.delegate = self
        listViewController.presenter = listPresenter
        navigationController.pushViewController(listViewController, animated: true)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - ListPresenterDelegate

extension ListCoordinator: ListPresenterDelegate {
    
    func listPresenterMainButtonDidPress(_ listPresenter: ListPresenter) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController)
        childCoordinators.append(detailCoordinator)
        detailCoordinator.delegate = self
        detailCoordinator.start()
    }
}

// MARK: - DetailCoordinatorDelegate

extension ListCoordinator: DetailCoordinatorDelegate {
    func detailCoordinatorDidPressBack(_ detailCoordinator: DetailCoordinator) {
        childCoordinators.removeAll(where: {$0 === detailCoordinator})
    }
}
