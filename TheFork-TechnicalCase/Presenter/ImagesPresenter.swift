//
//  ImagesPresenter.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 26/01/21.
//

import UIKit

protocol ImagesView: class {
    func setImagesButton(_ title: String)
}

class ImagesPresenter {
    
    weak var view: ImagesView? {
        didSet {
            setupView()
        }
    }
    
    let imagePresenters: [ImagePresenter]
    
    init(imagePresenters: [ImagePresenter]) {
        self.imagePresenters = imagePresenters
        setupView()
    }
    
    // MARK: - Private
    
    private func setupView() {
        view?.setImagesButton("See all \(imagePresenters.count) photos >")
    }
}
