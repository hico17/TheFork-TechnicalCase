//
//  ImageCollectionViewCell.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 26/01/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell, Reusable {
    
    var presenter: ImagePresenter?
    
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
    }
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private func commonInit() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(activityIndicatorView)
        addSubview(imageView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding.top),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.padding.left),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.padding.bottom),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.padding.right)
        ])
    }
}

// MARK: - ImageView

extension ImageCollectionViewCell: ImageView {
    
    var isLoading: Bool {
        get {
            return activityIndicatorView.isAnimating
        }
        set {
            newValue ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        }
    }
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}
