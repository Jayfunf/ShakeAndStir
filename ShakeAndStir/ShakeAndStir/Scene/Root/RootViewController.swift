//
//  RootViewController.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/02/24.
//

import UIKit

import ReactorKit
import RxSwift

class RootViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
//    func bind(reactor: RootViewReactor) {
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
    }
}
