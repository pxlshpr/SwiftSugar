import XCTest
@testable import SwiftSugar

final class SwiftSugarTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let pattern = #"(?:^|[ ]+)([0-9.,]+)"#
        let text = "Setiap 100g"
        let groups = text.capturedGroups(using: pattern, allowCapturingEntireString: true)
        print("We're here")
    }
    
    func matches(for regex: String, in text: String) -> [(string: String, position: Int)] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                (string: String(text[Range($0.range, in: text)!]),
                 position: $0.range.lowerBound)
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func testRegex() throws {
        
//        let string = "🇩🇪€4€9"
        let string = "€4€9"

        let matched = matches(for: "[0-9]", in: string)
        
//        let regex = "[0-9]"
//        let matched = string.capturedGroups(using: regex)
        
        print(matched)
        // ["4", "9"]
    }
}
