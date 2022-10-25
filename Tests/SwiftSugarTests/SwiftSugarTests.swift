import XCTest
@testable import SwiftSugar

final class SwiftSugarTests: XCTestCase {
    func testMostFrequent() throws {
        let array = ["a", "b", "a", "c", "a", "b"]
        XCTAssertEqual(array.mostFrequent, "a")
        
        let array2 = [1, 1, 2, 1, 2, 1, 2, 2, 1, 1, 1, 2, 2, 2, 2]
        XCTAssertEqual(array2.mostFrequent, 2)
        
        let array3 = [0.35, 0.3, 0.22, 0.36, 1.25, 100.2, 0.22, 5]
        XCTAssertEqual(array3.mostFrequent, 0.22)
    }
    
    func testIsValidUrl() throws {
        let testCases = [
            "https://google.com": true,
            "Https://google.com/hello": true,
            "www.googlea.com": true,
            "https://you.test.com/0003-example": true,
            "google.subdomain.com": true,
            "googlecom": false,
            "hello there.com": false
        ]
        
        for (urlString, isValidUrl) in testCases {
            XCTAssertEqual(urlString.isValidUrl, isValidUrl, "\(urlString) failed")
        }
    }
}
