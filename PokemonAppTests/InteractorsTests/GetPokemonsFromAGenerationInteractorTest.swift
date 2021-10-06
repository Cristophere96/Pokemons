//
//  GetPokemonsFromAGenerationInteractorTest.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 6/10/21.
//

import XCTest
import Combine
import Resolver
@testable import PokemonApp

class GetPokemonsFromAGenerationInteractorTest: XCTestCase {
    @LazyInjected var repositoryStub: APIPokemonRepositoryStub!
    private var sut: GetPokemonsFromAGenerationInteractor!
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        super.setUp()
        Resolver.registerMockService()
        sut = GetPokemonsFromAGenerationInteractor()
    }
    
    override func tearDown() {
        repositoryStub = nil
        sut = nil
        APIPokemonRepositoryStub.error = nil
        APIPokemonRepositoryStub.response = nil
        super.tearDown()
    }
    
    func test_interactorFetchPokemonsFromAGeneration_WhenIsSuccess() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Consume api and returns a list of Pokemons")
        expectationFailure.isInverted = true
        
        APIPokemonRepositoryStub.response = TestsConstants.mockedPokemons
        
        self.cancellable = sut.getPokemonsFromAGeneration(limit: 9, offset: 151)?
            .sink(receiveCompletion: { completion in
            guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
                expectationFailure.fulfill()
            }, receiveValue: { pokemons in
                XCTAssertFalse(pokemons.isEmpty)
                XCTAssert(pokemons.count == 9)
                expectation.fulfill()
            })
        
        self.wait(for: [expectation, expectationFailure], timeout: 1.0)
        self.cancellable?.cancel()
    }
    
    func test_interactorFetchPokemonsFromAGeneration_WhenIsFailure() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Consume api and returns a list of Pokemons")
        expectation.isInverted = true
        
        APIPokemonRepositoryStub.error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Bad request"])
        
        self.cancellable = sut.getPokemonsFromAGeneration(limit: 9, offset: 151)?
            .sink(receiveCompletion: { completion in
            guard case .failure(let error) = completion else { return        XCTFail("completion is not failure")
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
