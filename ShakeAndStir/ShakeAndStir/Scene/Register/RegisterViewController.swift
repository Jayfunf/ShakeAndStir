//
//  RegisterViewController.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/03/03.
//

import UIKit

import SnapKit

class RegisterViewController: UIViewController {
    
    var nameField: UITextField = {
        let field = UITextField()
        
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupView()
    }
    
    func setupView() {
        view.addSubview(nameField)
        nameField.snp.makeConstraints {
            $0.left.top.equalToSuperview().inset(25)
        }
    }
    
    
}
