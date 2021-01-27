//
//  Reusable.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 26/01/21.
//

import Foundation

public protocol Reusable {
    static var reusableIdentifier: String { get }
}

public extension Reusable {
    static var reusableIdentifier: String {
        return String(describing: type(of: self))
    }
}
