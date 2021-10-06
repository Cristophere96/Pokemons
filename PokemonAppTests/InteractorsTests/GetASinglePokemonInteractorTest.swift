//
//  GetASinglePokemonInteractorTest.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 6/10/21.
//

import XCTest
import Combine
import Resolver
@testable import PokemonApp

class GetASinglePokemonInteractorTest: XCTestCase {
    @LazyInjected var repositoryStub: APIPokemonRepositoryStub!
    private var sut: GetASinglePokemonInteractor!
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        super.setUp()
        Resolver.registerMockService()
        repositoryStub = APIPokemonRepositoryStub()
        sut = GetASinglePokemonInteractor()
    }
    
    override func tearDown() {
        repositoryStub = nil
        sut = nil
        APIPokemonRepositoryStub.error = nil
        APIPokemonRepositoryStub.response = nil
        super.tearDown()
    }
    
    func test_interactorGetASinglePokemon_WhenIsSuccess() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Consume api and returns a Pokemon")
        expectationFailure.isInverted = true
        
        APIPokemonRepositoryStub.response = TestsConstants.mockedPokemon
        
        self.cancellable = sut.getASinglePokemon(url: "https://pokeapi.co/api/v2/pokemon/155")
            .sink(receiveCompletion: { completion in
            guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
                expectationFailure.fulfill()
            }, receiveValue: { pokemon in
                XCTAssertNotNil(pokemon)
                expectation.fulfill()
            })
        
        self.wait(for: [expectation, expectationFailure], timeout: 1.0)
        self.cancellable?.cancel()
    }
    
    func test_interactorGetASinglePokemon_WhenIsFailure() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Consume api and returns a Pokemon")
        expectation.isInverted = true
        
        APIPokemonRepositoryStub.error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Bad request"])
        
        self.cancellable = sut.getASinglePokemon(url: "https://pokeapi.co/api/v2/pokemon/155")
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
