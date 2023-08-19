//
//  DetailHeaderView.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 18.08.2023.
//

import Foundation
import UIKit

final class DetailHeaderViewCell: BaseTableViewCell {
    private let characterName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    private let characterStatus: UILabel = {
        let label = UILabel()
        label.textColor = Colors.green
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    private let characterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    static let identifier = "DetailHeaderView"
    private let networking = Networking()
    
    override func setupViews() {
        super.setupViews()
        holderView.addSubviews(characterImageView, characterName, characterStatus)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: holderView.topAnchor),
            characterImageView.centerXAnchor.constraint(equalTo: holderView.centerXAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 165),
            characterImageView.heightAnchor.constraint(equalToConstant: 165),

            characterName.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 10),
            characterName.centerXAnchor.constraint(equalTo: holderView.centerXAnchor),
            
            
            characterStatus.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 5),
            characterStatus.centerXAnchor.constraint(equalTo: holderView.centerXAnchor),
            characterStatus.bottomAnchor.constraint(equalTo: holderView.bottomAnchor, constant: -10),
        ])
    }
    
    override func configureView() {
        super.configureView()
        holderView.backgroundColor = .clear
    }
    
}

extension DetailHeaderViewCell {
    func configureHeaderView(character: Character) {
        
        self.characterName.text = character.name
        self.characterStatus.text = character.status
        if let url = character.imageURL {
            networking.request(urlString: url) { data, error in
                guard error == nil else {
                    print(error!); return
                }
                if let data {
                    DispatchQueue.main.async {
                        self.characterImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
