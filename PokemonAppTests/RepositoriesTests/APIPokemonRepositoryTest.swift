//
//  APIPokemonRepositoryTest.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 6/10/21.
//

import XCTest
import Combine
import Resolver
@testable import PokemonApp

class APIPokemonRepositoryTest: XCTestCase {
    @LazyInjected var service: PokemonServiceType
    private var sut: PokemonRepositoryType!
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        super.setUp()
        Resolver.registerMockService()
        sut = APIPokemonRepository()
    }
    
    override func tearDown() {
        sut = nil
        PokemonServiceStub.error = nil
        PokemonServiceStub.response = nil
        super.tearDown()
    }
    
    func test_repositoryFetchPokemonsFromAGeneration_WhenIsSuccess() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Consume api and returns a list of Pokemons")
        expectationFailure.isInverted = true
        
        PokemonServiceStub.response = TestsConstants.mockedPokemons
        
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
    
    func test_repositoryFetchPokemonsFromAGeneration_WhenIsFailure() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Consume api and returns a list of Pokemons")
        expectation.isInverted = true
        
        PokemonServiceStub.error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Bad request"])
        
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
    
    func test_repositoryGetASinglePokemon_WhenIsSuccess() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Consume api and returns a Pokemon")
        expectationFailure.isInverted = true
        
        PokemonServiceStub.response = TestsConstants.mockedPokemon
        
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
    
    func test_repositoryGetASinglePokemon_WhenIsFailure() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Consume api and returns a Pokemon")
        expectation.isInverted = true
        
        PokemonServiceStub.error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Bad request"])
        
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
    
    func test_repositoryGetRandomPokemon_WhenIsSuccess() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Consume api and returns a Pokemon")
        expectationFailure.isInverted = true
        
        PokemonServiceStub.response = TestsConstants.mockedPokemon
        
        self.cancellable = sut.getRandomPokemon(url: "https://pokeapi.co/api/v2/pokemon/155")?
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
    
    func test_repositoryGetRandomPokemon_WhenIsFailure() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Consume api and returns a Pokemon")
        expectation.isInverted = true
        
        PokemonServiceStub.error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Bad request"])
        
        self.cancellable = sut.getRandomPokemon(url: "https://pokeapi.co/api/v2/pokemon/155")?
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
