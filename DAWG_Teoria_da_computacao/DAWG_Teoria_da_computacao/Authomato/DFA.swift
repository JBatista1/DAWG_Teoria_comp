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
    private let alphabet: Set<Character>
    private let states: Set<State>
    private var initialState: State!
    private var finalState: [State]!

    init(alphabet: Set<Character>, states: Set<State>) {
        self.alphabet = alphabet
        self.states = states
        setupInitialAndFinalState(withStates: states)
    }

    func valid(theString string: String) -> Bool {
        if transition(withState: initialState, andString: string) != nil {
            return true
        }
        return false
    }

    func transition(withState state: State, andString string: String) -> [String: State]? {
        var result: [String: State]? = [:]
        if string.count == 0 {
            if state.isFinish == true {
                print("String Aceita")
                return result
            } else {
                print("String não aceita")
                return result
            }
        } else {
            let substring = String(string.dropFirst())
            guard let symbol = string.first, let nextState = state.valueState?[symbol]  else {
                 print("Erro no programa. Simbolo não está de acordo com o Alfabeto")
                return nil
            }
            print("Meu simbolo é \(symbol) e vou para \(nextState.name!)")
            result = transition(withState: nextState, andString: substring)
        }
        return result
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
