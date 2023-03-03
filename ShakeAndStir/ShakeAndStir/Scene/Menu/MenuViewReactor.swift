//
//  MenuViewReactor.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/03/03.
//

import RxSwift
import ReactorKit

final class MenuViewReactor: Reactor {
    enum Action {
        case click
        case click2
    }
    
    enum Mutation {
        case isClicked(Bool)
    }
    
    struct State {
        var isTestValue: Bool = false
    }
    
    let initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .click:
            return Observable.concat([
                Observable.just(Mutation.isClicked(true))
            ])
        case .click2:
            return Observable.concat([
                Observable.just(Mutation.isClicked(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .isClicked(value):
            newState.isTestValue = value
        }
        
        return newState
    }
}
