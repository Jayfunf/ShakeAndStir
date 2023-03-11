//
//  SettingViewController.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/03/03.
//

import UIKit

import SnapKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    
    var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "환영합니다. 도지짐씨"
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
        return button
    }()
    
    var managerModeSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = GlobalManager.shared.managerMode
        toggle.addTarget(self, action: #selector(toggleMode), for: .touchUpInside)
        
        return toggle
    }()
    
    var managerModeSwitchLabel: UILabel = {
        let label = UILabel()
        label.text = "관리자 모드"
        label.textColor = .white
        return label
    }()
    
    var managerModeIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "wrench")
        view.tintColor = .white
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        tableView = UITableView(frame: view.frame, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        
        setupView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 셀의 인덱스: \(indexPath.row)")
        
        // 선택된 셀에 대한 동작 수행
        switch indexPath.row {
//        case 0:
//            print("1")
//            break
        case 1:
            print("1")
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1 // 관리자 모드 cell
        } else if section == 1 {
            return 2 // 히스토리 보기, 유저 보기 cell
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            cell.contentView.addSubview(managerModeIcon)
            managerModeIcon.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(20)
                $0.centerY.equalToSuperview()
            }

            cell.contentView.addSubview(managerModeSwitchLabel)
            managerModeSwitchLabel.snp.makeConstraints {
                $0.leading.equalTo(managerModeIcon.snp.trailing).offset(10)
                $0.centerY.equalToSuperview()
            }
            
            cell.contentView.addSubview(managerModeSwitch)
            managerModeSwitch.snp.makeConstraints {
                $0.trailing.equalToSuperview().offset(-20)
                $0.centerY.equalToSuperview()
            }
            
            return cell
        } else {
            // 히스토리 보기, 유저 보기 cell
            let cell = UITableViewCell(style: .default, reuseIdentifier: "historyCell")
            if indexPath.row == 0 {
                cell.textLabel?.text = "히스토리 보기"
                cell.textLabel?.textColor = .systemBlue
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "유저 보기"
                cell.textLabel?.textColor = .systemGreen
            }
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // 섹션 2개
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? nil : "기록" // 섹션 1에만 "기록"이라는 헤더 추가
    }
    
    @objc private func backToMenu() {
        dismiss(animated: true)
    }
    
    @objc private func toggleMode() {
        GlobalManager.shared.toggleManagerMode()
    }
}

extension SettingViewController {
    private func setupView() {
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalTo(welcomeLabel)
        }
        
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(15)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
