//
//  BaseNavigationController.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 18.08.2023.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        let titleAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.white ]
        
        navigationBar.standardAppearance.largeTitleTextAttributes = titleAttributes
        navigationBar.titleTextAttributes = titleAttributes
        
        navigationBar.tintColor = .white
    }
}
