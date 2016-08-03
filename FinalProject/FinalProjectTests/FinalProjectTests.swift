//
//  FinalProjectTests.swift
//  FinalProjectTests
//
//  Created by tinaun on 7/25/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import XCTest
@testable import FinalProject

class FinalProjectTests: XCTestCase {
    let loader = RLELoader()
    
    override func setUp() {
        
        
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRLEGliders() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let test = "#C This is a glider.\n"
            + "x = 3, y = 3\n"
            + "bo$2bo$3o!"
        print(test)
        
        
        var pattern = loader.load(fromString: test)
        XCTAssertNotNil(pattern)
        XCTAssertEqual(pattern!.data.description, ".#.\n..#\n###\n")
        
        print(pattern!.metadata)
        print(pattern!.data)
        
        let testTwo = "#N Gosper glider gun\n"
        + "#C This was the first gun discovered.\n"
        + "#C As its name suggests, it was discovered by Bill Gosper.\n"
        + "x = 36, y = 9, rule = B3/S23\n"
        + "24bo$22bobo$12b2o6b2o12b2o$11bo3bo4b2o12b2o$2o8bo5bo3b2o$2o8bo3bob2o4b\n"
        + "obo$10bo5bo7bo$11bo3bo$12b2o!"
        
        pattern = loader.load(fromString: testTwo)
        XCTAssertNotNil(pattern)
        XCTAssertEqual(pattern!.metadata.name, "Gosper glider gun")
        
        print(pattern!.metadata)
        print(pattern!.data)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
