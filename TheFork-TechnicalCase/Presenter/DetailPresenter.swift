//
//  DetailPresenter.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import Foundation

protocol DetailRepository {
    func getDetail(completion: @escaping (Swift.Result<GetDetail, Error>) -> Void)
}

protocol DetailView {
    var isLoading: Bool { get set }
    func showAlert(title: String, message: String)
}

class DetailPresenter {
    
    init(detailView: DetailView, detailRepository: DetailRepository) {
        self.detailView = detailView
        self.detailRepository = detailRepository
        setupView()
    }
    
    // MARK: - Private
    
    private var detailView: DetailView
    private var detailRepository: DetailRepository
    
    private func setupView() {
        detailView.isLoading = true
        detailRepository.getDetail(completion: { [weak self] result in
            self?.detailView.isLoading = false
            switch result {
            case .success(let detail):
                break // todo
            case .failure(let error):
                self?.detailView.showAlert(title: "Error", message: error.localizedDescription)
            }
        })
    }
}
