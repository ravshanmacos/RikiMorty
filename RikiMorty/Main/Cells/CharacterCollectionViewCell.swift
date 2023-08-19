//
//  CharacterCollectionViewCell.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 18.08.2023.
//

import Foundation
import UIKit


final class CharacterCollectionViewCell: UICollectionViewCell {
    
    private let characterName: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let characterImageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    
    static let identifier = "CharacterCollectionViewCell"
    private let networking = Networking()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(characterName name: String?, characterImageURL imageURL: String?) {
        self.characterName.text = name
        if let url = imageURL {
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

private extension CharacterCollectionViewCell {
    func setupViews(){
        addSubviews(characterImageView, characterName)
    }
    func setupConstraints(){
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            characterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: 150),
            characterImageView.widthAnchor.constraint(equalToConstant: 150),

            characterName.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 10),
            characterName.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterName.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    func configure(){
        backgroundColor = Colors.secondaryBlue
        layer.cornerRadius = 16
    }
}
