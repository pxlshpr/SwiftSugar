import Foundation

public extension Double {
    
    var clean: String {
        /// round it off to a reasonable number first to avoid numbers like `7.00000000000009` resulting in `7.0`
        let value = self.rounded(toPlaces: 6).truncatingRemainder(dividingBy: 1)
        if value == 0 {
            return String(format: "%.0f", self.rounded(toPlaces: 2))
        } else {
            return String(self.rounded(toPlaces: 2))
        }
    }

    var cleanWithoutRounding: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }

    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var cleanAmount: String {
        guard self != 0 else {
            return "0"
        }
        
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", self.rounded(toPlaces: 2))
        } else {
            /// Keep trying till we reach 5 decimal places
            for decimalPlaces in 2..<6 {
                let value = self.rounded(toPlaces: decimalPlaces)
                guard value != 0 else {
                    continue
                }
                if value.truncatingRemainder(dividingBy: 1) == 0 {
                    return String(Int(value))
                } else {
                    return String(value)
                }
            }
            return "0"
        }
    }
    
//    var cleanAmount: String {
//        if self.truncatingRemainder(dividingBy: 1) == 0 {
//            return String(format: "%.0f", self.rounded(toPlaces: 2))
//        } else {
////            let value = self.rounded(toPlaces: self > 1 ? 1 : 2)
//            let value = self.rounded(toPlaces: 2)
//            if value.truncatingRemainder(dividingBy: 1) == 0 {
//                return String(Int(value))
//            } else {
//                return String(value)
//            }
//        }
//    }

    //MARK: - Legacy
    var clean_legacy: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    var clean_legacy2: String {
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", self.rounded(toPlaces: 2))
        } else {
            return String(self.rounded(toPlaces: 2))
        }
    }
}
