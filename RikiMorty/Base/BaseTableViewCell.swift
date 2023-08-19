//
//  BaseTableViewCell.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 18.08.2023.
//

import Foundation
import UIKit

class BaseTableViewCell: UITableViewCell {
    let holderView: UIView = {
       let view = UIView()
        view.backgroundColor = Colors.secondaryBlue
        view.layer.cornerRadius = 16
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        configureView()
    }
    
    var offset: CGFloat = 10 {
        didSet {
            NSLayoutConstraint.activate([
                holderView.topAnchor.constraint(equalTo: topAnchor, constant: offset)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        contentView.addSubviews(holderView)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            holderView.topAnchor.constraint(equalTo: topAnchor, constant: offset),
            holderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            holderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            holderView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    func configureView(){
        backgroundColor = .clear
    }
}
