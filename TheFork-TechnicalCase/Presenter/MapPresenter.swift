//
//  MapPresenter.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import MapKit

protocol MapView: class {
    func setMapCenter(coordinate: CLLocationCoordinate2D)
    func setMapAnnotation(coordinate: CLLocationCoordinate2D)
}

class MapPresenter {
    
    weak var view: MapView? {
        didSet {
            setupView()
        }
    }
    
    init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
    }
    
    // MARK: - Private
    
    private func setupView() {
        view?.setMapCenter(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long))
        view?.setMapAnnotation(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long))
    }
    
    private let lat: Double
    private let long: Double
}
