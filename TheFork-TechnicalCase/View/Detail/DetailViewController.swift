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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func addSubviews() {
        view.addSubview(activityIndicatorView)
        view.addSubview(collectionView)
        view.addSubview(bookButton)
        view.addSubview(clearNavigationBarContainerView)
        clearNavigationBarContainerView.addSubview(clearNavigationBar)
    }
    
    override func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            clearNavigationBarContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            clearNavigationBarContainerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            clearNavigationBarContainerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            clearNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            clearNavigationBar.leftAnchor.constraint(equalTo: clearNavigationBarContainerView.leftAnchor),
            clearNavigationBar.bottomAnchor.constraint(equalTo: clearNavigationBarContainerView.bottomAnchor),
            clearNavigationBar.rightAnchor.constraint(equalTo: clearNavigationBarContainerView.rightAnchor),
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
        static let backgroundBarButtonItemAlpha: CGFloat = 0.5
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
    
    private lazy var clearNavigationBarContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Names.accentColor
        return view
    }()
    
    private lazy var clearNavigationBar: UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.tintColor = .white
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBar.pushItem(clearNavigationItem, animated: false)
        return navBar
    }()
    
    private lazy var clearNavigationItem: UINavigationItem = {
        let navigationItem = UINavigationItem()
        navigationItem.rightBarButtonItems = [solidHeartBarButtonItemWithBackground, shareBarButtonItemWithBackground]
        navigationItem.leftBarButtonItem = backBarButtonItemWithBackground
        navigationItem.titleView = titleLabel
        return navigationItem
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private var shareBarButtonItemWithBackground: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        Styles.BarButtons.withBackground(appliedTo: barButtonItem, image: UIImage.Names.share, alpha: Constants.backgroundBarButtonItemAlpha, target: self, action: #selector(shareButtonDidPress), for: .touchUpInside)
        return barButtonItem
    }()
    
    private var solidHeartBarButtonItemWithBackground: UIBarButtonItem {
        let barButtonItem = UIBarButtonItem()
        Styles.BarButtons.withBackground(appliedTo: barButtonItem, image: UIImage.Names.solidHeart, alpha: Constants.backgroundBarButtonItemAlpha, target: self, action: #selector(heartButtonDidPress), for: .touchUpInside)
        return barButtonItem
    }
    
    private var backBarButtonItemWithBackground: UIBarButtonItem {
        let barButtonItem = UIBarButtonItem()
        Styles.BarButtons.withBackground(appliedTo: barButtonItem, image: UIImage.Names.back, alpha: Constants.backgroundBarButtonItemAlpha, target: self, action: #selector(backButtonDidPress), for: .touchUpInside)
        return barButtonItem
    }
    
    private var dataSource = [DetailPresenter.DataSource]() {
        didSet {
            displayedIndexPath = []
            collectionView.reloadData()
        }
    }
    
    private var displayedIndexPath = Set<IndexPath>()
    
    @objc private func backButtonDidPress() {
        presenter?.backButtonDidPress()
    }
    
    @objc private func heartButtonDidPress() {
        print("heart pressed")
    }
    
    @objc private func shareButtonDidPress() {
        print("share pressed")
    }
}

// MARK: - DetailView

extension DetailViewController: DetailView {
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    var isLoading: Bool {
        get {
            return activityIndicatorView.isAnimating
        }
        set {
            newValue ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
            bookButton.isHidden = newValue
            clearNavigationBarContainerView.isHidden = newValue
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
            return CGSize(width: view.frame.width, height: 170)
        case .reviews:
            return CGSize(width: view.frame.width, height: 117)
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard !displayedIndexPath.contains(indexPath) else { return }
        cell.alpha = 0
        UIView.animate(withDuration: 0.3) {
            cell.alpha = 1
        }
        displayedIndexPath.insert(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let starterPoint = Constants.imagesHeight * 0.5
        guard scrollView.contentOffset.y > starterPoint else {
            clearNavigationBarContainerView.backgroundColor = clearNavigationBarContainerView.backgroundColor?.withAlphaComponent(0)
            clearNavigationItem.titleView?.alpha = 0
            clearNavigationItem.rightBarButtonItems?.forEach{
                $0.customView?.backgroundColor = $0.customView?.backgroundColor?.withAlphaComponent(Constants.backgroundBarButtonItemAlpha)
            }
            clearNavigationItem.leftBarButtonItems?.forEach{
                $0.customView?.backgroundColor = $0.customView?.backgroundColor?.withAlphaComponent(Constants.backgroundBarButtonItemAlpha)
            }
            return
        }
        let alpha = min(1, (scrollView.contentOffset.y - starterPoint) / (Constants.imagesHeight - starterPoint - CGFloat(navigationController?.navigationBar.frame.height ?? 0.0)))
        clearNavigationBarContainerView.backgroundColor = clearNavigationBarContainerView.backgroundColor?.withAlphaComponent(alpha)
        clearNavigationItem.titleView?.alpha = alpha
        clearNavigationItem.rightBarButtonItems?.forEach{
            $0.customView?.backgroundColor = $0.customView?.backgroundColor?.withAlphaComponent((1 - alpha) * Constants.backgroundBarButtonItemAlpha)
        }
        clearNavigationItem.leftBarButtonItems?.forEach{
            $0.customView?.backgroundColor = $0.customView?.backgroundColor?.withAlphaComponent((1 - alpha) * Constants.backgroundBarButtonItemAlpha)
        }
    }
}
