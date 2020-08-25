//
//  State.swift
//  DAWG_Teoria_da_computacao
//
//  Created by Joao Batista on 24/08/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation
class State {
    var isInitial: Bool!
    var valueState: [Character: State]?
    var isFinish: Bool!
    var name: String!
    func setupConfig(isFinish: Bool, isInitial: Bool, valueState: [Character: State]? , andName name: String) {
        self.isFinish = isFinish
        self.valueState = valueState
        self.isInitial = isInitial
        self.name = name
    }
}
extension State: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
    static func == (lhs: State, rhs: State) -> Bool {
        return lhs.isInitial == rhs.isInitial && lhs.valueState == rhs.valueState && lhs.isFinish == rhs.isFinish
    }
}
