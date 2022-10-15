import XCTest
@testable import SwiftSugar

final class SwiftSugarTests: XCTestCase {
    func testExample() throws {
        let array = ["a", "b", "a", "c", "a", "b"]
        XCTAssertEqual(array.mostFrequent, "a")
        
        let array2 = [1, 1, 2, 1, 2, 1, 2, 2, 1, 1, 1, 2, 2, 2, 2]
        XCTAssertEqual(array2.mostFrequent, 2)
    }
}
