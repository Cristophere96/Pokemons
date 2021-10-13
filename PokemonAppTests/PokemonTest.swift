//
//  PokemonTest.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 12/10/21.
//

import XCTest
import Resolver
@testable import PokemonApp

class PokemonTest: XCTestCase {
    @LazyInjected var getRandomPokemonInteractorStub: GetRandomPokemonInteractorStub
    @LazyInjected var getPokemonsVotedInteractorStub: GetPokemonsVotedInteractorStub
    @LazyInjected var storePokemonInteractorStub: StorePokemonInteractorStub
    @LazyInjected var getPokemonsFromAGenerationStub: GetPokemonsFromAGenerationInteractorStub
    @LazyInjected var getPokemonsVotedStub: GetPokemonsVotedInteractorStub
    @LazyInjected var getASinglePokemonStub: GetASinglePokemonInteractorStub
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        Resolver.registerMockService()
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
    }
}
