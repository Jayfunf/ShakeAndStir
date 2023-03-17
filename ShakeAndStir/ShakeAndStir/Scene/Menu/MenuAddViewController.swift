//
//  MenuAddViewController.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/03/17.
//

import UIKit

class MenuAddViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let backButton = UIBarButtonItem(title: "안할래요", style: .plain, target: self, action: #selector(backToMenu))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backToMenu() {
        dismiss(animated: true)
    }
}
