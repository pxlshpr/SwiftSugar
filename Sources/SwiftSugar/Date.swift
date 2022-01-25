import Foundation

public extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var relativeDateString: String {
        if Calendar.current.isDateInToday(self) { return "Today" }
        if Calendar.current.isDateInYesterday(self) { return "Yesterday" }
        if Calendar.current.isDateInTomorrow(self) { return "Tomorrow" }
        
        //      let weekday = Calendar.current.component(.weekday, from: date)
        let df = DateFormatter()
        let weekday = df.weekdaySymbols[Calendar.current.component(.weekday, from: self) - 1]
        
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: self)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        let weeks = Double(components.day ?? 0)/7.0
        let weeksInt = Int(weeks)
        if weeks < 0 {
            if weeks > -1 {
                return "Last \(weekday)"
            } else {
                return "\(weekday), \(abs(weeksInt) == 1 ? "a" : "\(abs(weeksInt))") week\(abs(weeksInt) > 1 ? "s" : "") ago"
            }
        } else {
            if weeks < 1 {
                return "\(weekday)"
            } else if weeks < 2 {
                return "Next \(weekday)"
            } else {
                return "\(weekday), in \(abs(weeksInt)) weeks"
            }
        }
    }
}

