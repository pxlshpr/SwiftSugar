import Foundation

public extension String {
    
    func matchesRegex(_ regex: String, caseSensitive: Bool = false) -> Bool {
        let options: String.CompareOptions = caseSensitive ? [.regularExpression] : [.regularExpression, .caseInsensitive]
        return range(of: regex, options: options, range: nil, locale: nil) != nil
    }
    
    //TODO: Rename and document this
    func matches(for regex: String, in text: String) -> [(string: String, position: Int)]? {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            let matches = results.map {
                (string: String(text[Range($0.range, in: text)!]),
                 position: $0.range.lowerBound)
            }
            return matches.count > 0 ? matches : nil
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return nil
        }
    }
}


public extension String {
    
    func capturedGroups(using format: String, caseSensitive: Bool = false, allowCapturingEntireString: Bool = false) -> [String] {
        let range = NSRange(
            startIndex..<endIndex,
            in: self
        )

        /// Create A NSRegularExpression
        let capturePattern = format
        let captureRegex = try! NSRegularExpression(
            pattern: capturePattern,
            options: caseSensitive ? [] : [.caseInsensitive]
        )
        
        /// Find the matching capture groups
        let matches = captureRegex.matches(
            in: self,
            options: [],
            range: range
        )

        guard let match = matches.first else {
            return []
        }
        
        var captureGroups: [String] = []

        /// For each matched range, extract the capture group
        for rangeIndex in 0..<match.numberOfRanges {
            let matchRange = match.range(at: rangeIndex)
            
            /// Ignore matching the entire string unless specified to do so
            if !allowCapturingEntireString && matchRange == range {
                continue
            }
            
            /// Extract the substring matching the capture group
            if let substringRange = Range(matchRange, in: self) {
                let capture = String(self[substringRange])
                captureGroups.append(capture)
            }
        }

        return captureGroups
    }
    
    func firstCapturedGroup(using format: String, caseSensitive: Bool = false) -> String? {
        return capturedGroups(using: format, caseSensitive: caseSensitive).first
    }
    
    func secondCapturedGroup(using format: String, caseSensitive: Bool = false) -> String? {
        let groups = capturedGroups(using: format, caseSensitive: caseSensitive)
        guard groups.count > 1 else { return nil }
        return groups[1]
    }
}
