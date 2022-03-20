import Foundation

public extension StringProtocol {
    var byWords: [SubSequence] {
        var byWords: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            byWords.append(self[range])
        }
        return byWords
    }
}

public extension String {
    
    func pluralized(_ plural: Bool) -> String {
        /// if we have a word like "baked doughnuts (large)", only grab "baked" doughnuts", get its singular version and replace it
        if let withoutParentheses = firstCapturedGroup(using: #"(.*)[ ]*\(.*\)"#) {
            return self.replacingLastOccurrence(
                of: withoutParentheses,
                with: withoutParentheses.pluralized(plural)
            )
        }
        
        /// try and get the entry for the entire word itself
        if plural {
            if let entry = Plurals.first(where: { $0.key == self.lowercased() }) {
                return entry.value
            }
        } else {
            if let entry = Plurals.first(where: { $0.value == self.lowercased() }) {
                return entry.key
            }
        }
        
        /// check if we have multiple words and if the last word can be made singular
        if byWords.count > 1, let lastWord = byWords.last {
            return self.replacingLastOccurrence(
                of: String(lastWord),
                with: String(lastWord).pluralized(plural))
        }
        
        /// return the original string if all else fails
        return self
    }
    
    var singular: String {
        pluralized(false)
    }
    
    var plural: String {
        pluralized(true)
    }
    
    var plural_legacy: String {
        let string: String
        
        if let plural = Plurals[lowercased()] {
//        if self.matchesRegex(#"^[^ ]*$"#) {
//            /// if there are no spaces
//            guard let plural = Plurals[lowercased()] else {
//                return self
//            }
            string = plural
            
        } else if let firstWord = self.firstCapturedGroup(using: #"^([^ ]*).*"#), let plural = Plurals[firstWord.lowercased()] {
            /// if the first word can be pluralized
            string = replacingOccurrences(of: firstWord, with: plural)
            
        } else {
            /// fallback
            string = self
        }
        
        if self.capitalized == self {
            return string.capitalized
        } else {
            return string
        }
    }

    func pluralizedFor(_ amount: Int) -> String {
        pluralizedFor(Double(amount))
    }
    
    func pluralizedFor(_ amount: Double) -> String {
        let rounded = amount.rounded(toPlaces: amount < 1 ? 2 : 1)
        if rounded >= 2 {
            return self.plural
//            return "\(self)s"
        } else {
            return self.singular
        }
    }
    
    var pluralEntry: Dictionary<String, String>.Element? {
        Plurals.first(where: { $0.key == self || $0.value == self })
    }
}
