//
//  TripAdvisorReviewsView.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 27/01/21.
//

import UIKit

class TripAdvisorReviewsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func set(currentRate: Double, maximumRate: Int) {
        rateStackView.arrangedSubviews.forEach{rateStackView.removeArrangedSubview($0)}
        let floorCurrentRate = floor(currentRate)
        let integerFloorCurrentRate = Int(floorCurrentRate)
        for _ in 0..<integerFloorCurrentRate {
            let imageView = UIImageView(image: UIImage.Names.taBubblesFull)
            imageView.contentMode = .scaleAspectFit
            rateStackView.addArrangedSubview(imageView)
        }
        if floorCurrentRate != currentRate {
            let imageView = UIImageView(image: UIImage.Names.taBubblesHalf)
            imageView.contentMode = .scaleAspectFit
            rateStackView.addArrangedSubview(imageView)
        }
        if rateStackView.arrangedSubviews.count < maximumRate {
            for _ in rateStackView.arrangedSubviews.count..<maximumRate {
                let imageView = UIImageView(image: UIImage.Names.taBubblesEmpty)
                imageView.contentMode = .scaleAspectFit
                rateStackView.addArrangedSubview(imageView)
            }
        }
    }
    
    func set(numberOfReviews: String) {
        numberOfReviewsLabel.text = numberOfReviews
    }
    
    // MARK: - Private
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var rateAndImageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var rateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        return stackView
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.Names.taLogo)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var numberOfReviewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private func commonInit() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(rateAndImageStackView)
        rateAndImageStackView.addArrangedSubview(imageView)
        rateAndImageStackView.addArrangedSubview(rateStackView)
        mainStackView.addArrangedSubview(numberOfReviewsLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leftAnchor.constraint(equalTo: leftAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
