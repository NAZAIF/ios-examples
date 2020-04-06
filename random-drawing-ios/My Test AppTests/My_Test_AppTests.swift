//
//  My_Test_AppTests.swift
//  My Test AppTests
//
//  Created by Moideen Nazaif VM on 08/01/20.
//  Copyright © 2020 Moideen Nazaif VM. All rights reserved.
//

import XCTest

class My_Test_AppTests: XCTestCase {

 
    func testSample() {
        let blah = "blah"
        XCTAssertEqual("blah", blah)
    }
    
    func testSampleNull() {
        var str: String?
        XCTAssertTrue(str == nil)
    }
   

}
