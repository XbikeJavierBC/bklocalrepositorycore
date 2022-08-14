//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import XCTest
import Combine

import bkdomauncore

@testable import bklocalrepositorycore

final class BKRXRideLocalRepositoryTest: XCTestCase {
    var expectation: XCTestExpectation?
    private var subscriber: AnyCancellable?
    
    override func setUp() async throws {
        try await super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        self.expectation = nil
    }
    
    //MARK: FLOW SUCCESS
    func testGetRxSuccess() throws {
        self.expectation = expectation(description: "::: Get RX Success :::")
        
        self.subscriber = try? BKRXRideLocalRepository.get(id: "sdsadsa")?
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: self.requestFail,
                receiveValue: {
                    self.expectation?.fulfill()
                    XCTAssertTrue($0.endAddress.isNotEmpty)
                }
            )
        
        self.waitForExpectations(timeout: 60.0, handler: nil)
    }
    
    func testGetAllRxSuccess() throws {
        self.expectation = expectation(description: "::: Get All RX Success :::")
        
        self.subscriber = try BKRXRideLocalRepository.getAll()?
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: self.requestFail,
                receiveValue: {
                    self.expectation?.fulfill()
                    XCTAssertTrue($0.isNotEmpty)
                }
            )
        
        self.waitForExpectations(timeout: 60.0, handler: nil)
    }
    
    func testSaveItemSuccess() throws {
        self.expectation = expectation(description: "::: Save Item Success :::")
        
        let model = BKRideModel(
            time: 10,
            distance: 100,
            startAddress: "Lugar 10",
            endAddress: "Lugar 100"
        )
        
        self.subscriber = try BKRXRideLocalRepository.save(model: model)?
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: self.requestFail,
                receiveValue: {
                    self.expectation?.fulfill()
                    
                    XCTAssertTrue($0)
                }
            )
        
        self.waitForExpectations(timeout: 60.0, handler: nil)
    }
    
    func testSaveAllSuccess() throws {
        self.expectation = expectation(description: "::: Save All Success :::")
        
        let model = BKRideModel(
            time: 20,
            distance: 200,
            startAddress: "Lugar 20",
            endAddress: "Lugar 200"
        )
        
        let model2 = BKRideModel(
            time: 30,
            distance: 300,
            startAddress: "Lugar 20",
            endAddress: "Lugar 300"
        )
        
        let model3 = BKRideModel(
            time: 40,
            distance: 400,
            startAddress: "Lugar 40",
            endAddress: "Lugar 400"
        )
        
        self.subscriber = try BKRXRideLocalRepository.saveAll(modelList: [model, model2, model3])?
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: self.requestFail,
                receiveValue: {
                    self.expectation?.fulfill()
                    
                    XCTAssertTrue($0)
                }
            )
        
        self.waitForExpectations(timeout: 60.0, handler: nil)
    }
    
    func testDeleteSuccess() throws {
        self.expectation = expectation(description: "::: Delete Success :::")
        
        self.subscriber = try BKRXRideLocalRepository.delete(id: "ddwdwdwd")?
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: self.requestFail,
                receiveValue: {
                    self.expectation?.fulfill()
                    
                    XCTAssertTrue($0)
                }
            )
        
        self.waitForExpectations(timeout: 60.0, handler: nil)
    }
    
    func testDeleteAllSuccess() throws {
        self.expectation = expectation(description: "::: Delete All Success :::")
        
        self.subscriber = try BKRXRideLocalRepository.deleteAll()?
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: self.requestFail,
                receiveValue: {
                    self.expectation?.fulfill()
                    
                    XCTAssertTrue($0)
                }
            )
        
        self.waitForExpectations(timeout: 60.0, handler: nil)
    }
    
    private func requestFail(completion: Subscribers.Completion<Error>) {
        switch completion {
            case .failure(let error):
                self.expectation?.fulfill()
                XCTFail("\n::: Error: \(error.localizedDescription)")
            case .finished:
                break
        }
    }
}
