//
//  ConstraintableViewController.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import UIKit

protocol Constraintable {
    func addSubviews()
    func addConstraints()
}

class ConstraintableViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
    }
    
    func addSubviews() {}
    
    func addConstraints() {}
}
