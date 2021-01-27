//
//  ImagePresenter.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import UIKit

protocol ImageRepository {
    func getImage(url: String, completion: @escaping (Swift.Result<UIImage, Error>) -> Void)
}

protocol ImageView: class {
    var isLoading: Bool { get set }
    func setImage(_ image: UIImage)
}

class ImagePresenter {
    
    weak var view: ImageView? {
        didSet {
            setupView()
        }
    }
    
    init(url: String, imageRepository: ImageRepository) {
        self.url = url
        self.imageRepository = imageRepository
        setupView()
    }
    
    // MARK: - Private
    
    private func setupView() {
        view?.isLoading = true
        imageRepository.getImage(url: url) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.isLoading = false
                switch result {
                case .success(let image):
                    self?.view?.setImage(image)
                case .failure:
                    self?.view?.setImage(UIImage())
                }
            }
        }
    }
    
    private let url: String
    private let imageRepository: ImageRepository
}
