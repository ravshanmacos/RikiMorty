//
//  UIStackView+ext.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 18.08.2023.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...){
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview($0)
        }
    }
}
