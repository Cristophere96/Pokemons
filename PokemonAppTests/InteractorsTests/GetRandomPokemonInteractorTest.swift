//
//  GetRandomPokemonInteractorTest.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 6/10/21.
//

import XCTest
import Combine
import Resolver
@testable import PokemonApp

class GetRandomPokemonInteractorTest: XCTestCase {
    @LazyInjected var repositoryStub: APIPokemonRepositoryStub!
    private var sut: GetRandomPokemonInteractor!
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        super.setUp()
        Resolver.registerMockService()
        repositoryStub = APIPokemonRepositoryStub()
        sut = GetRandomPokemonInteractor()
    }
    
    override func tearDown() {
        repositoryStub = nil
        sut = nil
        APIPokemonRepositoryStub.error = nil
        APIPokemonRepositoryStub.response = nil
        super.tearDown()
    }
    
    func test_interactorGetRandomPokemon_WhenIsSuccess() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Consume api and returns a Pokemon")
        expectationFailure.isInverted = true
        
        APIPokemonRepositoryStub.response = TestsConstants.mockedPokemon
        
        self.cancellable = sut.getRandomPokemon()?
            .sink(receiveCompletion: { completion in
            guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
                expectationFailure.fulfill()
            }, receiveValue: { pokemon in
                XCTAssertNotNil(pokemon)
                XCTAssert(pokemon.name == "cyndaquill")
                expectation.fulfill()
            })
        
        self.wait(for: [expectation, expectationFailure], timeout: 1.0)
        self.cancellable?.cancel()
    }
    
    func test_interactorGetRandomPokemon_WhenIsFailure() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Consume api and returns a Pokemon")
        expectation.isInverted = true
        
        APIPokemonRepositoryStub.error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Bad request"])
        
        self.cancellable = sut.getRandomPokemon()?
            .sink(receiveCompletion: { completion in
            guard case .failure(let error) = completion else { return
                XCTFail("completion is not failure")
            }
                XCTAssertEqual(error.localizedDescription, "Bad request")
                expectationFailure.fulfill()
            }, receiveValue: { _ in
                expectation.fulfill()
            })
        
        self.wait(for: [expectation, expectationFailure], timeout: 1.0)
        self.cancellable?.cancel()
    }
}
