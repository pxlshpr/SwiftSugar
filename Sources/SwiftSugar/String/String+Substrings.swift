import Foundation

public extension String {
    func replacingLastOccurrence(of searchString: String,
            with replacementString: String,
            caseInsensitive: Bool = false) -> String
    {
        let options: String.CompareOptions
        if caseInsensitive {
            options = [.backwards, .caseInsensitive]
        } else {
            options = [.backwards]
        }

        if let range = self.range(of: searchString,
                options: options,
                range: nil,
                locale: nil) {

            return self.replacingCharacters(in: range, with: replacementString)
        }
        return self
    }
    
    func replacingFirstOccurrence(of target: String, with replacement: String) -> String {
        guard let range = self.range(of: target) else { return self }
        return self.replacingCharacters(in: range, with: replacement)
    }
    
    var trimmingWhitespaces: String {
        trimmingCharacters(in: .whitespaces)
    }
}
