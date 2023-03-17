//
//  MenuAddViewController.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/03/17.
//

import UIKit

import SnapKit

class MenuAddViewController: UIViewController {
    
    var cocktailNameLabel: UILabel = {
        let label = UILabel()
        label.text = "칵테일의 이름을 입력해 주세요."
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    var cocktailNameField: UITextField = {
        let field = UITextField()
        field.text = ""
        field.borderStyle = .roundedRect
        field.backgroundColor = .darkGray
        field.autocorrectionType = .no
        
        return field
    }()
    
    var baseNameLabel: UILabel = {
        let label = UILabel()
        label.text = "칵테일의 베이스를 입력해 주세요."
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    var baseNameField: UITextField = {
        let field = UITextField()
        field.text = ""
        field.borderStyle = .roundedRect
        field.backgroundColor = .darkGray
        field.autocorrectionType = .no
        
        return field
    }()
    
    var tasteNameLabel: UILabel = {
        let label = UILabel()
        label.text = "칵테일의 맛을 입력해 주세요."
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    var tasteNameField: UITextField = {
        let field = UITextField()
        field.text = ""
        field.borderStyle = .roundedRect
        field.backgroundColor = .darkGray
        field.autocorrectionType = .no
        
        return field
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "칵테일의 가격을 입력해 주세요."
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    var priceField: UITextField = {
        let field = UITextField()
        field.text = ""
        field.borderStyle = .roundedRect
        field.backgroundColor = .darkGray
        field.autocorrectionType = .no
        
        return field
    }()
    
    var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가해요", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let backButton = UIBarButtonItem(title: "안할래요", style: .plain, target: self, action: #selector(backToMenu))
        navigationItem.leftBarButtonItem = backButton
        
        setupView()
    }
    
    @objc private func backToMenu() {
        dismiss(animated: true)
    }
    
    @objc private func confirmAction() {
        // 모든 필드를 작성 했는지 체크
        guard let cocktailNameField = cocktailNameField.text else { return }
        guard let baseNameField = baseNameField.text else { return }
        guard let tasteNameField = tasteNameField.text else { return }
        guard let priceField = priceField.text else { return }
        if cocktailNameField.isEmpty {
            self.view.showToast(view: self.view, message: "칵테일이름이 입력되지 않았습니다.")
            return
        }
        
        if baseNameField.isEmpty {
            self.view.showToast(view: self.view, message: "베이스가 입력되지 않았습니다.")
            return
        }
        
        if tasteNameField.isEmpty {
            self.view.showToast(view: self.view, message: "맛이 입력되지 않았습니다.")
            return
        }
        
        if priceField.isEmpty {
            self.view.showToast(view: self.view, message: "가격이 입력되지 않았습니다.")
            return
        }
        
        let baseArray = baseNameField.components(separatedBy: ",")
        print("returnArray - ", baseArray)
        let tasteArray = tasteNameField.components(separatedBy: ",")
        print("tasteArray - ", tasteArray)

        do {
            try FireStoreManager.shared.setCocktailData(CocktailModel(name: cocktailNameField, base: baseArray, taste: tasteArray, price: priceField))
        } catch {
            print("Error")
        }
        
        dismiss(animated: true, completion: nil) // completion으로 로티 실행
    }
}

extension MenuAddViewController {
    func setupView() {
        view.addSubview(cocktailNameLabel)
        cocktailNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(cocktailNameField)
        cocktailNameField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(cocktailNameLabel.snp.bottom).offset(15)
        }

        view.addSubview(baseNameLabel)
        baseNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(cocktailNameField.snp.bottom).offset(15)
        }

        view.addSubview(baseNameField)
        baseNameField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(baseNameLabel.snp.bottom).offset(15)
        }

        view.addSubview(tasteNameLabel)
        tasteNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(baseNameField.snp.bottom).offset(15)
        }

        view.addSubview(tasteNameField)
        tasteNameField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(tasteNameLabel.snp.bottom).offset(15)
        }

        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(tasteNameField.snp.bottom).offset(15)
        }

        view.addSubview(priceField)
        priceField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(priceLabel.snp.bottom).offset(15)
        }
        
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(priceField.snp.bottom).offset(25)
        }
    }
}
