//
//  GetDetail.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import Foundation

struct GetDetail: Codable {
    let id: Int
    let name: String
    let gps_lat: Double
    let gps_long: Double
    let address: String
    let city: String
    let zipcode: String
    let currency_code: String
    let card_price: Int
    let tripadvisor_avg_rate: Int
    let tripadvisor_rate_count: Int
    let avg_rate: Double
    let rate_count: Int
    let speciality: String
    let url: String
    let pics_diaporama: [String]
}
