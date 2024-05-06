//
//  DateExtension.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 5/1/24.
//

import Foundation

extension DateFormatter {
    static let dateAsDictKeyFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let dateAsYearMonth: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter
    }()
}
