//
//  PokemonAppUITests.swift
//  PokemonAppUITests
//
//  Created by Cristopher Escorcia on 25/06/21.
//

import XCTest

class PokemonAppUITests: XCTestCase {
    private var app: XCUIApplication!
    private var timeout: Bool?
    
    override func setUp() {
        super.setUp()
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    override func tearDown() {
        self.timeout = nil
        self.app = nil
        super.tearDown()
    }

    func testWhenPressedTheVotingSistemTabButtonThenNavigatesToTheVotePokemonScreen() {
        let tabBars = self.app.tabBars
        let button = tabBars.buttons["Vote for a Pokemon"]
        button.tap()
        self.timeout = self.app.wait(for: .runningBackground, timeout: 2.0)
    }
    
    func testWhenPressedTheYourVotesTabButtonThenNavigatesToThePokemonsVotedScreen() {
        let tabBars = self.app.tabBars
        let button = tabBars.buttons["Your votes"]
        button.tap()
        self.timeout = self.app.wait(for: .runningBackground, timeout: 2.0)
    }

    func test_navigatesToTheFirstGenerationScreen() {
        let genCell = self.app.buttons["first_gen"]
        genCell.tap()
    }
    
    func test_selectsAPokemonThenNavigatesToTheDetailScreen() {
        self.test_navigatesToTheFirstGenerationScreen()
        self.timeout = self.app.wait(for: .runningBackground, timeout: 6.0)
        let pokemon = self.app.buttons["Pokemon#1"]
        pokemon.tap()
    }
    
    func test_NavigatesToTheDetailScreenThenShowsThePokemonStats() {
        self.test_selectsAPokemonThenNavigatesToTheDetailScreen()
        self.timeout = self.app.wait(for: .runningBackground, timeout: 1.0)
        let stats = self.app.buttons["Stats"]
        stats.tap()
    }
    
    func test_NavigatesToTheDetailScreenThenShowsThePokemonMoves() {
        self.test_selectsAPokemonThenNavigatesToTheDetailScreen()
        self.timeout = self.app.wait(for: .runningBackground, timeout: 1.0)
        let moves = self.app.buttons["Moves"]
        moves.tap()
    }
    
    func testNavigatesToDetailScreenFromVotePokemonScreen() {
        self.testWhenPressedTheVotingSistemTabButtonThenNavigatesToTheVotePokemonScreen()
        let pokemon = self.app.buttons["largePokemonCell"]
        pokemon.tap()
        self.timeout = self.app.wait(for: .runningBackground, timeout: 2.0)
    }
    
    func testVotesAPokemonWithLiked() {
        self.testWhenPressedTheVotingSistemTabButtonThenNavigatesToTheVotePokemonScreen()
        let pokemon = self.app.buttons["largePokemonCell"]
        pokemon.swipeRight()
    }
    
    func testVotesAPokemonWithDisliked() {
        self.testWhenPressedTheVotingSistemTabButtonThenNavigatesToTheVotePokemonScreen()
        let pokemon = self.app.buttons["largePokemonCell"]
        pokemon.swipeLeft()
    }
    
    func testNavigatesBetweenTheLikedAndDislikedPokemons() {
        self.testWhenPressedTheYourVotesTabButtonThenNavigatesToThePokemonsVotedScreen()
        let disliked = self.app.buttons["Disliked"]
        disliked.tap()
        self.timeout = self.app.wait(for: .runningBackground, timeout: 2.0)
        let liked = self.app.buttons["Liked"]
        liked.tap()
        self.timeout = self.app.wait(for: .runningBackground, timeout: 2.0)
    }
}
