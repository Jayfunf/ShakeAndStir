//
//  RootViewController.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/02/24.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit

final class RootViewController: UIViewController, View {
    
    typealias Reactor = RootViewReactor
    var disposeBag = DisposeBag()
    
//MARK: - UI Components
    var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Gettin Start!", for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var managerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go To ManagerMode", for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var registerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(openRegisterView), for: .touchUpInside)
        return button
    }()
    
    var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    var testLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트"
        label.textColor = .white
        return label
    }()
    
    var settingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "wrench"), for: .normal)
        button.addTarget(self, action: #selector(openSettingView), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupView()
        self.reactor = RootViewReactor()
    }

    func bind(reactor: RootViewReactor) {
        loginButton.rx.tap
            .map { Reactor.Action.clickToStart }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        managerButton.rx.tap
            .map { Reactor.Action.clickToManage }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
//        reactor.state
//            .map { $0.isLoginSuccess }
//            .distinctUntilChanged()
//            .subscribe(onNext: { [weak self] isLoginSuccess in
//                if isLoginSuccess {
//                    self?.openMenuView(isManagerMode: false)
//                }
//            })
//            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isManagerMode }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] state in
                print("CMH :: state - ", state)
                self?.openMenuView(isManagerMode: state)
            })
        
        reactor.state
            .map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: indicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
//MARK: - Private Functions
    private func openMenuView(isManagerMode: Bool) {
        let vc = MenuViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.isManagerMode = isManagerMode
        
        self.present(vc, animated: true)
    }
    
//MARK: - Objective Functions
    @objc private func openRegisterView() {
        let vc = RegisterViewController()
        vc.navigationItem.title = "Register"
        
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true)
    }
    
    @objc private func openSettingView() {
        let vc = SettingViewController()
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
    }
}

extension RootViewController {
    func setupView() {
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        view.addSubview(managerButton)
        managerButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(loginButton.snp.centerY).offset(40)
        }
        
        view.addSubview(testLabel)
        testLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(loginButton.snp.centerY).offset(-50)
        }
        
        view.addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(testLabel.snp.top).offset(-20)
        }
        
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(50)
        }
        
        view.addSubview(settingButton)
        settingButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide )
            $0.top.equalTo(view.safeAreaLayoutGuide )
        }
    }
}
