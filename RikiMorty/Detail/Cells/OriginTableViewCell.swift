//
//  OriginTableViewCell.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 18.08.2023.
//

import Foundation
import UIKit

final class OriginTableViewCell: BaseTableViewCell {
    private let originName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    private let originType: UILabel = {
        let label = UILabel()
        label.textColor = Colors.green
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    private let originImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let originImageViewWrapper: UIView = {
       let view = UIView()
        view.backgroundColor = Colors.mainBckColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    static let identifier = "OriginTableViewCell"
    private let networking = Networking()
    
    override func setupViews() {
        super.setupViews()
        holderView.addSubviews(originImageViewWrapper, stack)
        originImageViewWrapper.addSubviews(originImageView)
        stack.addArrangedSubviews(originName, originType)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            originImageViewWrapper.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 5),
            originImageViewWrapper.bottomAnchor.constraint(equalTo: holderView.bottomAnchor, constant: -5),
            originImageViewWrapper.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 10),
            originImageViewWrapper.widthAnchor.constraint(equalToConstant: 64),

            originImageView.centerYAnchor.constraint(equalTo: originImageViewWrapper.centerYAnchor),
            originImageView.centerXAnchor.constraint(equalTo: originImageViewWrapper.centerXAnchor),

            stack.centerYAnchor.constraint(equalTo: holderView.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: originImageViewWrapper.trailingAnchor, constant: 10)
        ])
    }
}

extension OriginTableViewCell {
    func configureCell(with origin: Origin?) {
        guard let origin else { return }
        originName.text = origin.name?.components(separatedBy: " ").first
        networking.request(urlString: origin.url) { data, error in
            guard error == nil, let data else { print(error!); return }
            do {
                let originInfo = try self.networking.decode(from: data, to: OriginInfo.self)
                DispatchQueue.main.async {
                    self.originType.text = originInfo.type
                }
            } catch {
                print(error)
            }
        }
       
        originImageView.image = UIImage(named: "planet")
    }
}
