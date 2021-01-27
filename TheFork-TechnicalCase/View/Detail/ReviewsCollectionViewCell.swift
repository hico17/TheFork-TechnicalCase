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
    
    private lazy var leftView = UIView()
    private lazy var rightView = UIView()
    
    private lazy var theForkReviewsView: TheForkReviewsView = {
        let theForkReviewsView = TheForkReviewsView()
        return theForkReviewsView
    }()
    
    private lazy var verticalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
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
        roundedView.addSubview(leftView)
        roundedView.addSubview(rightView)
        leftView.addSubview(theForkReviewsView)
        roundedView.addSubview(verticalSeparator)
        rightView.addSubview(tripAdvisorReviewsView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            leftView.topAnchor.constraint(equalTo: roundedView.topAnchor),
            leftView.leftAnchor.constraint(equalTo: roundedView.leftAnchor),
            leftView.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor),
            leftView.rightAnchor.constraint(equalTo: verticalSeparator.leftAnchor),
            verticalSeparator.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor),
            verticalSeparator.widthAnchor.constraint(equalToConstant: 1),
            verticalSeparator.heightAnchor.constraint(equalTo: roundedView.heightAnchor, multiplier: 0.35),
            rightView.topAnchor.constraint(equalTo: roundedView.topAnchor),
            rightView.rightAnchor.constraint(equalTo: roundedView.rightAnchor),
            rightView.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor),
            rightView.leftAnchor.constraint(equalTo: verticalSeparator.rightAnchor),
            theForkReviewsView.centerXAnchor.constraint(equalTo: leftView.centerXAnchor),
            theForkReviewsView.centerYAnchor.constraint(equalTo: leftView.centerYAnchor),
            tripAdvisorReviewsView.centerXAnchor.constraint(equalTo: rightView.centerXAnchor),
            tripAdvisorReviewsView.bottomAnchor.constraint(equalTo: theForkReviewsView.bottomAnchor),
            leftView.widthAnchor.constraint(equalTo: rightView.widthAnchor),
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

// MARK: - ReviewsView

extension ReviewsCollectionViewCell: ReviewsView {
    
    func setTheForkAverageRate(max: Int, current: Double) {
        theForkReviewsView.set(currentRate: String(current))
        theForkReviewsView.set(maximumRate: max)
    }
    
    func setTheForkRateCount(_ rate: String) {
        theForkReviewsView.set(numberOfReviews: rate)
    }
    
    func setTripAdvisorVote(max: Int, current: Double) {
        tripAdvisorReviewsView.set(currentRate: current, maximumRate: max)
    }
    
    func setTripAdvisorReviewsNumber(_ rate: String) {
        tripAdvisorReviewsView.set(numberOfReviews: rate)
    }
}
