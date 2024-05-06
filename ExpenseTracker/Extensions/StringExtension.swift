//
//  StringExtension.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 5/1/24.
//

import Foundation

extension String {
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.dateAsDictKeyFormat.date(from: self) else { return Date() }
        return parsedDate
    }
}
