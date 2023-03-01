//
//  RootView.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/03/01.
//

import UIKit

class RootView: UIView {
    
    init() {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Shake & Stir"
        
        return label
    }()
    
    var testButton: UIButton = {
        let button = UIButton()
        button.setTitle("테스트버튼 입니다.", for: .normal)
        
        return button
    }()
}
