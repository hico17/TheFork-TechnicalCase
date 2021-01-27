//
//  ListPresenter.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 25/01/21.
//

import Foundation

protocol ListPresenterDelegate: class {
    func listPresenterMainButtonDidPress(_ listPresenter: ListPresenter)
}

protocol ListView: class {
    func setTitle(_ title: String)
    func setMainButtonTitle(_ title: String)
}

class ListPresenter {
    
    weak var delegate: ListPresenterDelegate?
    weak var listView: ListView? {
        didSet {
            setupView()
        }
    }
    
    func mainButtonDidPress() {
        delegate?.listPresenterMainButtonDidPress(self)
    }
    
    // MARK: - Private
        
    private func setupView() {
        listView?.setTitle("List")
        listView?.setMainButtonTitle("Go to detail")
    }
}
