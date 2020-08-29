//
//  ConvertNFAToDFA.swift
//  DAWG_Teoria_da_computacao
//
//  Created by Joao Batista on 27/08/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation
typealias TableConvert = [(name: String, state: StateValue)]
typealias TableHash = [[State]: StateValue]

class ConvertNFAToDFA {
    let nfa: NFA
    var dfa: DFA!
    let hasEpsilon: Bool
    var numberState = 0
    let preFixState = "q"
    var table: TableConvert = []
    var tableHash: TableHash = [:]
    var lastState: StateValue!
    init(nfa: NFA, existEpsilonTransition hasEpsilon: Bool) {
        self.nfa = nfa
        self.hasEpsilon = hasEpsilon
        createHashTable()
        convert()
        print(table)
//        printTable()
    }
    func printTable() {
        for element in tableHash {
            print(element)
        }
    }
    func convert() {
        guard let initial = nfa.initialState, let valueState = initial.valueState else {
            print("Não existe um estado inicial ou não vai a lugar nenhum")
            return
        }
        table.append(("\(preFixState)\(numberState)", valueState))
        nextStep()
        
    }
    func nextStep() {
        for _ in table {
            let temState = lastState
            newValueState(withNumber: numberState)

            if temState != lastState {
                numberState += 1
                table.append(("\(preFixState)\(numberState)", lastState))
            }

        }
    }
    func newValueState(withNumber index: Int){
        for symbol in nfa.alphabet {
            let states = table[index].state[symbol!]!
            if !existInTable(theStateArray: states) {
                lastState = getUnionStates(withStates: states)
                tableHash[states] = lastState
            }
        }

    }

    func getUnionStates(withStates states:[State]) -> StateValue {
        var valueStates: StateValue = [:]
        for symbol in nfa.alphabet {
            var tempState: [State] = []
            for state in states {
                tempState.append(state)
            }
            valueStates[symbol!] = tempState
        }
        return valueStates
    }
    func createHashTable() {
        for state in nfa.states {
            tableHash[[state]] = state.valueState
        }
    }
    func existInTable(theStateArray states:[State]) -> Bool { tableHash.keys.contains(states) }

    func getStatesInHashTable(withKey key: [State]) -> StateValue? { tableHash[key]! }

    func transition(state: State, andSymbol symbol: Character) -> [State]? {
        guard let value = state.valueState?[symbol] else { return nil}
        return value
    }
}

//func convert(initialState: State) {
//    for symbol in nfa.alphabet {
//        let states = initialState.valueState![symbol!]!
//        tableResult.append(states)
//    }
//    viewValue.append([initialState])
//
//}
//func run(){
//    for states in tableResult {
//        nextStage(states: states)
//    }
//}
//func union(theStates states: [State]) {
//    for symbol in nfa.alphabet {
//        var unio: [State] = []
//        for state in states {
//            unio.append(contentsOf: (state.valueState?[symbol!])!)
//        }
//        tableResult.append(unio)
//        viewValue.append(states)
//    }
//}
//func nextStage(states:[State]) {
//    if containsInTableResult(theStates: states){
//        return
//    }
//    for symbol in nfa.alphabet {
//        for state in states {
//            union(theStates: state.valueState![symbol!]!)
//        }
//    }
//    viewValue.append(states)
//}

//func containsInTableResult(theStates state: [State]) -> Bool { viewValue.contains(state)}
