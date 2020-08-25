//
//  AutomatonProtocol.swift
//  DAWG_Teoria_da_computacao
//
//  Created by Joao Batista on 24/08/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

protocol AutomatonProtocol {
    func getInitialState(inStates states: Set<State>) -> State?
    func getFinalState(inStates states: Set<State>) -> [State]?
    func transition(withState state: State, andString string: String) -> [String: State]?
}
extension AutomatonProtocol {
    func getInitialState(inStates states: Set<State>) -> State? {
        let initialState = states.filter {$0.isInitial == true}
        if initialState.count > 1  || initialState.count == 0 {
            return nil
        } else {
            return initialState.first!
        }
    }
    func getFinalState(inStates states: Set<State>) -> [State]? {
        let finalState = Array(states.filter {$0.isFinish == true})
        if  finalState.count == 0 {
            return nil
        } else {
            return finalState
        }
    }
}
