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
    
    var
    
    
    var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("계속해요", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let backButton = UIBarButtonItem(title: "안할래요", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        setupView()
    }
    
    func setupView() {
        view.addSubview(nameField)
        nameField.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
//        view.addSubview(closeButton)
//        closeButton.snp.makeConstraints {
//            $0.left.equalToSuperview().inset(15)
//            $0.top.equalToSuperview().inset(30)
//        }
//
//        view.addSubview(confirmButton)
//        confirmButton.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.bottom.equalToSuperview().inset(50)
//        }
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil) // completion으로 로티 실행
    }
}
