//
//  DAWG.swift
//  DAWG_Teoria_da_computacao
//
//  Created by Joao Batista on 29/08/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

class DAWG {
    // MARK: - Variables Global
    private var sPlus: Set<String>
    private var sMinus: Set<String>
    private var pSPlus: Set<String>!
    private var alphabet: Set<Character>!
    private var setV: Set<[String: Set<String>]>!
    private var states: [State] = []
    private var gSPlus: NFA!
    
    init(sPlus: Set<String>, sMinus: Set<String>) {
        self.sPlus = sPlus
        self.sMinus = sMinus
    }
    func getGSPlus() -> NFA {
        alphabet = getAlphabet(inSet: sPlus.union(sMinus))
        pSPlus = createPSPlus(withSet: sPlus)
        setV = createSetV(withPSPlus: pSPlus, andSPlus: sPlus)
        let arrayStates = getStates(usingTheSet: setV)
        states = createStatesGeneric(withSize: arrayStates.count)
        let nextRoute = createDicNextRoute(usingSet: setV)
        createStatesAuthomato(withArrayStates: arrayStates, theSetDic: setV, theDicChar: nextRoute)
        gSPlus = NFA(alphabet: alphabet, states: convertArrayInSet(usingArray: states))
        return gSPlus
    }
    
    // MARK: - Create values
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
    private func createStatesGeneric(withSize size: Int) -> [State] {
        var result: [State] = []
        for index in 0..<size {
            let state = State()
            state.name = "\(index)"
            result.append(state)
        }
        return result
    }
    
    private func createDicNextRoute(usingSet set: Set<[String: Set<String>]>) -> [Set<String>: Set<Character>] {
        var result: [Set<String>: Set<Character>] = [:]
        for element in set {
            for value in element {
                result[value.value] = getValuesAcceptedByState(withSet: value.value)
            }
        }
        return result
    }
    private func createStatesAuthomato(withArrayStates arraySet: [Set<String>], theSetDic setDic: Set<[String: Set<String>]>, theDicChar dicChar: [Set<String>: Set<Character>]) {
        var index = 0
        for element in arraySet {
            var stateValue: StateValue = [:]
            let chars = getValuesAcceptedByState(withSet: element)
            for char in chars {
                let nextSatete = getNextSetState(withChar: char, usignTheSet: element)
                var localState: [State] = []
                for state in nextSatete {
                    localState.append(getState(usignSet: state, andArraySet: arraySet))
                }
                stateValue[char] = localState
            }
            if element == sPlus {
                states[index].setupConfig(isFinish: false, isInitial: true, valueState: stateValue, andName: "\(element)")
            } else if stateValue.keys.first! == Character.epsilon && stateValue.keys.count == 1 {
                // Coloquei o value State igual a vazio pois iria ficar em recursão infinita.
                states[index].setupConfig(isFinish: true, isInitial: false, valueState: [Character.epsilon: []], andName: "\(element)")
            } else {
                states[index].setupConfig(isFinish: false, isInitial: false, valueState: stateValue, andName: "\(element)")
            }
            index += 1
        }
        print(states)
    }
    
    // MARK: - Validations
    private func verifyIsEqual(theString string: String, andPrefix prefix: String) -> Bool {
        return string == prefix
    }
    private func verifyInsertEpsilon(theString string: String, andElement element: String) -> Bool {
        return string == element
    }
    
    // MARK: - GET ans generate values
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
    private func getStates(usingTheSet set: Set<[String: Set<String>]>) -> [Set<String>] {
        var states: [Set<String>] = []
        for element in set {
            for value in element {
                if !states.contains(value.value) {
                    if value.value == sPlus {
                        states.append(value.value)
                    } else {
                        for elementSet in value.value {
                            states.append([elementSet])
                        }
                    }
                }

            }
        }
        return removeEpsilon(inArray: states.uniques)
    }
    
    private func getValuesAcceptedByState(withSet set: Set<String>) -> Set<Character> {
        var resul: Set<Character> = []
        for element in set {
            if let char = element.first {
                resul.insert(char)
            }
        }
        return resul
    }
    private func getNextSetState(withChar char: Character, usignTheSet set: Set<String>) -> [Set<String>] {
        var resul: [Set<String>] = []
        for element in set {
            if element.first == char {
                var customSet: Set<String> = []
                if element.count == 1 {
                    customSet.insert(String(Character.epsilon))
                } else {
                    customSet = [element[1..<element.count]]
                }
                resul.append(customSet)
            }
        }
        return resul
    }
    private func getState(usignSet set: Set<String>, andArraySet array: [Set<String>]) -> State {
        var result: State!
        for index in 0..<array.count where set == array[index] {
            result = states[index]
        }
        return result
    }
    private func getPosition(usignSet set: Set<String>, andArraySet array: [Set<String>]) -> Int {
        var result = Int()
        for index in 0..<array.count where set == array[index] {
            result = index
        }
        return result
    }
    // MARK: - Auxiliary Functions
    private func removeEpsilon(inArray array: [Set<String>]) -> [Set<String>] {
        var result: [Set<String>] = []
        for element in array {
            var newElement: Set<String> = []
            if element.count > 1 {
                for value in element {
                    if value != String(Character.epsilon) {
                        newElement.insert(value)
                    }
                }
            } else {
                newElement = element
            }
            result.append(newElement)
        }
        return result
    }
    private func convertArrayInSet(usingArray array: [State]) -> Set<State> {
        var resul: Set<State> = []
        for element in array {
            resul.insert(element)
        }
        return resul
    }
}
