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
    private var setV: Set<[String: Set<String>]>!
    private var dfa: DFA!
    init(sPlus: Set<String>, sMinus: Set<String>) {
        self.sPlus = sPlus
        self.sMinus = sMinus

    }
    func testePSPlus() {
        alphabet = getAlphabet(inSet: sPlus.union(sMinus))
        pSPlus = createPSPlus(withSet: sPlus)
        setV = createSetV(withPSPlus: pSPlus, andSPlus: sPlus)
        print(setV)

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
    private func createSetV(withPSPlus pSPlus: Set<String>, andSPlus sPlus: Set<String>) -> Set<[String: Set<String>]> {
        var result: Set<[String: Set<String>]> = []
        result.insert([String(Character.epsilon): sPlus])
        for element in pSPlus {
            if element != String(Character.epsilon) {
                result.insert([element: getWMinusOneSPlus(withString: element, inSet: sPlus)])
            }
        }
        return result
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
        for index in 0..<string.count {
            prefix.insert(string[0...index])
        }
        return prefix
    }
    private func getWMinusOneSPlus(withString string: String, inSet set: Set<String>) -> Set<String> {
        var result: Set<String> = []
        let size = string.count
        for element in set {
            if element.count >= size {
                let prefix = element[0..<size]
                if verifyIsEqual(theString: string, andPrefix: prefix) {
                    if verifyInsertEpsilon(theString: string, andElement: element) {
                        result.insert(String(Character.epsilon))
                    } else {
                        result.insert(element[size..<element.count])
                    }


                }
            }

        }

        return result
    }
    private func verifyIsEqual(theString string: String, andPrefix prefix: String) -> Bool {
        return string == prefix
    }
    private func verifyInsertEpsilon(theString string: String, andElement element: String) -> Bool {
        return string == element
    }
}
