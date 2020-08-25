//
//  main.swift
//  TeoriaDaComputacaoTrabalho1
//
//  Created by Joao Batista on 20/08/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

let q1 = State()
let q2 = State()
let q3 = State()
let q4 = State()

q1.setupConfig(isFinish: false, isInitial: true, valueState: ["a": q2, "b": q1], andName: "q1")
q2.setupConfig(isFinish: false, isInitial: false, valueState: ["a": q2, "b": q3], andName: "q2")
q3.setupConfig(isFinish: false, isInitial: false, valueState: ["a": q4, "b": q1], andName: "q3")
q4.setupConfig(isFinish: false, isInitial: false, valueState: ["a": q2, "b": q3], andName: "q4")
let alphabet: Set<Character> = ["a", "b"]
let states: Set<State> = [q1, q2, q3, q4]
let authomato = DFA(alphabet: alphabet, states: states)
let stringTeste = "bababababaabaabababababababababbababababababa"
if (authomato.valid(theString: "bababababaabaabababababababababbababababababa")) {
    print("A sua String \(stringTeste) é aceita pelo authomato")
} else {
     print("A sua String \(stringTeste) não é aceita pelo authomato")
}
