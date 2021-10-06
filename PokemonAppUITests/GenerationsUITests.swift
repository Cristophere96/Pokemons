//
//  GenerationsUITests.swift
//  PokemonAppUITests
//
//  Created by Cristopher Escorcia on 6/10/21.
//

import XCTest

class GenerationsUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func test_navigatesToTheFirstGeneration() {
        let button = app.otherElements["FirstGen"]
        print("print", button)
    }
}
