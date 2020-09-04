//
//  NFA.swift
//  DAWG_Teoria_da_computacao
//
//  Created by Joao Batista on 25/08/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

class NFA: AutomatonProtocol {

    var alphabet: Set<Character?> = []
    var states: Set<State>
    var initialState: State!
    var finalState: [State]!
    var allResults: [Bool] = []
    required init(alphabet: Set<Character?>, states: Set<State>) {
        self.alphabet = alphabet
        self.states = states
        setupInitialAndFinalState(withStates: states)
    }
    func valid(theString string: String) -> Bool {
        transition(withState: initialState, andString: string)
        if allResults.count != 0 {
            return true
        }
        return false

    }
    func transition(withState state: State, andString string: String) {
        if string.count == 0 {
            recursiveTransitions(state: state, andSubstring: string, withSymbol: Character.epsilon)
            if state.isFinish {
                unionResults(isFinishResult: true)
            }
        } else {
            let substring = String(string.dropFirst())
            if let symbol = getSymbol(theString: string) {
                recursiveTransitions(state: state, andSubstring: substring, withSymbol: symbol)
                recursiveTransitions(state: state, andSubstring: string, withSymbol: Character.epsilon)
            }
        }
    }

    func unionResults(isFinishResult isfinish: Bool ) {
        allResults.append(isfinish)
    }

    private func recursiveTransitions(state: State, andSubstring substring: String, withSymbol symbol: Character) {
        if let nextState = state.valueState?[symbol] {
            if nextState.count != 0 {
                for index in 0..<nextState.count {
                    print("O simbolo é \(symbol) e vai para o estado \(nextState[index].name!)")
                    transition(withState: nextState[index], andString: substring)
                }
            }
        }
    }

    private func setupInitialAndFinalState(withStates states: Set<State> ) {
        guard let initial = getInitialState(inStates: states) else {
            print("Numero de estagios iniciais inválido. Sendo zero ou mais que 1")
            exit(0)
        }

        guard let final = getFinalState(inStates: states) else {
            print("Numero de estagios finais inválido. Deve haver ao menos 1 estado final")
            exit(0)
        }

        self.initialState = initial
        self.finalState = final
    }

}
