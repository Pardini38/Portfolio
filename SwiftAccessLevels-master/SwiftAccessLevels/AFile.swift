//
//  AFile.swift
//  SwiftAccessLevels
//
//  Created by Angela Yu on 14/09/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class AClass {
    
    //Global variables, also called class properties.
    private var aPrivateProperty = "private property"
    
    fileprivate var aFilePrivateProperty = "fileprivate property"
    
    var anInternalProperty = "internal property"
    
    func methodA () {
        
        let aLocalVariable = "local variable"
        
        //Step 1. Try to print aLocalVariable Here - Possible
        print("(1) - \(aLocalVariable) printed from methodA in AClass")
        
        //Step 3. Try to print aPrivateProperty Here
        print("(3) - \(aPrivateProperty) printed from methodA in AClass")

        //Step 6. Try to print aFilePrivateProperty Here
        print("(6) - \(aFilePrivateProperty) printed from methodA in AClass")

        
        //Step 9. Try to print anInternalProperty Here
        print("(9) - \(anInternalProperty) printed from methodA in AClass")

    }
    
    func methodB () {
        
        //Step 2. Try to print aLocalVariable Here
        print("(2) - \(aLocalVariable) printed from methodA in AClass")
        //Step 4. Try to print aPrivateProperty Here
        print("(4) - \(aPrivateProperty) printed from methodA in AClass")
    }
    
}

class AnotherClassInTheSameFile {
    
    init() {
        
        //Step 5. Try to print aPrivateProperty Here
        print("(5) - \(aPrivateProperty) printed from methodA in AClass")

        //Step 7. Try to print aFilePrivateProperty Here
        print("(7) - \(AClass().aFilePrivateProperty) printed from methodA in AClass")

        
    }
}
