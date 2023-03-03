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
    
//MARK: - UI Components
    var makeLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Label"
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupView()
        self.reactor = MenuViewReactor()
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
    }
}
