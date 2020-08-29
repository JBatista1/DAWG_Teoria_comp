//
//  StateTemp.swift
//  DAWG_Teoria_da_computacao
//
//  Created by Joao Batista on 29/08/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

class StateTemp {
    let nameState: [State]
    let values: [StateValue]
    let isInitial: Bool
    let isFinish: Bool
    
    init(nameState: [State], value: [StateValue], isInitial: Bool, isFinish: Bool) {
        self.nameState = nameState
        self.values = value
        self.isFinish = isFinish
        self.isInitial = isInitial
    }
    
}
