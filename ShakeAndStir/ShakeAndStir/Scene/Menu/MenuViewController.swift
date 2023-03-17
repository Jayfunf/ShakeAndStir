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
    var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
        return button
    }()
    
    var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addNewMenu), for: .touchUpInside)
        return button
    }()
    
    var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(deleteMenu), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
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
        
        setupView()
        checkManagerMode()
    }
    
    deinit {
        print("Deinit - <MenuViewController>")
    }
    
//MARK: - Functions
    func bind(reactor: MenuViewReactor) {
//        reactor.state
//            .map { String($0.isTestValue )}
//            .distinctUntilChanged()
//            .bind(to: makeLabel.rx.text)
//            .disposed(by: disposeBag)
    }
    
    func setupView() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(15)
            $0.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(plusButton)
        plusButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(deleteButton)
        deleteButton.snp.makeConstraints {
            $0.trailing.equalTo(plusButton.snp.leading).offset(-20)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func checkManagerMode() {
        if !GlobalManager.shared.managerMode {
            plusButton.isHidden = true
            plusButton.isEnabled = false
            deleteButton.isHidden = true
            deleteButton.isEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let base = cocktailHeaders[section]
        return cocktailModel.filter { $0.base.first == base }.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let base = cocktailHeaders[indexPath.section]
        let filteredCocktails = cocktailModel.filter { $0.base.first == base }
        let cocktail = filteredCocktails[indexPath.row]
        cell.textLabel?.text = cocktail.name
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
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return cocktailHeaders.count
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cocktailHeaders[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath - ", indexPath.section)
    }
    

    
//MARK: - Objc Functions
    @objc private func backToMenu() {
        dismiss(animated: true)
    }
    
    @objc private func addNewMenu() {
        
        let vc = MenuAddViewController()
        vc.navigationItem.title = "메뉴 추가"
        
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true)
    }
    
    @objc private func deleteMenu() {
        view.showToast(view: self.view, message: "삭제테스트")
    }
}
