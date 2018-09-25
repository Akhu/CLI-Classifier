//
//  Classifier.swift
//  CLIClassifier
//
//  Created by Anthony Da Cruz on 17/07/2018.
//  Copyright © 2018 Anthony Da Cruz. All rights reserved.
//

import Foundation
import CoreML


enum OptionType: String {
    case text = "t"
    case file = "f"
    case help = "h"
    case unknown
    
    init(value: String){
        switch value {
        case "t": self = .text
        case "f": self = .file
        case "h": self = .help
        default: self = .unknown
        }
    }
}

class Classifier {
    
    lazy var model = henri()
    
    func staticMode() {
        let argCount = CommandLine.argc
        let argument = CommandLine.arguments[1]
        
        let (option, value) = getOption(argument.substring(from: argument.index(argument.startIndex, offsetBy: 1)))
        
        print(option)
        console.writeMessage("Argument count : \(argCount) Option: \(option) value: \(CommandLine.arguments[2])")
       
        switch option {
        case .text:
                classifyText(text: CommandLine.arguments[2])
            break
        case .file:
            
            break
        default:
            console.writeMessage("not implemented yet")
        }

    }
    
    func getOption(_ option: String) -> (option: OptionType, value: String) {
        return (OptionType(value: option), option)
    }

    func classifyFile(path: String){
        let urlPath = URL(fileURLWithPath: path)
    }
    
    func classifyText(text: String){
        do {
            let output = try self.model.prediction(text: "MORBIER SELECTION JURA".lowercased())
            console.writeMessage("\(output.label)")
        } catch (let exception as NSException) {
            console.writeMessage(exception.description, to: .error)
        } catch {
            console.writeMessage("Unhandled error", to: .error)
        }
    }
}
