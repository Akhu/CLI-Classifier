//
//  main.swift
//  CLIClassifier
//
//  Created by Anthony Da Cruz on 17/07/2018.
//  Copyright © 2018 Anthony Da Cruz. All rights reserved.
//

import Foundation


let console = ConsoleIO()

if CommandLine.argc < 2 {
    //TODO: Handle interactive mode
}else {
    let classification = Classifier()
    classification.staticMode()
    
    
    
//    let nlprocessing = NLPProcessing()
//    nlprocessing.staticMode()
    
}
