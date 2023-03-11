//
//  RegisterViewController.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/03/03.
//

import UIKit

import SnapKit
import Lottie

class RegisterViewController: UIViewController {
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름을 입력해 주세요."
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    var nameField: UITextField = {
        let field = UITextField()
        field.text = ""
        field.borderStyle = .roundedRect
        field.backgroundColor = .darkGray
        field.autocorrectionType = .no
        
        return field
    }()
    
    var flavorLabel: UILabel = {
        let label = UILabel()
        label.text = "선호하는 맛을 선택해 주세요."
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    var menuButton: UIButton = {
        let button = UIButton()
        button.setTitle("여기를 클릭해서 선택해주세요", for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(showFlavorMenu), for: .touchUpInside)
        return button
    }()
    
    var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("  가입해요  ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        let backButton = UIBarButtonItem(title: "안할래요", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        setupView()
    }
    
    func setupView() {
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.left.equalToSuperview().inset(15)
        }
        
        view.addSubview(nameField)
        nameField.snp.makeConstraints {
            $0.left.equalTo(nameLabel.snp.left)
            $0.top.equalTo(nameLabel.snp.bottom)
        }
        
        view.addSubview(flavorLabel)
        flavorLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(15)
            $0.top.equalTo(nameField.snp.bottom).offset(15)
        }
        
        view.addSubview(menuButton)
        menuButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(15)
            $0.top.equalTo(flavorLabel.snp.bottom)
        }
        
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(menuButton.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil) // completion으로 로티 실행
    }
    
    @objc private func confirmButtonTapped() {
        // 모든 필드를 작성 했는지 체크
        guard let fieldText = nameField.text else { return }
        if fieldText.isEmpty {
            self.view.showToast(view: self.view, message: "이름을 입력하세요.")
            return
        }
        
        nameField.resignFirstResponder() // 가입해오 버튼 클릭 시 자동으로 키보드 내려감
        
        let wineLottieView: LottieAnimationView = .init(name: "wine_lottie")
        wineLottieView.loopMode = .playOnce
        do {
            try FireStoreManager.shared.setUserData(UserModel(name: fieldText, preferFlavor: ["신맛", "단맛"]))
            view.addSubview(wineLottieView)
            wineLottieView.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview().offset(-50)
                $0.width.height.equalTo(300)
            }
            wineLottieView.play()
        } catch {
            print("Error")
        }
        
        // wine_lottie 애니메이션이 종료되면 화면을 닫음
        wineLottieView.play { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    // @objc 함수에서는 enum을 파라미터로 받을 수 없음.
    @objc private func showFlavorMenu() {
        let flavor = "sour"
        var taste: String = ""
        switch flavor {
        case "sour":
            taste = "신맛"
        case "bitter":
            taste = "쓴맛"
        case "sweet":
            taste = "단맛"
        default:
            taste = "오류맛"
        }
        
        let menu = UIMenu(title: "선호하는 맛을 골라주세요.", children: [
            UIAction(title: "매우 \(taste)", handler: { _ in
                print("매우 \(taste)")
            }),
            UIAction(title: "보통 \(taste)", handler: { _ in
                print("보통 \(taste)")
            }),
            UIAction(title: "약간 \(taste)", handler: { _ in
                print("약간 \(taste)")
            }),
            UIAction(title: "\(taste) 없음", handler: { _ in
                print("없음 \(taste)")
            })
        ])
        
        menuButton.menu = menu
    }
}
