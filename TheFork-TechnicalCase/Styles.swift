//
//  Styles.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 27/01/21.
//

import UIKit

enum Styles {
    enum BarButtons {
        static func withBackground(appliedTo barButtonItem: UIBarButtonItem, image: UIImage?, alpha: CGFloat, target: Any?, action: Selector, for event: UIControl.Event) {
            let shareButton = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
            shareButton.setImage(image, for: .normal)
            shareButton.backgroundColor = UIColor.black.withAlphaComponent(alpha)
            shareButton.layer.cornerRadius = shareButton.frame.height / 2
            shareButton.addTarget(target, action: action, for: event)
            barButtonItem.customView = shareButton
        }
    }
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
