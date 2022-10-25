//#if os(iOS) || os(macOS)
import Foundation
//
//@available(macOS 12, *)
//public extension String {
//    var isValidURL: Bool {
//        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
//        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
//            // it is a link, if the match covers the whole string
//            return match.range.length == self.utf16.count
//        } else {
//            return false
//        }
//    }
//}
//#else

public extension String {
    
    var isValidUrl: Bool {
        guard !contains(" ") else { return false }
        
        /// Taken from [this StackOverflow answer](https://stackoverflow.com/a/3809435).
        let regex = #"[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)"#
        return self.matchesRegex(regex)
    }
}

//#endif
