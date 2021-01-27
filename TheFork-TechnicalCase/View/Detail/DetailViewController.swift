//
//  DetailViewController.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import UIKit

class DetailViewController: ConstraintableViewController {
    
    var presenter: DetailPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .groupTableViewBackground
        scrollViewDidScroll(collectionView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.alpha = 1
    }
    
    override func addSubviews() {
        view.addSubview(activityIndicatorView)
        view.addSubview(collectionView)
        view.addSubview(bookButton)
    }
    
    override func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bookButton.heightAnchor.constraint(equalToConstant: Constants.bookButtonHeight),
            bookButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.bookButtonPadding.left),
            bookButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Constants.bookButtonPadding.right),
            bookButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.bookButtonPadding.bottom),
        ])
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let imagesHeight: CGFloat = 270
        static let bookButtonPadding = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: -17)
        static let bookButtonHeight: CGFloat = 45
    }
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.color = .systemGray
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImagesCollectionViewCell.self)
        collectionView.register(DescriptionCollectionViewCell.self)
        collectionView.register(ReviewsCollectionViewCell.self)
        collectionView.register(MapCollectionViewCell.self)
        collectionView.contentInset.bottom = Constants.imagesHeight
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    private lazy var bookButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: Constants.bookButtonHeight))
        Styles.Buttons.main(appliedTo: button)
        button.setTitle("Book a table", for: .normal)
        return button
    }()
    
    private var dataSource = [DetailPresenter.DataSource]() {
        didSet {
            collectionView.reloadData()
        }
    }
}

// MARK: - DetailView

extension DetailViewController: DetailView {
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    var isLoading: Bool {
        get {
            return activityIndicatorView.isAnimating
        }
        set {
            newValue ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        }
    }
    
    func setDataSource(dataSource: [DetailPresenter.DataSource]) {
        self.dataSource = dataSource
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch dataSource[indexPath.row] {
        case .images(let presenter):
            let cell = collectionView.dequeueReusableCell(ImagesCollectionViewCell.self, for: indexPath)
            presenter.view = cell
            cell.presenter = presenter
            return cell
        case .description(let presenter):
            let cell = collectionView.dequeueReusableCell(DescriptionCollectionViewCell.self, for: indexPath)
            presenter.view = cell
            cell.presenter = presenter
            return cell
        case .reviews(let presenter):
            let cell = collectionView.dequeueReusableCell(ReviewsCollectionViewCell.self, for: indexPath)
            presenter.view = cell
            cell.presenter = presenter
            return cell
        case .map(let presenter):
            let cell = collectionView.dequeueReusableCell(MapCollectionViewCell.self, for: indexPath)
            presenter.view = cell
            cell.presenter = presenter
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailViewController: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch dataSource[indexPath.row] {
        case .images:
            return CGSize(width: view.frame.width, height: Constants.imagesHeight)
        case .description:
            return CGSize(width: view.frame.width, height: 200)
        case .reviews:
            return CGSize(width: view.frame.width, height: 126)
        case .map:
            return CGSize(width: view.frame.width, height: 300)
        }
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

// MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let starterPoint = Constants.imagesHeight * 0.5
        guard scrollView.contentOffset.y > starterPoint else {
            navigationController?.navigationBar.alpha = 0
            return
        }
        let alpha = min(1, (scrollView.contentOffset.y - starterPoint) / (Constants.imagesHeight - starterPoint - CGFloat(navigationController?.navigationBar.frame.height ?? 0.0)))
        navigationController?.navigationBar.alpha = alpha
    }
}
