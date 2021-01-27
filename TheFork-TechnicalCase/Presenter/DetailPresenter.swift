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

protocol DetailView: class {
    var isLoading: Bool { get set }
    func setTitle(_ title: String)
    func setDataSource(dataSource: [DetailPresenter.DataSource])
    func showAlert(title: String, message: String)
}

class DetailPresenter {
    
    enum DataSource {
        case images(presenter: ImagesPresenter)
        case description(presenter: DescriptionPresenter)
        case reviews(presenter: ReviewsPresenter)
        case map(presenter: MapPresenter)
    }
    
    weak var view: DetailView? {
        didSet {
            setupView()
        }
    }
    
    init(detailRepository: DetailRepository, imageRepository: ImageRepository) {
        self.detailRepository = detailRepository
        self.imageRepository = imageRepository
    }
    
    // MARK: - Private
    
    private var detailRepository: DetailRepository
    private var imageRepository: ImageRepository
    
    private func setupView() {
        view?.isLoading = true
        detailRepository.getDetail(completion: { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.view?.isLoading = false
                switch result {
                case .success(let detail):
                    self.view?.setTitle(detail.name)
                    self.view?.setDataSource(
                        dataSource: [
                            .images(presenter: ImagesPresenter(imagePresenters: detail.pics_diaporama.map{ImagePresenter(url: $0, imageRepository: self.imageRepository)})),
                            .description(presenter: DescriptionPresenter(detail: detail)),
                            .reviews(presenter: ReviewsPresenter(detail: detail)),
                            .map(presenter: MapPresenter(lat: detail.gps_lat, long: detail.gps_long))
                        ]
                    )
                case .failure(let error):
                    self.view?.showAlert(title: "Error", message: error.localizedDescription)
                }
            }
        })
    }
}
