//
//  DetailViewController.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import UIKit

class DetailViewController: ConstraintableViewController {
    
    override func addSubviews() {
        view.addSubview(collectionView)
    }
    
    override func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Private
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        return collectionView
    }()
}


// MARK: - DetailView

extension DetailViewController: DetailView {
    var isLoading: Bool {
        get {
            <#code#>
        }
        set {
            <#code#>
        }
    }
    
    func showAlert(title: String, message: String) {
        <#code#>
    }
    
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
