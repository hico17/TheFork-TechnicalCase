//
//  TheForkReviewsView.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 27/01/21.
//

import UIKit

class TheForkReviewsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func set(currentRate: String) {
        currentRateLabel.text = currentRate
    }
    
    func set(maximumRate: Int) {
        maximumRateLabel.text = "/\(maximumRate)"
    }
    
    func set(numberOfReviews: String) {
        numberOfReviewsLabel.text = numberOfReviews
    }
    
    // MARK: - Private
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
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
        stackView.alignment = .fill
        return stackView
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.Names.tfLogo)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var currentRateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 38, weight: .bold)
        return label
    }()
    
    private lazy var maximumRateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Names.main
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
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
        rateStackView.addArrangedSubview(currentRateLabel)
        rateStackView.addArrangedSubview(maximumRateLabel)
        mainStackView.addArrangedSubview(numberOfReviewsLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leftAnchor.constraint(equalTo: leftAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.heightAnchor.constraint(equalTo: currentRateLabel.heightAnchor)
        ])
    }
}
