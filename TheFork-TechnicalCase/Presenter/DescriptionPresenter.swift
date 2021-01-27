//
//  DescriptionPresenter.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import Foundation

protocol DescriptionView: class {
    func setTitle(_ title: String)
    func setAddress(_ address: String)
    func setSpeciality(_ speciality: String)
    func setAveragePrice(_ averagePrice: String)
}

class DescriptionPresenter {
    
    weak var view: DescriptionView? {
        didSet {
            setupView()
        }
    }
    
    init(detail: GetDetail) {
        self.detail = detail
    }

    // MARK: - Private
    
    private let detail: GetDetail
    
    private func setupView() {
        view?.setTitle(detail.name)
        view?.setAddress("\(detail.address), \(detail.city) \(detail.zipcode)")
        view?.setSpeciality(detail.speciality)
        view?.setAveragePrice("Average price \(getCurrencySymbol(fromCurrencyCode: detail.currency_code) ?? "")\(detail.card_price)")
    }
    
    private func getCurrencySymbol(fromCurrencyCode currencyCode: String) -> String? {
        return Locale.availableIdentifiers.map{Locale(identifier: $0)}.first {$0.currencyCode == currencyCode}?.currencySymbol
    }
}
