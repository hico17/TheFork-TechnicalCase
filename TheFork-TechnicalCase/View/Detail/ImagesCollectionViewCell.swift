//
//  ImagesCollectionViewCell.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 26/01/21.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell, Reusable {
    
    var presenter: ImagesPresenter? {
        didSet {
            collectionView.reloadData()
        }
    }
    
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
        static let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        static let photosBackgroundButtonPadding: CGFloat = 17
        static let photosButtonPadding = UIEdgeInsets(top: 4, left: 17, bottom: -4, right: -17)
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ImageCollectionViewCell.self)
        return collectionView
    }()
    
    private lazy var blurredBackgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.cornerRadius = 8
        blurEffectView.layer.masksToBounds = true
        return blurEffectView
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.7).cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.7).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 0.3, 0.7, 1]
        gradientLayer.frame = bounds
        return gradientLayer
    }()
    
    private lazy var seePhotosButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()
    
    private func commonInit() {
        addSubviews()
        addConstraints()
        let collectionViewLayer = UInt32(subviews.firstIndex(of: collectionView) ?? 0)
        layer.insertSublayer(gradientLayer, at: collectionViewLayer + 1)
    }
    
    private func addSubviews() {
        addSubview(collectionView)
        addSubview(blurredBackgroundView)
        blurredBackgroundView.contentView.addSubview(seePhotosButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            blurredBackgroundView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.photosBackgroundButtonPadding),
            blurredBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.photosBackgroundButtonPadding),
            seePhotosButton.topAnchor.constraint(equalTo: blurredBackgroundView.topAnchor, constant: Constants.photosButtonPadding.top),
            seePhotosButton.leftAnchor.constraint(equalTo: blurredBackgroundView.leftAnchor, constant: Constants.photosButtonPadding.left),
            seePhotosButton.bottomAnchor.constraint(equalTo: blurredBackgroundView.bottomAnchor, constant: Constants.photosButtonPadding.bottom),
            seePhotosButton.rightAnchor.constraint(equalTo: blurredBackgroundView.rightAnchor, constant: Constants.photosButtonPadding.right),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding.top),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.padding.left),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.padding.bottom),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.padding.right),
        ])
    }
}

// MARK: - ImagesView

extension ImagesCollectionViewCell: ImagesView {
    
    func setImagesButton(_ title: String) {
        seePhotosButton.setTitle(title, for: .normal)
    }
}

// MARK: - UICollectionViewDataSource

extension ImagesCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.imagePresenters.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ImageCollectionViewCell.self, for: indexPath)
        presenter?.imagePresenters[indexPath.row].view = cell
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ImagesCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width * 0.9, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
