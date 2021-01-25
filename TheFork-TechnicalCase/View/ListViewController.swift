//
//  ListViewController.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import UIKit

class ListViewController: ConstraintableViewController {
    
    var presenter: ListPresenter?
    
    override func addSubviews() {
        view.addSubview(mainButton)
    }
    
    override func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            mainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Private
    
    private lazy var mainButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(mainButtonDidPress), for: .touchUpInside)
        return button
    }()
    
    @objc private func mainButtonDidPress() {
        presenter?.mainButtonDidPress()
    }
}

// MARK: - ListView

extension ListViewController: ListView {
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setMainButtonTitle(_ title: String) {
        mainButton.setTitle(title, for: .normal)
    }
}
