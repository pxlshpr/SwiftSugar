import Foundation

public extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var isNowToTheMinute: Bool {
        equalsIgnoringSeconds(Date())
    }

    func equalsIgnoringSeconds(_ other: Date) -> Bool {
        day == other.day
        && month == other.month
        && year == other.year
        && hour == other.hour
        && minute == other.minute
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
    
    var shortTime: String {
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: self)
        
        let formatter = DateFormatter()
        if minutes == 0 {
            formatter.dateFormat = "h a"
        } else {
            formatter.dateFormat = "h:mm a"
        }
        return formatter.string(from: self).lowercased()
    }
}

public func date(hour: Int, minute: Int = 0, of date: Date = Date()) -> Date {
    guard hour < 48 else { return date }
    let actualDate: Date
    let actualHour: Int
    if hour > 23 {
        actualHour = hour - 24
        actualDate = date.addingTimeInterval(24 * 3600)
    } else {
        actualHour = hour
        actualDate = date
    }
    return Calendar.current.date(bySettingHour: actualHour,
                                 minute: minute,
                                 second: 0, of: actualDate)!
}


public extension Date {
    var hourString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter.string(from: self)
    }
    
    func h(_ hour: Int, r randomizeComponents: Bool = false) -> Date {
        guard hour < 24 else { return self }
        let minute: Int = randomizeComponents ? Int.random(in: 0...59) : 0
        let second: Int = randomizeComponents ? Int.random(in: 0...59) : 0
        let date = Calendar.current.date(
            bySettingHour: hour,
            minute: minute,
            second: second,
            of: self)!
        return date
    }
    func h(_ h: Int, m: Int, s: Int) -> Date {
        guard h < 24, m < 60, s < 60 else { return self }
        return Calendar.current.date(bySettingHour: h, minute: m, second: s, of: self)!
    }
}


//** New **
public extension Date {
    var d: Int { day }
    var h: Int { hour }
    var m: Int { minute }
    var atCurrentHour: Date {
        Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: self)!
    }
    
    var atNextHour: Date {
        if hour == 23 {
            let nextDay = self.moveDayBy(1)
            return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: nextDay)!
        } else {
            return Calendar.current.date(bySettingHour: hour + 1, minute: 0, second: 0, of: self)!
        }
    }
    
    var atClosestHour: Date {
        if m < 30 {
            return atCurrentHour
        } else {
            return atNextHour
        }
    }
    
    func movingHourBy(_ increment: Int) -> Date {
        var components = DateComponents()
        components.hour = increment
        return Calendar.current.date(byAdding: components, to: self)!
    }
}
