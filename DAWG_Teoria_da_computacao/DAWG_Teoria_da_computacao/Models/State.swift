//
//  State.swift
//  DAWG_Teoria_da_computacao
//
//  Created by Joao Batista on 24/08/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

typealias StateValue = [Character: [State]]

class State {
    var isInitial: Bool!
    var valueState: StateValue?
    var isFinish: Bool!
    var name: String!
    func setupConfig(isFinish: Bool, isInitial: Bool, valueState: StateValue?, andName name: String) {
        self.isFinish = isFinish
        self.valueState = valueState
        self.isInitial = isInitial
        self.name = name
    }
}
// Precisa criar uma comparação customizada para poder realizar as comparações, que usam  Hashable. Como a função: Set.contains"

extension State: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
    static func == (lhs: State, rhs: State) -> Bool {
        return lhs.isInitial == rhs.isInitial && lhs.isFinish == rhs.isFinish && lhs.name == rhs.name
    }
}
