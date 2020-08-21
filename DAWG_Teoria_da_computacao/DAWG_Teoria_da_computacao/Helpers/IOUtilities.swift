//
//  IOUtilities.swift
//  TeoriaDaComputacaoTrabalho1
//
//  Created by Joao Batista on 20/08/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

class IOUtilities {
    static func inputKeyboard() -> String {
        let keyboard = FileHandle.standardInput
        let inputData =  keyboard.availableData
        if let text = String(data: inputData, encoding: .utf8) {
            return text
        }
        return ""
    }
    static func output(theText text: String) {
        print(text)
    }
}
