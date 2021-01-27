//
//  TitleCollectionViewCell.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 26/01/21.
//

import UIKit

class DescriptionCollectionViewCell: UICollectionViewCell, Reusable {
    
    var presenter: DescriptionPresenter?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let padding = UIEdgeInsets(top: 17, left: 17, bottom: 0, right: -17)
        static let imageWidth: CGFloat = 30
        static let descriptionSpacing: CGFloat = 8
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Names.main
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    private lazy var addressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.descriptionSpacing
        return stackView
    }()
    
    private lazy var addressLabel = createDescriptionLabel()
    private lazy var addressBackgroundImageView = createBackgroundImageView()
    private lazy var addressImageView = createDescriptionImageView(withImage: UIImage.Names.location)
    
    private lazy var specialityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.descriptionSpacing
        return stackView
    }()
    
    private lazy var specialityLabel = createDescriptionLabel()
    private lazy var specialityBackgroundImageView = createBackgroundImageView()
    private lazy var specialityImageView = createDescriptionImageView(withImage: UIImage.Names.food)
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.descriptionSpacing
        return stackView
    }()
    
    private lazy var priceLabel = createDescriptionLabel()
    private lazy var priceBackgroundImageView = createBackgroundImageView()
    private lazy var priceImageView = createDescriptionImageView(withImage: UIImage.Names.cash)
    
    private func commonInit() {
        addSubviews()
        addConstraints()
        backgroundColor = .white
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addressBackgroundImageView.addSubview(addressImageView)
        addressStackView.addArrangedSubview(addressBackgroundImageView)
        addressStackView.addArrangedSubview(addressLabel)
        specialityBackgroundImageView.addSubview(specialityImageView)
        specialityStackView.addArrangedSubview(specialityBackgroundImageView)
        specialityStackView.addArrangedSubview(specialityLabel)
        priceBackgroundImageView.addSubview(priceImageView)
        priceStackView.addArrangedSubview(priceBackgroundImageView)
        priceStackView.addArrangedSubview(priceLabel)
        mainStackView.addArrangedSubview(addressStackView)
        mainStackView.addArrangedSubview(specialityStackView)
        mainStackView.addArrangedSubview(priceStackView)
        addSubview(mainStackView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding.top),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.padding.left),
            titleLabel.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -17),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.padding.right),
            
            addressBackgroundImageView.centerXAnchor.constraint(equalTo: addressImageView.centerXAnchor),
            addressBackgroundImageView.centerYAnchor.constraint(equalTo: addressImageView.centerYAnchor),
            addressBackgroundImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            addressBackgroundImageView.heightAnchor.constraint(equalTo: addressBackgroundImageView.widthAnchor),
            addressImageView.widthAnchor.constraint(equalTo: addressBackgroundImageView.widthAnchor, multiplier: 0.6),
            addressImageView.heightAnchor.constraint(equalTo: addressImageView.widthAnchor),
            addressImageView.centerXAnchor.constraint(equalTo: addressBackgroundImageView.centerXAnchor),
            addressImageView.centerYAnchor.constraint(equalTo: addressBackgroundImageView.centerYAnchor),
            
            specialityBackgroundImageView.centerXAnchor.constraint(equalTo: specialityImageView.centerXAnchor),
            specialityBackgroundImageView.centerYAnchor.constraint(equalTo: specialityImageView.centerYAnchor),
            specialityBackgroundImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            specialityBackgroundImageView.heightAnchor.constraint(equalTo: specialityBackgroundImageView.widthAnchor),
            specialityImageView.widthAnchor.constraint(equalTo: specialityBackgroundImageView.widthAnchor, multiplier: 0.6),
            specialityImageView.heightAnchor.constraint(equalTo: specialityImageView.widthAnchor),
            specialityImageView.centerXAnchor.constraint(equalTo: specialityBackgroundImageView.centerXAnchor),
            specialityImageView.centerYAnchor.constraint(equalTo: specialityBackgroundImageView.centerYAnchor),
            
            priceBackgroundImageView.centerXAnchor.constraint(equalTo: priceImageView.centerXAnchor),
            priceBackgroundImageView.centerYAnchor.constraint(equalTo: priceImageView.centerYAnchor),
            priceBackgroundImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            priceBackgroundImageView.heightAnchor.constraint(equalTo: priceBackgroundImageView.widthAnchor),
            priceImageView.widthAnchor.constraint(equalTo: priceBackgroundImageView.widthAnchor, multiplier: 0.6),
            priceImageView.heightAnchor.constraint(equalTo: priceImageView.widthAnchor),
            priceImageView.centerXAnchor.constraint(equalTo: priceBackgroundImageView.centerXAnchor),
            priceImageView.centerYAnchor.constraint(equalTo: priceBackgroundImageView.centerYAnchor),
            
            mainStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.padding.left),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.padding.bottom),
            mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.padding.right)
        ])
    }
    
    private func createBackgroundImageView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.Names.accentColor?.withAlphaComponent(0.1)
        view.layer.cornerRadius = 8
        return view
    }
    
    private func createDescriptionImageView(withImage image: UIImage?) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor.Names.accentColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func createDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.Names.main
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        return label
    }
}

// MARK: - DescriptionView

extension DescriptionCollectionViewCell: DescriptionView {
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setAddress(_ address: String) {
        addressLabel.text = address
    }
    
    func setSpeciality(_ speciality: String) {
        specialityLabel.text = speciality
    }
    
    func setAveragePrice(_ averagePrice: String) {
        priceLabel.text = averagePrice
    }
}
