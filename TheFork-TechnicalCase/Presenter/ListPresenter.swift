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

protocol ListView {
    func setTitle(_ title: String)
    func setMainButtonTitle(_ title: String)
}

class ListPresenter {
    
    weak var delegate: ListPresenterDelegate?
    
    init(listView: ListView) {
        self.listView = listView
        setupView()
    }
    
    func mainButtonDidPress() {
        delegate?.listPresenterMainButtonDidPress(self)
    }
    
    // MARK: - Private
    
    private var listView: ListView
    
    private func setupView() {
        listView.setTitle("List")
        listView.setMainButtonTitle("Go to detail")
    }
}
