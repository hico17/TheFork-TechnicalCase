//
//  MapCollectionViewCell.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 26/01/21.
//

import UIKit
import MapKit

class MapCollectionViewCell: UICollectionViewCell, Reusable {
    
    var presenter: MapPresenter?
    
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
        static let padding = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
    }
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isUserInteractionEnabled = false
        return mapView
    }()

    private func commonInit() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(mapView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            mapView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding.top),
            mapView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.padding.left),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.padding.bottom),
            mapView.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.padding.right)
        ])
    }
}

// MARK: - MapView

extension MapCollectionViewCell: MapView {
    
    func setMapCenter(coordinate: CLLocationCoordinate2D) {
        mapView.setCenter(coordinate, animated: true)
    }
    
    func setMapAnnotation(coordinate: CLLocationCoordinate2D) {
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}
