//
//  Convert.swift
//  DAWG_Teoria_da_computacao
//
//  Created by Joao Batista on 28/08/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

class Convert {
    let nfa: NFA
    var dfa: DFA!
    var viewValue: Set<[State]> = []
    var stateTemp: [StateTemp] = []
    var newNameStates: [[State]: State] = [:]

    var next = 0
    init(nfa: NFA) {
        self.nfa = nfa
        convert(initialState: [nfa.initialState])
    }
    func convert(initialState: [State]) {
        var statesValues: [StateValue] = []
        viewValue.insert(sortArray(ofStates: initialState))
        for symbol in nfa.alphabet {
            for states in initialState {
                let statesAuthomatos = states.valueState![symbol!]!

                statesValues.append([symbol!: sortArray(ofStates: statesAuthomatos)])
            }
        }
        stateTemp.append(StateTemp(nameState: initialState, value: statesValues, isInitial: true, isFinish: verifyExistFinish(inStates: initialState)))
        nextStep(value: next)
    }

    func createDFA() -> DFA  {
        let states = createArrayStatesTheDFA()
        createTableConvertNames(states: states)
        var stateAtual = 0
        for state in stateTemp {
            let stateValue = getStateValue(withSteteTemp: stateTemp[stateAtual])
            states[stateAtual].setupConfig(isFinish: state.isFinish, isInitial: state.isInitial, valueState: stateValue, andName: String(stateAtual))
            stateAtual += 1
        }
        dfa = DFA(alphabet: nfa.alphabet, states: createSet(withStates: states))
        return dfa
    }

    func convertRecursive(states: [State]) {
        var statesValues: [StateValue] = []
        viewValue.insert(states)

        for symbol in nfa.alphabet {
            var temValues: [State] = []
            for state in states {
                temValues.append(contentsOf: state.valueState![symbol!]!)
            }
            statesValues.append([symbol!: temValues.uniques])
        }
        stateTemp.append(StateTemp(nameState: states, value: statesValues, isInitial: false, isFinish: verifyExistFinish(inStates: states)))
        nextStep(value: next+1)
    }

    func nextStep(value: Int) {
        var positionAlphabet = 0
        for symbol in nfa.alphabet {
            let statesInAlphabet = stateTemp[value].values[positionAlphabet][symbol!]!
            if !verifyIf(theStatesInInsert: statesInAlphabet) {
                convertRecursive(states: statesInAlphabet)
            }
            positionAlphabet += 1
        }
    }

    private func verifyIf(theStatesInInsert states: [State]) -> Bool { viewValue.contains(states) }

    private func verifyExistFinish(inStates states: [State]) -> Bool {
        for state in states {
            if state.isFinish {
                return true
            }
        }
        return false
    }
    private func sortArray(ofStates states: [State]) -> [State] {
        return states.sorted( by: { $0.name < $1.name})
    }

    private func createSet(withStates states: [State]) -> Set<State> {
        var set: Set<State> = []
        for state in states {
            set.insert(state)
        }
        return set
    }

    private func getStateValue(withSteteTemp stateTemp: StateTemp) -> StateValue {
        var stateValue: StateValue = [:]
        for index in 0..<nfa.alphabet.count{
            for value in stateTemp.values[index] {
                let test = newNameStates[value.value]
                stateValue[value.key] = [test!]
            }
        }
        return stateValue
    }
    private func createArrayStatesTheDFA() -> [State] {
        var states: [State] = []
        var name = 0
        for _ in 0..<stateTemp.count {
            let state = State()
            states.append(state)
            state.name = String(name)
            name += 1
        }
        return states
    }

    private func createTableConvertNames(states:[State]) {
        var index = 0
        for state in stateTemp {
            newNameStates[state.nameState] = states[index]
            index += 1
        }
    }

}
