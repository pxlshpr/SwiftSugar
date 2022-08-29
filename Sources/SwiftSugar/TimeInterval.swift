import Foundation

public extension TimeInterval {
    var hours: Int {
        Int(self) / 3600
    }
    
    var minutes: Int {
        (Int(self) / 60) % 60
    }
}

public extension TimeInterval {
    var seconds: Int {
        Int(self) % 60
    }

    var hoursAsDouble: Double {
        self / 3600.0
    }

    //TODO: Rename to description
    var stringTime: String {
        let min = minutes > 1 ? "mins" : "min"
        if hours != 0 {
            let hr = hours > 1 ? "hrs" : "hr"
            if minutes > 0 {
                return "\(hours) \(hr) \(minutes) \(min)"
            } else {
                return "\(hours) \(hr)"
            }
        } else if minutes != 0 {
            return "\(minutes) \(min)"
        } else {
            return "<1 min"
        }
    }
}

public extension TimeInterval {

    //TODO: Rename to shortDescription
    var shortStringTime: String {
        if hours != 0 {
            if minutes > 0 {
                return "\(hoursAsDouble.rounded(toPlaces: 1).cleanAmount)h"
            } else {
                return "\(hours)h"
            }
        } else if minutes != 0 {
            return "\(minutes)m"
        } else {
            return "<1m"
        }
    }
}
