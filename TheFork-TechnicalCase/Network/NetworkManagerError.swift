//
//  NetworkManagerError.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import Foundation

enum NetworkManagerError: LocalizedError {
    case urlCreationError
    case missingData
    case notValidStatusCode
    case offline
    case generic
}
