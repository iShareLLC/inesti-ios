//
//  CXUtil.swift
//  iNesti
//
//  Created by Cunqi Xiao on 5/4/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import Foundation

struct CXUtil {
    enum DateTime {
        case yyyy_MM_dd
        case HH_mm_a_MMM_yy
        case MMM_ddc_yyyy // c - comma
        case HH_mm_MMM_ddc_yyyy
        case MM_dd_yyyy_HH_mm
        case custom(format: String)

        var formatter: DateFormatter {
            let formatter = DateFormatter()
            switch self {
            case .yyyy_MM_dd:
                formatter.dateFormat = "yyyy MM dd"
            case .HH_mm_a_MMM_yy:
                formatter.dateFormat = "HH:mm a MMM dd"
            case .MMM_ddc_yyyy:
                formatter.dateFormat = "MMM dd, yyyy"
            case .HH_mm_MMM_ddc_yyyy:
                formatter.dateFormat = "HH:mm MMM dd, yyyy"
            case .MM_dd_yyyy_HH_mm:
                formatter.dateFormat = "MM/dd/yyyy HH:mm"
            case let .custom(format):
                formatter.dateFormat = format
            }
            return formatter
        }

        func string(_ date: Date) -> String {
            return formatter.string(from: date)
        }

        func date(string: String) -> Date? {
            return formatter.date(from: string)
        }
    }

    enum Numeric {
        case integer
        case floating(precision: Int)
        case currency

        private var formatter: NumberFormatter {
            let formatter = NumberFormatter()
            switch self {
            case .integer:
                formatter.numberStyle = .decimal
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 0
            case let .floating(precision):
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.minimumFractionDigits = precision
                formatter.maximumFractionDigits = precision
            case .currency:
                formatter.numberStyle = .currency
                formatter.positivePrefix = "$"
                formatter.roundingIncrement = 0.01
            }
            return formatter
        }

        func string(_ number: NSNumber, format: String = "") -> String? {
            if format != "" {
                return String(format: format, number.doubleValue)
            }
            return formatter.string(from: number)
        }

        func number(_ string: String) -> NSNumber? {
            return formatter.number(from: string)
        }
    }
}
