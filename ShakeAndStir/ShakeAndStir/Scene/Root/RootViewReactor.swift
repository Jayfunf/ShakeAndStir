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
        case openManagerView(Bool)
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
        switch action {
        case .clickToStart:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.openManagerView(false))
                    .delay(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        case .clickToManage:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.openManagerView(true))
                    .delay(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .openManagerView(isManagerView):
            newState.isManagerMode = isManagerView
        }
        
        return newState
    }
}
