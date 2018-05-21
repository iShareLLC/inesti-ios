//
//  Date+Extension.swift
//  iNesti
//
//  Created by Zian Chen on 5/20/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import Foundation

extension Date {
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    // https://stackoverflow.com/questions/30083756/ios-nsdate-returns-incorrect-time/30084248#30084248
    func getCurrentLocalizedDate() -> Date {
        var now = self //Date()
        var nowComponents = DateComponents()
        let calendar = Calendar.current
        nowComponents.year      = Calendar.current.component(.year, from: now)
        nowComponents.month     = Calendar.current.component(.month, from: now)
        nowComponents.day       = Calendar.current.component(.day, from: now)
        nowComponents.hour      = Calendar.current.component(.hour, from: now)
        nowComponents.minute    = Calendar.current.component(.minute, from: now)
        nowComponents.second    = Calendar.current.component(.second, from: now)
        nowComponents.timeZone  = TimeZone(abbreviation: "GMT")!
        now = calendar.date(from: nowComponents)!
        return now as Date
    }
    
    static func getTimestampNow() -> Int {
        return Int(NSDate().timeIntervalSince1970)
    }
    
    static func getTimeString(format: String, time: TimeInterval) -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date(timeIntervalSince1970: time))
    }
    
    static func getFutureDateFromNow(year: Int = 0, month: Int = 0, day: Int = 0) -> Date? {
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.month = month
        dateComponent.day = day
        dateComponent.year = year
        return Calendar.current.date(byAdding: dateComponent, to: currentDate)
    }
}
