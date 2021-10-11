//
//  GetPokemonsVotedInteractorTest.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 6/10/21.
//

import XCTest
import Combine
import Resolver
@testable import PokemonApp

class GetPokemonsVotedInteractorTest: XCTestCase {
    @LazyInjected var repositoryStub: CoreDataPokemonRepositoryStub!
    private var sut: GetPokemonsVotedInteractor!
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        super.setUp()
        Resolver.registerMockService()
        repositoryStub = CoreDataPokemonRepositoryStub()
        sut = GetPokemonsVotedInteractor()
    }
    
    override func tearDown() {
        cancellable = nil
        sut = nil
        CoreDataPokemonRepositoryStub.error = nil
        CoreDataPokemonRepositoryStub.response = nil
        super.tearDown()
    }
    
    func test_interactorGetPokemonsStoredInCoreData_WhenIsEmpty() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Gets the pokemons stored in local storage but is empty")
        expectationFailure.isInverted = true
        
        CoreDataPokemonRepositoryStub.response = []
        
        self.cancellable = sut.getAllPokemonsFromCoreData()?
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
                expectationFailure.fulfill()
            }, receiveValue: { pokemonsStored in
                XCTAssertTrue(pokemonsStored.isEmpty)
                expectation.fulfill()
            })
        
        self.wait(for: [expectation, expectationFailure], timeout: 1.0)
        self.cancellable?.cancel()
    }
    
    func test_interactorGetPokemonsStoredInCoreData_WhenIsDataStored() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Gets the pokemons stored in local storage")
        expectationFailure.isInverted = true
        
        CoreDataPokemonRepositoryStub.response = TestsConstants.mockPokemonsVoted
        
        self.cancellable = sut.getAllPokemonsFromCoreData()?
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
                expectationFailure.fulfill()
            }, receiveValue: { pokemonsStored in
                XCTAssertFalse(pokemonsStored.isEmpty)
                XCTAssert(pokemonsStored.count == 2)
                expectation.fulfill()
            })
        
        self.wait(for: [expectation, expectationFailure], timeout: 1.0)
        self.cancellable?.cancel()
    }
    
    func test_interactorGetPokemonsStoredInCoreData_WhenIsFailure() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Gets the pokemons stored in local storage")
        expectation.isInverted = true
        
        CoreDataPokemonRepositoryStub.error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Can't access CoreData right now"])
        
        self.cancellable = sut.getAllPokemonsFromCoreData()?
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return        XCTFail("completion is not failure")
                }
                XCTAssertEqual(error.localizedDescription, "Can't access CoreData right now")
                expectationFailure.fulfill()
            }, receiveValue: { _ in
                expectation.fulfill()
            })
        
        self.wait(for: [expectation, expectationFailure], timeout: 1.0)
        self.cancellable?.cancel()
    }
}
