//
//  Exemples.swift
//  DAWG_Teoria_da_computacao
//
//  Created by Joao Batista on 26/08/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

class Exemples {
    static func DFATest(withString string: String) {
        let q1 = State()
        let q2 = State()
        let q3 = State()
        let q4 = State()
        q1.setupConfig(isFinish: false, isInitial: true, valueState: ["a": [q2], "b": [q1]], andName: "q1")
        q2.setupConfig(isFinish: false, isInitial: false, valueState: ["a": [q2], "b": [q3]], andName: "q2")
        q3.setupConfig(isFinish: false, isInitial: false, valueState: ["a": [q4], "b": [q1]], andName: "q3")
        q4.setupConfig(isFinish: true, isInitial: false, valueState: ["a": [q2], "b": [q3]], andName: "q4")
        let alphabet: Set<Character> = ["a", "b"]
        let states: Set<State> = [q1, q2, q3, q4]
        let authomato = DFA(alphabet: alphabet, states: states)
        print("########### - INICIANDO - ########### ")
        if authomato.valid(theString: string) {
            print("########### - Resultado - ########### ")
            print("A sua String \(string) é aceita pelo automato")
            print("#####################################")
        } else {
            print("########### - Resultado - ########### ")
            print("A sua String \(string) não é aceita pelo automato")
            print("#####################################\n")
        }
    }
    static func NFATestWithEpsilon(withString string: String) {
        //(00(0+1)*)
        let epsilon = Character.epsilon
        let q0 = State()
        let q1 = State()
        let q2 = State()
        let q3 = State()
        let q4 = State()
        let q5 = State()
        let q6 = State()
        let q7 = State()
        let q8 = State()
        let q9 = State()
        let q10 = State()

        q0.setupConfig(isFinish: false, isInitial: true, valueState:  ["0": [q1], "1": [], epsilon: []], andName: "q0")
        q1.setupConfig(isFinish: false, isInitial: false, valueState: ["0": [], "1": [], epsilon: [q2]], andName: "q1")
        q2.setupConfig(isFinish: false, isInitial: false, valueState: ["0": [q3], "1": [], epsilon: []], andName: "q2")
        q3.setupConfig(isFinish: false, isInitial: false, valueState: ["0": [], "1": [], epsilon: [q4,q10]], andName: "q3")
        q4.setupConfig(isFinish: false, isInitial: false, valueState: ["0": [], "1": [], epsilon: [q5,q7]], andName: "q4")
        q5.setupConfig(isFinish: false, isInitial: false, valueState: ["0": [q6], "1": [], epsilon: []], andName: "q5")
        q6.setupConfig(isFinish: false, isInitial: false, valueState: ["0": [], "1": [], epsilon: [q9]], andName: "q6")
        q7.setupConfig(isFinish: false, isInitial: false, valueState: ["0": [], "1": [q8], epsilon: []], andName: "q7")
        q8.setupConfig(isFinish: false, isInitial: false, valueState: ["0": [], "1": [], epsilon: [q9]], andName: "q8")
        q9.setupConfig(isFinish: false, isInitial: false, valueState: ["0": [], "1": [], epsilon: [q10, q4]], andName: "q9")
        q10.setupConfig(isFinish: true, isInitial: false, valueState: ["0":[], "1": [], epsilon: []], andName: "q10")


        let alphabet: Set<Character?> = ["0", "1"]
        let states: Set<State> = [q0, q1, q2, q3, q3, q4, q5, q6, q7, q8, q9, q10]
        let authomato = NFA(alphabet: alphabet, states: states)
        print("########### - INICIANDO - ########### ")
        if authomato.valid(theString: string) {
            print("########### - Resultado - ########### ")
            print("A sua String \(string) é aceita pelo automato")
            print("#####################################")
        } else {
            print("########### - Resultado - ########### ")
            print("A sua String \(string) não é aceita pelo automato")
            print("#####################################\n")
        }
    }
    static func NFATest(withString string: String) {
//        ((a+b)*aaa) w| w possui aaa como sufixo
        let q0 = State()
        let q1 = State()
        let q2 = State()
        let q3 = State()

        q0.setupConfig(isFinish: false, isInitial: true, valueState:  ["a": [q0,q1], "b": [q0]], andName: "q0")
        q1.setupConfig(isFinish: false, isInitial: false, valueState: ["a": [q2], "b": []], andName: "q1")
        q2.setupConfig(isFinish: false, isInitial: false, valueState: ["a": [q3], "b": []], andName: "q2")
        q3.setupConfig(isFinish: true, isInitial: false, valueState:  ["a": [], "b": []], andName: "q3")



        let alphabet: Set<Character?> = ["a", "b"]
        let states: Set<State> = [q0, q1, q2, q3, q3]
        let authomato = NFA(alphabet: alphabet, states: states)
        print("########### - INICIANDO - ########### ")
        if authomato.valid(theString: string) {
            print("########### - Resultado - ########### ")
            print("A sua String \(string) é aceita pelo automato")
            print("#####################################")
        } else {
            print("########### - Resultado - ########### ")
            print("A sua String \(string) não é aceita pelo automato")
            print("#####################################\n")
        }
    }
}
