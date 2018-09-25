//
//  ConsoleIO.swift
//  CLIClassifier
//
//  Created by Anthony Da Cruz on 12/07/2018.
//  Copyright © 2018 Anthony Da Cruz. All rights reserved.
//

import Foundation

enum OutputType {
    case error
    case standard
}

class ConsoleIO {
    
    func writeMessage(_ message: String, to output: OutputType = .standard){
        switch output {
        case .error:
            fputs("Error: \(message)", stderr)
        case .standard:
            print(message)
        }
    }
    
    func printUsage() {
        
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        
        writeMessage("usage:")
        writeMessage("\(executableName) -t string")
        writeMessage("or")
        writeMessage("\(executableName) -f filePath to classify")
        writeMessage("or")
        writeMessage("\(executableName) -h to show usage information")
        writeMessage("Type \(executableName) without an option to enter interactive mode.")
    }
}
