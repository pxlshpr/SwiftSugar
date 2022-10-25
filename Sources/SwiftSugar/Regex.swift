import Foundation

//TODO: Refactor this
public struct NumberRegex {
    
    /// Recognizes number in a string using comma as decimal place (matches `39,3` and `2,05` but not `2,000` or `1,2,3`)
    public static let usingCommaAsDecimalPlace = #"^[0-9]*,[0-9][0-9]?([^0-9]|$)"#
    
    /// We previously had this but was incorrectly recognizing strings like `1,170` as `1.17`
//    public static let usingCommaAsDecimalPlace = #"^[0-9]*,[0-9][0-9]*([^0-9]|$)"#
    
    public static let isFraction = #"^([0-9]+)\/([0-9]+)"#
}

