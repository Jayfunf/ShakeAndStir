//
//  MenuViewController.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/03/03.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit

final class MenuViewController: UIViewController, View {
    
    
    typealias Reactor = MenuViewReactor
    var disposeBag = DisposeBag()
    
    var isManagerMode: Bool = false
    
//MARK: - UI Components
    var makeLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Label"
        label.textColor = .white
        return label
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.setTitle("토스트 테스트 버튼", for: .normal)
        button.addTarget(self, action: #selector(testbutton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupView()
        self.reactor = MenuViewReactor()
        
        print("CMh :: isManagerMode -", isManagerMode)
    }
    
    func bind(reactor: MenuViewReactor) {
        reactor.state
            .map { String($0.isTestValue )}
            .distinctUntilChanged()
            .bind(to: makeLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setupView() {
        view.addSubview(makeLabel)
        makeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.equalTo(makeLabel).offset(50)
        }
    }
    
    @objc func testbutton() {
        dismiss(animated: true, completion: nil) // completion으로 로티 실행
    }
}
