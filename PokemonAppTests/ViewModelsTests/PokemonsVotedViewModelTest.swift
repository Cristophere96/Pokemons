//
//  PokemonsVotedViewModelTest.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 4/10/21.
//

import XCTest
import Resolver
@testable import PokemonApp

class PokemonsVotedViewModelTest: XCTestCase {
    @LazyInjected var getPokemonsVotedStub: GetPokemonsVotedInteractorStub
    @LazyInjected var getASinglePokemonStub: GetASinglePokemonInteractorStub
    
    private var sut: PokemonsVotedViewModel!
    
    override func setUp() {
        super.setUp()
        Resolver.registerMockService()
        sut = PokemonsVotedViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_fetchPokemonsVotedFromCoreData_WhenIsEmpty() {
        let expectation = XCTestExpectation(description: "fetches the pokemons voted from CoreData but the database is empty")
        
        getPokemonsVotedStub.responseHandler = .success {
            []
        }
        sut.getAllPokemonsVoted()
        sut.fetchPokemons()
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.isEmpty)
            XCTAssertTrue(sut.pokemonsLiked.isEmpty)
            XCTAssertTrue(sut.pokemondsDisliked.isEmpty)
        } else {
            XCTFail("test failed due to timeout")
        }
    }
    
    func test_fetchPokemonsVotedFromCoreData_ThenFetchFromApi() {
        let expectation = XCTestExpectation(description: "fetches the pokemons voted from CoreData")
        
        getPokemonsVotedStub.responseHandler = .success {
            TestsConstants.mockPokemonsVoted
        }
        sut.getAllPokemonsVoted()
        sut.fetchPokemons()
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.isEmpty)
            XCTAssertTrue(sut.pokemonsLiked.count == 1)
            XCTAssertTrue(sut.pokemondsDisliked.count == 1)
        } else {
            XCTFail("test failed due to timeout")
        }
    }
    
    func test_fetchPokemonsVotedFromCoreData_WhenIsFailure() {
        let expectation = XCTestExpectation(description: "error happened fetching the pokemons voted from CoreData")
        
        getPokemonsVotedStub.responseHandler = .failure({
            NSError(domain: "", code: 504, userInfo: [NSLocalizedDescriptionKey: "can't access CoreData right now"])
        })
        sut.getAllPokemonsVoted()
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.showError)
            XCTAssert(sut.errorMessage == "can't access CoreData right now")
        } else {
            XCTFail("test failed due to timeout")
        }
    }
    
    func test_fetchPokemonsVotedFromCoreDataButURlsAreInvalid() {
        let expectation = XCTestExpectation(description: "fetches the pokemon voted from CoreData but an error happened when fetching from API")
        
        getPokemonsVotedStub.responseHandler = .success {
            TestsConstants.mockPokemonsVoted
        }
        getASinglePokemonStub.responseHandler = .failure({
            NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Bad request"])
        })
        sut.getAllPokemonsVoted()
        sut.fetchPokemons()
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.showError)
            XCTAssertTrue(sut.pokemonsLiked.isEmpty)
            XCTAssertTrue(sut.pokemondsDisliked.isEmpty)
            XCTAssert(sut.errorMessage == "Bad request")
        } else {
            XCTFail("test failed due to timeout")
        }
    }
}
