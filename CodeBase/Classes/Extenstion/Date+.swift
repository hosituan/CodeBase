//
//  Date+.swift
//  Golfull
//
//  Created by Hồ Sĩ Tuấn on 22/07/2021.
//

import Foundation
import UIKit

public extension Date {
    func toLongString() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        return df.string(from: self)
    }
    
    func toString() -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: self)
    }
    
    func getTime() -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func getAge() -> Int {
        return (Date() - (self)).year ?? 0
    }
    
    func toTime() -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func getUTCDateString(format: String) -> String {
        let dateFormatter = DateFormatter.gregorianInit()
        dateFormatter.timeZone = TimeZone(secondsFromGMT:0)
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    static func toString(_ date: Date?) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date ?? Date())
    }
    
    init(_ dateString: String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy/MM/dd"
        let d = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:d)
    }
    
    static func -(recent: Date, previous: Date) -> (year: Int?, month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let year = Calendar.current.dateComponents([.year], from: previous, to: recent).year
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second
        
        return (year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }
    
    static func birthdayDefaultDateFromNow(toPastYear: Int) -> Date? {
        let nowYearStr = Date().getUTCDateString(format: "yyyy")
        if let year = Int(nowYearStr) {
            return "\(year-toPastYear)/01/01".toDate("yyyy/MM/dd")
        }
        return nil
    }
}

public extension Date {
    func rounded(minutes: TimeInterval) -> Date {
        return rounded(seconds: minutes * 60)
    }
    func rounded(seconds: TimeInterval) -> Date {
        var roundedInterval: TimeInterval = 0
        roundedInterval = ceil(timeIntervalSinceReferenceDate / seconds) * seconds
        return Date(timeIntervalSinceReferenceDate: roundedInterval)
    }
}

extension Date {
//    func getPastTime() -> String {
//        var secondsAgo = Int(Date().timeIntervalSince(self))
//        if secondsAgo < 0 {
//            secondsAgo = secondsAgo * (-1)
//        }
//
//        let minute = 60
//        let hour = 60 * minute
//        let day = 24 * hour
//        let week = 7 * day
//
//        if secondsAgo < minute  {
//            return Strings.timeAgoJustNow
//        } else if secondsAgo < hour {
//            let min = secondsAgo/minute
//            return Strings.timeAgo(minutes: min)
//        } else if secondsAgo < day {
//            let hr = secondsAgo/hour
//            return Strings.timeAgo(hours: hr)
//        } else if secondsAgo <= week {
//            let day = secondsAgo/day
//            return Strings.timeAgo(days: day)
//        } else {
//            return self.toString()
//        }
//    }
}


extension Date {
    func toZero() -> Date? {
        guard let zeroDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self))
        else {
            return self
        }
        return zeroDate
    }
}
