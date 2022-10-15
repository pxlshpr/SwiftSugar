import Foundation

public extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
    
    var mostFrequent: Element? {
        mostFrequentWithCounts?.element
    }
    var mostFrequentWithCounts: (element: Element, count: Int)? {
        let counts = reduce(into: [:]) { $0[$1, default: 0] += 1 }
        if let (value, count) = counts.max(by: { $0.1 < $1.1 }) {
            return (value, count)
        }
        // array was empty
        return nil
    }
}
