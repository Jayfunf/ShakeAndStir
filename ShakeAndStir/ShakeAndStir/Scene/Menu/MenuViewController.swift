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

final class MenuViewController: UIViewController, View, UITableViewDataSource, UITableViewDelegate {
    
    typealias Reactor = MenuViewReactor
    var disposeBag = DisposeBag()
    
    var isManagerMode: Bool = false
    
    var tableView: UITableView!
    
    var cocktailModel: [CocktailModel] = []
    var cocktailHeaders: [String] = []
    
    //MARK: - UI Components
    var makeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
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
        Task {
            do {
                cocktailModel = try await FireStoreManager.shared.loadCockTailList()
                print("CockTailModel", cocktailModel)
                tableView.reloadData()
            } catch {
                print("Cocktail Error")
            }
        }
        
        // Set up table view
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom).offset(20)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    deinit {
        print("Deinit - <MenuViewController>")
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktailModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cocktail = cocktailModel[indexPath.row]
        cocktail.base.forEach {
            if $0 == cocktailHeaders[indexPath.section] {
                cell.textLabel?.text = cocktail.name
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var sections: [String] = []
        cocktailModel.forEach { model in
            model.base.forEach {
                sections.append($0)
            }
        }
        
        let setSections = Set(sections)
        let uniquSections = Array(setSections)
        
        cocktailHeaders = uniquSections.sorted()
        print("UnitSections", cocktailHeaders)
        
        return uniquSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cocktailHeaders[section]
    }
}
