//
//  DFA.swift
//  TeoriaDaComputacaoTrabalho1
//
//  Created by Joao Batista on 20/08/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

class DFA: AutomatonProtocol {
    //Variaveis globais Necessarias para o automato
    var alphabet: Set<Character?>
    var states: Set<State>
    var initialState: State!
    var finalState: [State]!
    var isAccepted: Bool = false

    required init(alphabet: Set<Character?>, states: Set<State>) {
        self.alphabet = alphabet
        self.states = states
        setupInitialAndFinalState(withStates: states)
    }
    func valid(theString string: String) -> Bool {
        transition(withState: initialState, andString: string)
        if isAccepted {
            return true
        }else {
            return false
        }
    }

    func transition(withState state: State, andString string: String) {
        if string.count == 0 {
            if state.isFinish == true {
                isAccepted = true
            } else {
                isAccepted = false
            }
        } else {
            let substring = String(string.dropFirst())
            guard let symbol = string.first, let nextState = state.valueState?[symbol]?.first else {
                print("Erro no programa. Simbolo não está de acordo com o Alfabeto")
                return
            }
            print("O simbolo é \(symbol) e vai para o estado \(nextState.name!)")
            transition(withState: nextState, andString: substring)
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
