//
//  DetailTableViewController.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 18.08.2023.
//

import Foundation
import UIKit

final class DetailTableViewController: BaseViewController {
    
    private let sectionTitles: [String] = ["Info", "Origin", "Episodes"]
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.backgroundColor = .clear
        table.insetsContentViewsToSafeArea = false
        table.contentInsetAdjustmentBehavior = .never
        return table
    }()
    
    private let character: Character
    private var episodes: [String] {
        return character.episodes ?? []
    }
    
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubviews(tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "chevronLeft"), style: .plain, target: self, action: #selector(backButtonTapped))
    }
    
    @IBAction func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func configureView() {
        super.configureView()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(DetailHeaderViewCell.self, forCellReuseIdentifier: DetailHeaderViewCell.identifier)
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
        tableView.register(OriginTableViewCell.self, forCellReuseIdentifier: OriginTableViewCell.identifier)
        tableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.identifier)
    }
    
    
}

extension DetailTableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 3 ? episodes.count : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 240
        case 1:
            return 124
        case 2:
            return 80
        case 3:
            return 86
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section != 0 else { return nil }
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = sectionTitles[section - 1]
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailHeaderViewCell.identifier) as! DetailHeaderViewCell
            cell.offset = 0
            cell.configureHeaderView(character: character)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as! InfoTableViewCell
            cell.configureCell(with: character)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: OriginTableViewCell.identifier, for: indexPath) as! OriginTableViewCell
            cell.configureCell(with: character.origin)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.identifier, for: indexPath) as! EpisodeTableViewCell
            let urlString = episodes[indexPath.row]
            print("hello\(indexPath.row)")
            cell.configureCell(with: urlString)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
