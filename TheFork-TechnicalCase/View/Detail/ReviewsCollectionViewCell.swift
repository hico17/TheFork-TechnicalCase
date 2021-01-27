//
//  ReviewsCollectionViewCell.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 26/01/21.
//

import UIKit

class ReviewsCollectionViewCell: UICollectionViewCell, Reusable {
    
    weak var presenter: ReviewsPresenter?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Private
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.clear.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 8.0)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 4.0
        return view
    }()
    
    private lazy var roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 17
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private lazy var theForkReviewsView: TheForkReviewsView = {
        let theForkReviewsView = TheForkReviewsView()
        return theForkReviewsView
    }()
    
    private lazy var tripAdvisorReviewsView: TripAdvisorReviewsView = {
        let tripAdvisorReviewsView = TripAdvisorReviewsView()
        return tripAdvisorReviewsView
    }()
    
    private func commonInit() {
        addSubviews()
        addConstraints()
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        addSubview(shadowView)
        shadowView.addSubview(roundedView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.leftAnchor.constraint(equalTo: leftAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17),
            shadowView.rightAnchor.constraint(equalTo: rightAnchor),
            roundedView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            roundedView.leftAnchor.constraint(equalTo: shadowView.leftAnchor),
            roundedView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            roundedView.rightAnchor.constraint(equalTo: shadowView.rightAnchor)
        ])
    }
}

extension ReviewsCollectionViewCell: ReviewsView {
    func setTheForkAverageRate(max: Int, current: Double) {
        // TODO
    }
    
    func setTheForkRateCount(_ rate: String) {
        // TODO
    }
    
    func setTripAdvisorVote(max: Int, current: Int) {
        // TODO
    }
    
    func setTripAdvisorReviewsNumber(_ rate: String) {
        // TODO
    }
}
