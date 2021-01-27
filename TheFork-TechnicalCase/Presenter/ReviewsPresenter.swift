//
//  ReviewsPresenter.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import Foundation

protocol ReviewsView: class {
    func setTheForkAverageRate(max: Int, current: Double)
    func setTheForkRateCount(_ rate: String)
    func setTripAdvisorVote(max: Int, current: Int)
    func setTripAdvisorReviewsNumber(_ rate: String)
}

class ReviewsPresenter {
    
    weak var view: ReviewsView? {
        didSet {
            setupView()
        }
    }
    
    init(detail: GetDetail) {
        self.detail = detail
    }
    
    // MARK: - Private
    
    private let detail: GetDetail
    
    private func setupView() {
        view?.setTheForkAverageRate(max: 10, current: detail.avg_rate)
        view?.setTheForkRateCount("\(detail.rate_count) TheFork reviews")
        view?.setTripAdvisorVote(max: 5, current: detail.tripadvisor_avg_rate)
        view?.setTripAdvisorReviewsNumber("\(detail.tripadvisor_rate_count) TripAdvisor reviews")
    }
}
