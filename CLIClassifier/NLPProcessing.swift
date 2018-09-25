//
//  NLPProcessing.swift
//  CLIClassifier
//
//  Created by Anthony Da Cruz on 18/09/2018.
//  Copyright © 2018 Anthony Da Cruz. All rights reserved.
//

import Foundation
import NaturalLanguage

class NLPProcessing {
    
    
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
    
    func staticMode() {
        let argCount = CommandLine.argc
        let argument = CommandLine.arguments[1]
        
        let (option, value) = getOption(argument.substring(from: argument.index(argument.startIndex, offsetBy: 1)))
        
        print(option)
        console.writeMessage("Argument count : \(argCount) Option: \(option) value: \(CommandLine.arguments[2])")
        
        switch option {
        case .text:
            processText(text: CommandLine.arguments[2])
            break
        case .file:
            processFile(path: CommandLine.arguments[2])
            break
        default:
            console.writeMessage("not implemented yet")
        }
        
    }
    
    func getOption(_ option: String) -> (option: OptionType, value: String) {
        return (OptionType(value: option), option)
    }
    
    func processFile(path: String){
        let urlPath = URL(fileURLWithPath: path)
        
        //reading
        do {
            let data = try String(contentsOf: urlPath, encoding: .utf8)
            let lines = data.components(separatedBy: .newlines)
            for line in lines {
                print("--------------\n For line \(line) \n")
                stringAnalysis(text: line)
            }
        }
        catch {/* error handling here */}
    
    }
    
    func processText(text: String){
        do {
            stringAnalysis(text: text)
        } catch (let exception as NSException) {
            console.writeMessage(exception.description, to: .error)
        } catch {
            console.writeMessage("Unhandled error", to: .error)
        }
    }
    
    func stringAnalysis(text: String){
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(text)
        console.writeMessage("Language hypothesis : \(recognizer.dominantLanguage?.rawValue)")
        self.tagger(text: text)
    }
    
    func tagger(text: String) {
        // In this example, we'll use `[.nameType]` as `tagSchemes` to create a `tagger` of Named Entities.
        
        let tagger = NSLinguisticTagger(tagSchemes: [.language, .lemma, .nameTypeOrLexicalClass], options: 0)
        
        // The tagger can omit whitespaces and punctuation. Also, it can return names as a single token.
        let options: NSLinguisticTagger.Options = [.omitWhitespace, .omitPunctuation, .joinNames]
        
        // Set the string the tagger will tag.
        tagger.string = text
        
        // Set the linguistic tags to extract person, place and organization names.
        let tags: [NSLinguisticTag] = [.word, .adjective, .noun, .determiner, .number, .other]
       
        // Range of the string the tagger will look upon.
        let range = NSRange(location: 0, length: text.utf16.count)
    
        // Call `enumerateTags(in:unit:scheme:options:using:)` to extract named entities from the selected range.
        tagger.enumerateTags(in: range, unit: .word, scheme: .nameTypeOrLexicalClass, options: options) { tag, tokenRange, _ in
            
            // Make sure that the tag that was found is in the list of tags that we care about.
            guard let tag = tag, tags.contains(tag) else { return }
            
            let token = (text as NSString).substring(with: tokenRange)
            print("{token: \(token), tag: \(tag.rawValue), range: \(tokenRange)}")
        }

    }
}
