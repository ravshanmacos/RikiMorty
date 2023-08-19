//
//  BaseViewController.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 18.08.2023.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        configureView()
    }
    
    func setupViews() {}
    func setupConstraints() {}
    func configureView() {
        view.backgroundColor = Colors.mainBckColor
    }
}

