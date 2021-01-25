//
//  NSLayoutConstraints+activateWithoutResizingMasks.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import UIKit

public extension NSLayoutConstraint {

    static func activateWithoutResizingMasks(_ constraints: [NSLayoutConstraint]) {
        constraints.forEach {
            if let view = $0.firstItem as? UIView {
                 view.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        activate(constraints)
    }
}
