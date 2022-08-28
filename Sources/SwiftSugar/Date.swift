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

public extension Date {
    
    static var timestamp: Int64 {
        Date().timestamp
    }
    
    var timestamp: Int64 {
        Int64(self.timeIntervalSince1970)
    }
    
    var year: Int {
        Calendar.current.dateComponents([.year], from: self).year ?? 0
    }

    var month: Int {
        Calendar.current.dateComponents([.month], from: self).month ?? 0
    }

    var day: Int {
        Calendar.current.dateComponents([.day], from: self).day ?? 0
    }

    var hour: Int {
        Calendar.current.dateComponents([.hour], from: self).hour ?? 0
    }

    var minute: Int {
        Calendar.current.dateComponents([.minute], from: self).minute ?? 0
    }

    var second: Int {
        Calendar.current.dateComponents([.second], from: self).second ?? 0
    }

    var dayViewTitle: String {
        if Calendar.current.isDateInToday(self) { return "Today" }
        if Calendar.current.isDateInYesterday(self) { return "Yesterday" }
        if Calendar.current.isDateInTomorrow(self) { return "Tomorrow" }
        
        let formatter = DateFormatter()
        let sameYear = year == Date().year
        formatter.dateFormat = sameYear ? "E, d MMM" : "E, d MMM yy"
        return formatter.string(from: self)
    }
}

public extension Date {
    func numberOfDaysFrom(_ fromDate: Date) -> Int {
        let fromDate = fromDate.startOfDay
        let toDate = startOfDay
        let numberOfDays = Calendar.current.dateComponents([.day], from: fromDate, to: toDate)
        return numberOfDays.day ?? 0
    }
    
    func numberOfWeeksFrom(_ fromDate: Date) -> Int {
//        let numberOfDays = numberOfDaysFrom(fromDate)
//        return Int(Double(numberOfDays) / 7.0)
        var calendar = Calendar.autoupdatingCurrent
        calendar.firstWeekday = 2 /// Start on Monday (or 1 for Sunday)
        let fromDateWeek = calendar.component(.weekOfYear, from: fromDate.startOfDay)
        let week = calendar.component(.weekOfYear, from: startOfDay)
        return week - fromDateWeek
//        return calendar.dateComponents([.weekOfYear], from: fromDate.startOfDay, to: startOfDay).weekOfYear ?? 0
    }
}

public extension Date {
    func moveDayBy(_ dateIncrement: Int) -> Date {
        var components = DateComponents()
        components.day = dateIncrement
        return Calendar.current.date(byAdding: components, to: self)!
    }
}


public extension Date {
    var isToday: Bool {
        startOfDay == Date().startOfDay
    }
    
    var isYesterday: Bool {
        startOfDay == Date().startOfDay.addingTimeInterval(-24 * 3600)
    }
    
    var isTomorrow: Bool {
        startOfDay == Date().startOfDay.addingTimeInterval(24 * 3600)
    }

    func longDateString(onlyShowYearIfNotCurrent: Bool = false) -> String {
        let formatter = DateFormatter()
        if onlyShowYearIfNotCurrent, self.year == Date().year {
            formatter.dateFormat = "EEEE d MMM"
        } else {
            formatter.dateFormat = "EEEE d MMM yyyy"
        }
        return formatter.string(from: self)
    }
}

