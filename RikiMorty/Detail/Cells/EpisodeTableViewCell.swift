//
//  EpisodeTableViewCell.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 18.08.2023.
//

import Foundation
import UIKit

final class EpisodeTableViewCell: BaseTableViewCell {
    private let title: UILabel = {
        let label = UILabel()
        label.text = "Pilot"
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    private let subtitle: UILabel = {
        let label = UILabel()
        label.text = "Episode: 1, Season: 1"
        label.textColor = Colors.green
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "December 2, 2013"
        label.textColor = Colors.grayishTextColor
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    static let identifier = "EpisodeTableViewCell"
    private let networking = Networking()
    override func setupViews() {
        super.setupViews()
        holderView.addSubviews(title, subtitle, dateLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 10),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: subtitle.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -10),
        ])
    }
    
    func configureCell(with url: String?) {
        guard let url else { return }
        networking.request(urlString: url) {[self] data, error in
            guard error == nil, let data else { print(error!); return }
            do{
                let episode = try networking.decode(from: data, to: Episode.self)
                DispatchQueue.main.async {
                    self.title.text = episode.name
                    self.subtitle.text = episode.episode
                    self.dateLabel.text = episode.airDate
                }
            }catch{
                print(error)
            }
        }
    }
}
