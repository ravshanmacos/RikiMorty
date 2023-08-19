//
//  ViewController.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 18.08.2023.
//

import UIKit

class MainViewController: BaseViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 10
        layout.itemSize = .init(width: 175, height: 202)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let networking = Networking()
    private var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCharacters()
    }

    override func setupViews() {
        super.setupViews()
        view.addSubviews(collectionView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func configureView() {
        super.configureView()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        let character = characters[indexPath.row]
        cell.configureCell(characterName: character.name, characterImageURL: character.imageURL)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        let detailVC = DetailTableViewController(character: character)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: - Networking
private extension MainViewController {
    func getCharacters() {
        networking.request(urlString: Routes().charactersRoute) { [self] data, error in
            guard error == nil, let data else { print(error!); return }
            do {
                let data = try networking.decode(from: data, to: CharactersData.self)
                if let characters = data.characters {
                    DispatchQueue.main.async {
                        self.characters = characters
                        self.collectionView.reloadData()
                    }
                }
            } catch let error {
                print(error)
            }
        }
    }
}


