//
//  PokemonViewModelTest.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 4/10/21.
//

import XCTest
import Resolver
@testable import PokemonApp

class PokemonViewModelTest: XCTestCase {
    @LazyInjected var getPokemonsFromAGenerationStub: GetPokemonsFromAGenerationInteractorStub
    
    private var sut: PokemonViewModel!
    
    override func setUp() {
        super.setUp()
        Resolver.registerMockService()
        sut = PokemonViewModel(limit: 9, offset: 151)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_GivenALimitAndAnOffsetThenFetchPokemonGeneration_WhenIsSuccess() {
        let expectation = XCTestExpectation(description: "Given a limit of 9 and an offset of 151 gets the main pokemons from the second generation")
        
        getPokemonsFromAGenerationStub.responseHandler = .success {
            TestsConstants.mockedPokemons
        }
        sut.fetchPokemons()
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.pokemons.isEmpty)
            XCTAssertFalse(sut.isLoading)
        } else {
            XCTFail("test failed due to timeout")
        }
    }
    
    func test_GivenALimitAndAnOffsetThenFetchPokemonGeneration_WhenIsFailure() {
        let expectation = XCTestExpectation(description: "shows error due to bad internet connection")
        
        getPokemonsFromAGenerationStub.responseHandler = .failure({
            NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "The internet seems to be off"])
        })
        sut.fetchPokemons()
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.pokemons.isEmpty)
            XCTAssertFalse(sut.isLoading)
            XCTAssertTrue(sut.showError)
            XCTAssert(sut.errorMessage == "The internet seems to be off")
        } else {
            XCTFail("test failed due to timeout")
        }
    }
}
