//
//  InfoTableViewCell.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 18.08.2023.
//

import Foundation
import UIKit

final class InfoTableViewCell: BaseTableViewCell {
    private let characterName: UILabel = {
        let label = UILabel()
        label.text = "Species:"
        label.textColor = Colors.grayishTextColor
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private var speciesField: InfoView = {
        let view = InfoView()
        view.configure(left: "Species:", right: "Human")
        return view
    }()
    
    private var typeField: InfoView = {
        let view = InfoView()
        view.configure(left: "Type:", right: "None")
        return view
    }()
    
    private var genderField: InfoView = {
        let view = InfoView()
        view.configure(left: "Gender:", right: "None")
        return view
    }()
    
    private let stack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    static let identifier = "InfoTableViewCell"
    
    override func setupViews() {
        super.setupViews()
        holderView.addSubviews(stack)
        stack.addArrangedSubviews(speciesField, typeField, genderField)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            holderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            
            stack.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: holderView.bottomAnchor, constant: -10),
            stack.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -10)
        ])
    }
    
    func configureCell(with character: Character) {
        speciesField.setRightLabel(right: character.species)
        typeField.setRightLabel(right: character.type)
        genderField.setRightLabel(right: character.gender)
    }
}
