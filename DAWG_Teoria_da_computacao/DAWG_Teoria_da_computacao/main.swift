//
//  main.swift
//  TeoriaDaComputacaoTrabalho1
//
//  Created by Joao Batista on 20/08/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

//if let response = readLine() {
let response = IOUtilities.inputKeyboard()
let dfa = DFA(name: response)
dfa.printName()
print("teste")
//}
