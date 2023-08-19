//
//  BaseView.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 18.08.2023.
//

import Foundation
import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {}
    func setupConstraints() {}
    func configureView() {
        backgroundColor = .clear
    }
}
