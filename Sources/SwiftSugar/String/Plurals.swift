import Foundation

public let Plurals: [String: String] = [
    "berry": "berries",
    "bottle": "bottles",
    "box": "boxes",
    
    "container": "containers",
    "cookie": "cookies",
    "cup": "cups",
    
    "fluid ounce": "fluid ounces",
    
    "gallon": "gallons",
    "gummy": "gummies",
    
    "pack": "packs",
    "package": "packages",
    "piece": "pieces",
    "pint": "pints",
    
    "quart": "quarts",
    
    "scoop": "scoops",
    "serving": "servings",
    "slice": "slices",
    
    "tablespoon": "tablespoons",
    "teaspoon": "teaspoons",
]


public extension String {
    var plural: String {
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
    
    func pluralizedFor(_ amount: Double) -> String {
        let rounded = amount.rounded(toPlaces: amount < 1 ? 2 : 1)
        if rounded >= 2 {
            return self.plural
//            return "\(self)s"
        } else {
            return self
        }
    }
}
