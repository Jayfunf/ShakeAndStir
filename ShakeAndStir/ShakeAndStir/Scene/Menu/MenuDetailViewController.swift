//
//  MenuDetailViewController.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/03/13.
//

import UIKit

class MenuDetailViewController: UIViewController {
    
    var cocktail: CocktailModel = CocktailModel(name: "", base: [""], taste: [""], price: "")
    
    var constraintsValue: Int = 40
    
    var buyer: String = ""
    
    var testArray: [String] = []
    
    var testValue: Int = 0
    
    init(cocktail: CocktailModel) {
        self.cocktail = cocktail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let backButton = UIBarButtonItem(title: "안할래요", style: .plain, target: self, action: #selector(backToMenu))
        navigationItem.leftBarButtonItem = backButton
        
        // View 구성 코드 작성
        let nameLabel = UILabel()
        nameLabel.text = cocktail.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }
        
        let baseLabel = UILabel()
        baseLabel.text = "Base: \(cocktail.base.joined(separator: ", "))"
        baseLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(baseLabel)
        baseLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
        
        let tasteLabel = UILabel()
        tasteLabel.text = "Taste: \(cocktail.taste.joined(separator: ", "))"
        tasteLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(tasteLabel)
        tasteLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(baseLabel.snp.bottom).offset(10)
        }
        
        let priceLabel = UILabel()
        priceLabel.text = "Price: \(cocktail.price)"
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(tasteLabel.snp.bottom).offset(10)
        }
        
        GlobalManager.shared.registedUsers.forEach {
            let button = UIButton()
            button.setTitle($0.name, for: .normal)
            button.addTarget(self, action: #selector(buyingAction), for: .touchUpInside)
            button.tag = testValue
            testArray.append($0.name)
            view.addSubview(button)
            button.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(priceLabel.snp.bottom).offset(constraintsValue)
            }
            constraintsValue += 40
            testValue += 1
        }
    }
    
    func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let now = Date()
        let dateString = dateFormatter.string(from: now)
        return dateString
    }
    
    @objc private func backToMenu() {
        dismiss(animated: true)
    }
    
    @objc private func buyingAction(_ sender: UIButton) {
        do {
            try FireStoreManager.shared.setHistory(time: getCurrentTime(), model: HistoryModel(userName: testArray[sender.tag], cocktailName: cocktail.name))
        } catch {
            print("Error")
        }
    }
    
}
