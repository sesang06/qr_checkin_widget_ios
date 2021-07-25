//
//  qrcheckinTests.swift
//  qrcheckinTests
//
//  Created by sesang on 2021/07/21.
//

import XCTest
@testable import qrcheckin

class qrcheckinTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testQrCheckinTest() {
        let text = "<image id=\"qrImg\" src=\"abcd\">"
        let loader = ImageCheckinLoader(text: text)
        if let tag = loader.getTagById(id: "qrImg") {
            
    //        let value = loader.ge
            let value = loader.getValueByProperty(tag: tag, property: "src")
            print(value)
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
