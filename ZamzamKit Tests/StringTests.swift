//
//  StringHelper.swift
//  ZamzamKit
//
//  Created by Basem Emara on 1/20/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import ZamzamKit

class StringTests: XCTestCase {
    
    func testReplaceRegEx() {
        let value = "my car reg 1 - dD11 AAA  my car reg 2 - AA22 BbB"
        let pattern = "([A-HK-PRSVWY][A-HJ-PR-Y])\\s?([0][2-9]|[1-9][0-9])\\s?[A-HJ-PR-Z]{3}"
        
        // Case insensitive
        let newValue = value.replace(regex: pattern, with: "XX", caseSensitive: false)
        let expectedValue = "my car reg 1 - XX  my car reg 2 - XX"
        XCTAssertEqual(newValue, expectedValue,
            "String should be \(expectedValue)")
        
        // Case sensitive
        let newValue2 = value.replace(regex: pattern, with: "XX", caseSensitive: true)
        XCTAssertEqual(newValue2, value,
            "String should be \(expectedValue)")
    }
    
    func testEmailRegEx() {
        let value = "contact@zamzam.io"
        let wrong = "zamzam"
        
        XCTAssertTrue(value.isEmail, "Email \(value) should be valid.")
        XCTAssertFalse(wrong.isEmail, "Email \(value) should not be valid.")
    }
    
    func testNumberRegEx() {
        let value = "123456789"
        let wrong = "zamzam"
        
        XCTAssertTrue(value.isNumber, "Number \(value) should be valid.")
        XCTAssertFalse(wrong.isNumber, "Number \(value) should not be valid.")
    }
    
    func testAlphaRegEx() {
        let value = "zamzam"
        let wrong = "zamzam123"
        
        XCTAssertTrue(value.isAlpha, "Alpha \(value) should be valid.")
        XCTAssertFalse(wrong.isAlpha, "Alpha \(value) should not be valid.")
    }
    
    func testAlphaNumbericRegEx() {
        let value = "zamzam123"
        let wrong = "zamzam!"
        
        XCTAssertTrue(value.isAlphaNumeric, "Alphanumberic \(value) should be valid.")
        XCTAssertFalse(wrong.isAlphaNumeric, "Alphanumberic \(value) should not be valid.")
    }
}

extension StringTests {
	
	func testRandom() {
		XCTAssertEqual(String(random: 10).count, 10)
        
        let test = String(random: 20, prefix: "TEST: ")
        XCTAssertEqual(test.count, 26)
        XCTAssertTrue(test.hasPrefix("TEST: "))
	}
	
	func testIsNilOrEmpty() {
        var test: String?
        
		XCTAssertTrue(test.isNilOrEmpty)
        XCTAssertFalse(!test.isNilOrEmpty)
        
        test = ""
		XCTAssertTrue(test.isNilOrEmpty)
        XCTAssertFalse(!test.isNilOrEmpty)
        
        test = "abc"
		XCTAssertFalse(test.isNilOrEmpty)
        XCTAssertTrue(!test.isNilOrEmpty)
	}
	
	func testTruncated() {
        let test = "Abcdef123456"
        let expected = "Abc..."
        XCTAssertEqual(test.truncated(3), expected)
    }
}

extension StringTests {
    
    func testSeparator() {
        XCTAssertEqual("Abcdef123456".separate(every: 3, with: "-"), "Abc-def-123-456")
        XCTAssertEqual("Abcd".separate(every: 6, with: ":"), "Abcd")
        XCTAssertEqual("Abcdef123456".separate(every: 0, with: "-"), "Abcdef123456")
        XCTAssertEqual("Abcdef123456".separate(every: 1, with: "-"), "A-b-c-d-e-f-1-2-3-4-5-6")
        XCTAssertEqual("Abcdef123456".separate(every: 12, with: "-"), "Abcdef123456")
        XCTAssertEqual("Abcdef123456".separate(every: 11, with: "-"), "Abcdef12345-6")
        XCTAssertEqual("".separate(every: 6, with: ":"), "")
    }
}

extension StringTests {
    
    func testSubscript() {
        let test = "Abcdef123456"
        let expected = "d"
        XCTAssertEqual(test[3]!, expected)
    }
    
    func testSubscriptRange() {
        let test = "Abcdef123456"
        
        XCTAssertEqual(test[3..<6]!, "def")
        XCTAssertEqual(test[3...6]!, "def1")
        XCTAssertEqual(test[3...]!, "def123456")
    }
}

extension StringTests {
    
    func testBase64Encoded() {
        let test = "Abcdef123456"
        let expected = "QWJjZGVmMTIzNDU2"
        XCTAssertEqual(test.base64Encoded, expected)
    }
    
    func testBase64Decoded() {
        let test = "NjU0MzIxRmVkY2Jh"
        let expected = "654321Fedcba"
        XCTAssertEqual(test.base64Decoded, expected)
    }
}
