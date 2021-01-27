//
//  Styles.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 27/01/21.
//

import UIKit

enum Styles {
    enum Buttons {
        static func main(appliedTo button: UIButton) {
            button.backgroundColor = UIColor.Names.accentColor
            button.layer.cornerRadius = button.bounds.height / 2
            button.layer.shadowColor = UIColor.Names.accentColorDarker?.cgColor
            button.layer.shadowOpacity = 3.0
            button.layer.shadowRadius = 1.0
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.titleLabel?.textColor = .white
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        }
    }
}
