import Foundation

public extension TimeInterval {
    var hours: Int {
        Int(self) / 3600
    }
    
    var minutes: Int {
        (Int(self) / 60) % 60
    }
}
