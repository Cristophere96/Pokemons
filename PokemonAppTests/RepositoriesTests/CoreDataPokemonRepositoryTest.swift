//
//  CoreDataPokemonRepositoryTest.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 7/10/21.
//

import XCTest
import Combine
import Resolver
@testable import PokemonApp

class CoreDataPokemonRepositoryTest: XCTestCase {
    @LazyInjected var service: CoreDataServiceType
    private var sut: PokemonDataBaseRepositoryType!
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        super.setUp()
        Resolver.registerMockService()
        sut = CoreDataPokemonRepository()
    }
    
    override func tearDown() {
        sut = nil
        CoreDataServiceStub.error = nil
        CoreDataServiceStub.response = nil
        super.tearDown()
    }
    
    func test_repositoryGetPokemonsStoredInCoreData_WhenIsEmpty() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Gets the pokemons stored in local storage but is empty")
        expectationFailure.isInverted = true
        
        CoreDataServiceStub.response = []
        
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
    
    func test_repositoryGetPokemonsStoredInCoreData_WhenIsDataStored() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Gets the pokemons stored in local storage")
        expectationFailure.isInverted = true
        
        CoreDataServiceStub.response = TestsConstants.mockPokemonsVoted
        
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
    
    func test_repositoryGetPokemonsStoredInCoreData_WhenIsFailure() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Gets the pokemons stored in local storage")
        expectation.isInverted = true
        
        CoreDataServiceStub.error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Can't access CoreData right now"])
        
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
    
    func test_repositoryStorePokemonInCoreData_WhenIsSuccess() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Store a Pokemon in local storage")
        expectationFailure.isInverted = true
        
        CoreDataServiceStub.response = true
        
        self.cancellable = sut.savePokemonToCoreData(url: "https://pokeapi.co/api/v2/pokemon/155", type: "LIKED")?
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
                expectationFailure.fulfill()
            }, receiveValue: { result in
                XCTAssertTrue(result)
                expectation.fulfill()
            })
        
        self.wait(for: [expectation, expectationFailure], timeout: 1.0)
        self.cancellable?.cancel()
    }
    
    func test_repositoryStorePokemonInCoreData_WhenIsFailure() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Store a Pokemon in local storage")
        expectation.isInverted = true
        
        CoreDataServiceStub.error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Couldn't save to CoreData right now"])
        
        self.cancellable = sut.savePokemonToCoreData(url: "https://pokeapi.co/api/v2/pokemon/155", type: "LIKED")?
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return        XCTFail("completion is not failure")
                }
                XCTAssertEqual(error.localizedDescription, "Couldn't save to CoreData right now")
                expectationFailure.fulfill()
            }, receiveValue: { _ in
                expectation.fulfill()
            })
        
        self.wait(for: [expectation, expectationFailure], timeout: 1.0)
        self.cancellable?.cancel()
    }
}
