//
//  PokemonAppUITests.swift
//  PokemonAppUITests
//
//  Created by Cristopher Escorcia on 25/06/21.
//

import XCTest

class PokemonAppUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    override func tearDown() {
        self.app = nil
        super.tearDown()
    }

    func testWhenPressedTheVotingSistemTabButtonThenNavigatesToTheVotePokemonScreen() {
        let tabBars = self.app.tabBars
        let button = tabBars.buttons["Vote for a Pokemon"]
        button.tap()
        self.app.wait(for: .runningBackground, timeout: 2.0)
    }
    
    func testWhenPressedTheYourVotesTabButtonThenNavigatesToThePokemonsVotedScreen() {
        let tabBars = self.app.tabBars
        let button = tabBars.buttons["Your votes"]
        button.tap()
        self.app.wait(for: .runningBackground, timeout: 2.0)
    }

    func test_navigatesToTheFirstGenerationScreen() {
        let genCell = self.app.buttons["first_gen"]
        genCell.tap()
        self.app.wait(for: .runningBackground, timeout: 2.0)
    }
    
    func test_selectsAPokemonThenNavigatesToTheDetailScreen() {
        let genCell = self.app.buttons["first_gen"]
        genCell.tap()
        self.app.wait(for: .runningBackground, timeout: 8.0)
        let pokemon = self.app.buttons["Pokemon#1"]
        pokemon.tap()
        self.app.wait(for: .runningBackground, timeout: 2.0)
    }
    
    func test_NavigatesToTheDetailScreenThenShowsThePokemonStats() {
        let genCell = self.app.buttons["first_gen"]
        genCell.tap()
        self.app.wait(for: .runningBackground, timeout: 8.0)
        let pokemon = self.app.buttons["Pokemon#1"]
        pokemon.tap()
        self.app.wait(for: .runningBackground, timeout: 2.0)
        let stats = self.app.buttons["Stats"]
        stats.tap()
        self.app.wait(for: .runningBackground, timeout: 2.0)
    }
    
    func test_NavigatesToTheDetailScreenThenShowsThePokemonMoves() {
        let genCell = self.app.buttons["first_gen"]
        genCell.tap()
        self.app.wait(for: .runningBackground, timeout: 8.0)
        let pokemon = self.app.buttons["Pokemon#1"]
        pokemon.tap()
        self.app.wait(for: .runningBackground, timeout: 2.0)
        let moves = self.app.buttons["Moves"]
        moves.tap()
        self.app.wait(for: .runningBackground, timeout: 2.0)
    }
    
    func testNavigatesToDetailScreenFromVotePokemonScreen() {
        let tabBars = self.app.tabBars
        let button = tabBars.buttons["Vote for a Pokemon"]
        button.tap()
        self.app.wait(for: .runningBackground, timeout: 2.0)
        let pokemon = self.app.buttons["largePokemonCell"]
        pokemon.tap()
        self.app.wait(for: .runningBackground, timeout: 2.0)
    }
    
    func testVotesAPokemonWithLiked() {
        let tabBars = self.app.tabBars
        let button = tabBars.buttons["Vote for a Pokemon"]
        button.tap()
        self.app.wait(for: .runningBackground, timeout: 2.0)
        let pokemon = self.app.buttons["largePokemonCell"]
        pokemon.swipeRight()
    }
    
    func testVotesAPokemonWithDisliked() {
        let tabBars = self.app.tabBars
        let button = tabBars.buttons["Vote for a Pokemon"]
        button.tap()
        self.app.wait(for: .runningBackground, timeout: 2.0)
        let pokemon = self.app.buttons["largePokemonCell"]
        pokemon.swipeLeft()
    }
    
    func testShowsTheDislikedPokemons() {
        let tabBars = self.app.tabBars
        let button = tabBars.buttons["Your votes"]
        button.tap()
        self.app.wait(for: .runningBackground, timeout: 2.0)
        let tab = self.app.buttons["Disliked"]
        tab.tap()
        self.app.wait(for: .runningBackground, timeout: 2.0)
    }
}
