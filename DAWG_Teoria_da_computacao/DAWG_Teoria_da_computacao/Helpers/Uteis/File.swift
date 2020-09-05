//
//  File.swift
//  DAWG_Teoria_da_computacao
//
//  Created by Joao Batista on 04/09/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

class File {
    static let path = "/Users/ItSelf/Documents/Faculdade/Teoria da Computação/DAWG_Teoria_comp/DAWG_Teoria_da_computacao/DAWG_Teoria_da_computacao/Resource/"
    static func readCSVFile(withName fileName: String) -> String {
        //        Bundle.main.path(forResource: fileName, ofType: csv, inDirectory: Files.xcassets")
        let filepath = path+fileName+".csv"

        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return "Arquivo não encontrado"
        }
    }
    static func readFile(withName fileName: String, andFileType fileType: String) -> String {
        let filepath = path+fileName+"."+fileType
        //        guard let path = Bundle.main.path(forResource: fileName, ofType: fileType) else {return ""}
        do {
            let text = try String(contentsOfFile: filepath, encoding: .utf8)
            return text
        } catch {
            print("Arquivo não lozalizado")
            return ""
        }
    }
    static func cleanRows(file: String) -> String {
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
    static func createArray(fromCSV csv: String) -> [[String]] {
        var result: [[String]] = []
        let rows = csv.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ";")
            result.append(columns)
        }
        return result
    }

    static func getSPlusSMinus(fromFileString file: String) -> (sPlus: Set<String>, sMinus: Set<String>) {
        var result: (sPlus: Set<String>, sMinus: Set<String>) = ([], [])
        let formatedString = file.replacingOccurrences(of: "\n", with: "")
        let strings = formatedString.components(separatedBy: "\r")

        // Separar entre S+ e S-
        var sPlus = strings.filter { self.isSPlus(theString: $0) == true }
        var sMinus = strings.filter { self.isSPlus(theString: $0) == false}

        // Remove strings desnecessarias
        sPlus = sPlus.map { $0.replacingOccurrences(of: "\t", with: "0")}.map { $0.replacingOccurrences(of: "+", with: "")}.filter {$0 != ""}
        sMinus = sMinus.map { $0.replacingOccurrences(of: "\t", with: "0")}.filter {$0 != ""}
        result.sPlus = Set(sPlus)
        result.sMinus = Set(sMinus)
        return result
    }
    private static func isSPlus(theString string: String) -> Bool {
        if string.last == "+" {
            return true
        } else {
            return false
        }
    }

}
