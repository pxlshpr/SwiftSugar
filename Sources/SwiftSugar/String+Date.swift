import Foundation

public extension String {
    
    var dateFromTimestamp: Date? {
        guard let timeInterval = TimeInterval(self) else {
            return nil
        }
        return Date(timeIntervalSince1970: timeInterval)
    }
}
