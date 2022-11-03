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

public extension Array {
    mutating func slideForwards(by steps: Int, placing placeholder: Element) {
        for i in 0..<count-1 {
            let indexToPlace = i + steps
            if indexToPlace < count {
                self[i] = self[indexToPlace]
            } else {
                self[i] = placeholder
            }
        }
        self[count-1] = placeholder
    }
    
    mutating func slideBackwards(by steps: Int, placing placeholder: Element) {
        for i in (1..<count).reversed() {
            let indexToPlace = i - steps
            if indexToPlace >= 0 {
                self[i] = self[indexToPlace]
            } else {
                self[i] = placeholder
            }
        }
        self[0] = placeholder
    }
    
    mutating func slide(by delta: Int, placing placeholder: Element) {
        guard delta != 0 else { return }
        if delta < 0 {
            slideBackwards(by: abs(delta), placing: placeholder)
        } else {
            slideForwards(by: delta, placing: placeholder)
        }
    }
}
