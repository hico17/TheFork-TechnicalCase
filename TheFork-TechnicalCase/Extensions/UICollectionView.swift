//
//  UICollectionView+Register.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 26/01/21.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ cellType: T.Type) where T: Reusable {
        register(cellType, forCellWithReuseIdentifier: cellType.reusableIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Error: cannot dequeue cell of type \(T.self) at indexPath \(indexPath)")
        }
        return cell
    }
}
