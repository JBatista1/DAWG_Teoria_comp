//
//  DAWG.swift
//  DAWG_Teoria_da_computacao
//
//  Created by Joao Batista on 29/08/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

class DAWG {
    private var sPlus: Set<String>
    private var sMinus: Set<String>
    private var pSPlus: Set<String>!
    private var alphabet: Set<Character>!
    private var dfa: DFA!
    init(sPlus: Set<String>, sMinus: Set<String>) {
        self.sPlus = sPlus
        self.sMinus = sMinus

    }
    func testePSPlus() {
        alphabet = getAlphabet(inSet: sPlus.union(sMinus))
        pSPlus = createPSPlus(withSet: sPlus)

        print(alphabet)
        print(pSPlus!)
    }
    private func createDFA() -> DFA {

        return dfa
    }
    private func createPSPlus(withSet set: Set<String>) -> Set<String> {
        var setPrefix: Set<String> = [String(Character.epsilon)]
        for string in set {
            setPrefix = setPrefix.union(getPrefix(withString: string))
        }
        return setPrefix
    }
    private func getAlphabet(inSet set: Set<String>) -> Set<Character> {
        var alphabet: Set<Character> = [Character.epsilon]
        for string in set {
            alphabet = alphabet.union(getChars(inString: string))
        }
        return alphabet
    }
    private func getChars(inString string: String) -> Set<Character> {
        var characters: Set<Character> = []
        var substring = string
        for _ in 0..<string.count - 1 {
            characters.insert(substring.first!)
            substring = String(substring.dropFirst())
        }
        return characters
    }
    private func getPrefix(withString string: String) -> Set<String> {
        var prefix: Set<String> = []
        for index in 0..<string.count - 1 {
            prefix.insert(string[0...index])
        }
        return prefix
    }
}
