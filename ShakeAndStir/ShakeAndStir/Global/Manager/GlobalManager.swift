//
//  GlobalManager.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/03/11.
//

import Foundation

class GlobalManager {
    public static var shared = GlobalManager()
    var managerMode: Bool = false
    
    public func toggleManagerMode() {
        print("Current ManagerMode1", managerMode)
        var state = self.managerMode
        state.toggle()
        self.managerMode = state
        print("Current ManagerMode2", managerMode)
    }
}
