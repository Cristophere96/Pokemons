//
//  PokemonVotingViewModelTest.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 1/10/21.
//

import XCTest
import Resolver
@testable import PokemonApp

class PokemonVotingViewModelTest: XCTestCase {
    @LazyInjected var getRandomPokemonInteractorStub: GetRandomPokemonInteractorStub
    
    private var sut: PokemonVotingViewModel!
    
    override func setUp() {
        super.setUp()
        Resolver.registerMockService()
        sut = PokemonVotingViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_FetchRandomPokemon_WhenIsSuccess() {
        let expectation = XCTestExpectation(description: "returns a random Pokemon from all the generations")
        
        getRandomPokemonInteractorStub.responseHandler = .success {
            TestsConstants.mockedPokemon
        }
        
        sut.fetchRandomPokemon()
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.pokemon.isEmpty)
        } else {
            XCTFail("test fail due to time out")
        }
    }
    
    func test_FetchRandomPokemon_WhenIsFailure() {
        let expectation = XCTestExpectation(description: "tries to return a Pokemon but the operation fails")
        
        getRandomPokemonInteractorStub.responseHandler = .failure({
            NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid url"])
        })
        
        sut.fetchRandomPokemon()
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.pokemon.isEmpty)
            XCTAssertTrue(sut.showError)
            XCTAssert(sut.errorMessage == "Invalid url")
        } else {
            XCTFail("test fail due to time out")
        }
    }
}
