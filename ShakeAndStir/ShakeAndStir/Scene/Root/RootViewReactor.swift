//
//  RootViewReactor.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/02/24.
//

import RxSwift
import ReactorKit

class RootViewReactor: Reactor {
    enum Action {
        case clickToManage
        case clickToStart
    }
    
    enum Mutation {
        case openMainView
        case openManagerView
        case setLoading(Bool)
    }
    
    struct State {
        var isLoading: Bool = false
        var isManagerMode: Bool = false
        var isLoginSuccess: Bool = false
    }

    let initialState: State
    
    init() {
        self.initialState = State(isLoading: false, isManagerMode: false, isLoginSuccess: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        print("CMH :: Mutate")
        switch action {
        case .clickToStart:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.openMainView)
                    .delay(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        case .clickToManage:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.openManagerView)
                    .delay(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        print("CMH :: Reduce")
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case .openManagerView:
            newState.isManagerMode = true
        case .openMainView:
            newState.isLoginSuccess = true
        }
        
        return newState
    }
}
