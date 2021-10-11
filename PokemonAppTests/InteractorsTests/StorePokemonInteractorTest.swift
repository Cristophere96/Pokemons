//
//  StorePokemonInteractorTest.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 6/10/21.
//

import XCTest
import Combine
import Resolver
@testable import PokemonApp

class StorePokemonInteractorTest: XCTestCase {
    @LazyInjected var repositoryStub: CoreDataPokemonRepositoryStub!
    private var sut: StorePokemonInteractor!
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        super.setUp()
        Resolver.registerMockService()
        repositoryStub = CoreDataPokemonRepositoryStub()
        sut = StorePokemonInteractor()
    }
    
    override func tearDown() {
        cancellable = nil
        sut = nil
        CoreDataPokemonRepositoryStub.error = nil
        CoreDataPokemonRepositoryStub.response = nil
        super.tearDown()
    }
    
    func test_interactorStorePokemonInCoreData_WhenIsSuccess() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Store a Pokemon in local storage")
        expectationFailure.isInverted = true
        
        CoreDataPokemonRepositoryStub.response = true
        
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
    
    func test_interactorStorePokemonInCoreData_WhenIsFailure() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Store a Pokemon in local storage")
        expectation.isInverted = true
        
        CoreDataPokemonRepositoryStub.error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Couldn't save to CoreData right now"])
        
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
