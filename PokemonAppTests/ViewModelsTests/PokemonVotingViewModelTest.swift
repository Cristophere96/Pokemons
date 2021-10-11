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
    @LazyInjected var getPokemonsVotedInteractorStub: GetPokemonsVotedInteractorStub
    @LazyInjected var storePokemonInteractorStub: StorePokemonInteractorStub
    
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
    
    func test_StoreRandomPokemonWithLike_WhenIsSuccess() {
        let expectation = XCTestExpectation(description: "Store the pokemon fetched to CoreData with voteType LIKED")
        
        getRandomPokemonInteractorStub.responseHandler = .success {
            TestsConstants.mockedPokemon
        }
        getPokemonsVotedInteractorStub.responseHandler = .success {
            TestsConstants.mockPokemonsVoted
        }
        storePokemonInteractorStub.responseHandler = .success {
            true
        }
        sut.fetchRandomPokemon()
        sut.likePokemon()
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.showError)
            XCTAssert(sut.errorMessage == "")
        } else {
            XCTFail("test failed due to timeout")
        }
    }
    
    func test_StoreRandomPokemonWithLike_WhenIsFailure() {
        let expectation = XCTestExpectation(description: "Store the pokemon fetched to CoreData with voteType LIKED but an error happened")
        
        getRandomPokemonInteractorStub.responseHandler = .success {
            TestsConstants.mockedPokemon
        }
        getPokemonsVotedInteractorStub.responseHandler = .success {
            TestsConstants.mockPokemonsVoted
        }
        storePokemonInteractorStub.responseHandler = .failure({
            NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "An error happened saving the pokemon to CoreData"])
        })
        sut.fetchRandomPokemon()
        sut.likePokemon()
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.showError)
            XCTAssert(sut.errorMessage == "An error happened saving the pokemon to CoreData")
        } else {
            XCTFail("test failed due to timeout")
        }
    }
    
    func test_StoreRandomPokemonWithDislike_WhenIsSuccess() {
        let expectation = XCTestExpectation(description: "Store the pokemon fetched to CoreData with voteType DISLIKED")
        
        getRandomPokemonInteractorStub.responseHandler = .success {
            TestsConstants.mockedPokemon
        }
        getPokemonsVotedInteractorStub.responseHandler = .success {
            TestsConstants.mockPokemonsVoted
        }
        storePokemonInteractorStub.responseHandler = .success {
            true
        }
        sut.fetchRandomPokemon()
        sut.likePokemon()
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.showError)
            XCTAssert(sut.errorMessage == "")
        } else {
            XCTFail("test failed due to timeout")
        }
    }
    
    func test_StoreRandomPokemonWithDislike_WhenIsFailure() {
        let expectation = XCTestExpectation(description: "Store the pokemon fetched to CoreData with voteType DISLIKED but an error happened")
        
        getRandomPokemonInteractorStub.responseHandler = .success {
            TestsConstants.mockedPokemon
        }
        getPokemonsVotedInteractorStub.responseHandler = .success {
            TestsConstants.mockPokemonsVoted
        }
        storePokemonInteractorStub.responseHandler = .failure({
            NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "An error happened saving the pokemon to CoreData"])
        })
        sut.fetchRandomPokemon()
        sut.likePokemon()
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.showError)
            XCTAssert(sut.errorMessage == "An error happened saving the pokemon to CoreData")
        } else {
            XCTFail("test failed due to timeout")
        }
    }


}
