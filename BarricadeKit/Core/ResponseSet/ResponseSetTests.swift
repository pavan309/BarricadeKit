//
//  ResponseSetTests.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

@testable import BarricadeKit
import XCTest


class ResponseSetTests: XCTestCase {
    
    func testSetCreation() {
        let set = ResponseSet(requestName: "Demo", evaluation: .always())
        XCTAssertEqual(set.requestName, "Demo")
    }
    
    func testAddingResponses() {
        var set = ResponseSet(requestName: "Demo", evaluation: .always())
        
        set.add(response: StandardNetworkResponse(name: "response1", statusCode: 200, contentType: ContentType.textPlain))
        set.add(response: StandardNetworkResponse(name: "response2", statusCode: 200, contentType: ContentType.textPlain))
        set.add(response: StandardErrorResponse(name: "error", error: BarricadeError.offline))
        
        XCTAssertEqual(set.allResponses.count, 3)
    }

    func testFetchMissingResponseByName() {
        var set = ResponseSet(requestName: "Demo", evaluation: .always())
        set.add(response: StandardNetworkResponse(name: "response1", statusCode: 200, contentType: ContentType.textPlain))
        set.add(response: StandardNetworkResponse(name: "response2", statusCode: 200, contentType: ContentType.textPlain))
        set.add(response: StandardErrorResponse(name: "error", error: BarricadeError.offline))

        XCTAssertNil(set.response(named: "name"))
    }
    
    func testFetchExistingResponseByName_network() {
        var set = ResponseSet(requestName: "Demo", evaluation: .always())
        set.add(response: StandardNetworkResponse(name: "response1", statusCode: 200, contentType: ContentType.textPlain))
        set.add(response: StandardNetworkResponse(name: "response2", statusCode: 200, contentType: ContentType.textPlain))
        set.add(response: StandardErrorResponse(name: "error", error: BarricadeError.offline))
        
        let response = set.response(named: "response1")!
        switch response {
        case .network(let networkResponse):
            XCTAssertEqual(networkResponse.name, "response1")
        default:
            XCTFail()
        }
    }
    
    func testFetchExistingResponseByName_error() {
        var set = ResponseSet(requestName: "Demo", evaluation: .always())
        set.add(response: StandardNetworkResponse(name: "response1", statusCode: 200, contentType: ContentType.textPlain))
        set.add(response: StandardNetworkResponse(name: "response2", statusCode: 200, contentType: ContentType.textPlain))
        set.add(response: StandardErrorResponse(name: "error", error: BarricadeError.offline))
        
        let response = set.response(named: "error")!
        switch response {
        case .error(let errorResponse):
            XCTAssertEqual(errorResponse.name, "error")
        default:
            XCTFail()
        }
    }
}


extension ResponseSetEvaluation {
    
    static func always() -> ResponseSetEvaluation {
        return ResponseSetEvaluation { _, _ -> Bool in
            return true
        }
    }
}
