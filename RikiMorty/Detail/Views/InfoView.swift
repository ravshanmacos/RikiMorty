//
//  InfoView.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 19.08.2023.
//

import Foundation
import UIKit

final class InfoView: BaseView {
    private let leftLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Colors.grayishTextColor
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let rightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubviews(stack)
        stack.addArrangedSubviews(leftLabel, rightLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func configure(left: String, right: String) {
        leftLabel.text = left
        rightLabel.text = right
    }
    
    func setRightLabel(right: String?) {
        rightLabel.text = right
    }
    
}
