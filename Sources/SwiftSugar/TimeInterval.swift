import Foundation

public extension TimeInterval {
    var seconds: Int {
        Int(self) % 60
    }

    var hours: Int {
        Int(self) / 3600
    }
    
    var minutes: Int {
        (Int(self) / 60) % 60
    }
    
    var hoursAsDouble: Double {
        self / 3600.0
    }
    
    var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
    }
}

public extension TimeInterval {

    var durationString: String {
        if hours != 0 {
            return String(format: "%d:%0.2d:%0.2d", hours, minutes, seconds)
        } else if minutes != 0 {
            return String(format: "%d:%0.2d", minutes, seconds)
        } else {
            return String(format: "0:%0.2d", seconds)
        }
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
