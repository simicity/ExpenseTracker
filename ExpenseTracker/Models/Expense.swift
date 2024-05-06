//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/26/24.
//

import SwiftUI
import SwiftData
import OrderedCollections

typealias ExpenseGroup = OrderedDictionary<String, [Expense]>

@Model
class Expense {
    var note: String
    var amount:Double
    var date: Date
    var category: Category?
    
    init(note: String, amount: Double, date: Date, category: Category? = nil) {
        self.note = note
        self.amount = amount
        self.date = date
        self.category = category
    }
}

extension Expense {
    static func getThisMonthExpenses(expenses: [Expense]) -> [Expense] {
        expenses.filter({ expense in
            let ymdToday = Calendar.current.dateComponents([.year, .month], from: Date.now)
            let ymd = Calendar.current.dateComponents([.year, .month], from: expense.date)
            return (ymd.year == ymdToday.year) && (ymd.month == ymdToday.month)
        })
    }
    
    static func getLastMonthExpenses(expenses: [Expense]) -> [Expense] {
        expenses.filter({ expense in
            if let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date.now) {
                let ymdLastMonth = Calendar.current.dateComponents([.year, .month], from: lastMonth)
                let ymd = Calendar.current.dateComponents([.year, .month], from: expense.date)
                return (ymd.year == ymdLastMonth.year) && (ymd.month == ymdLastMonth.month)
            } else {
                return false
            }
        })
    }
    
    static func aggregateExpenses(expenses: [Expense]) -> Double {
        return expenses.reduce(0.0, { $0 + $1.amount })
    }
    
    static func getThisMonthTotalExpense(expenses: [Expense]) -> Double {
        let thisMonthExpenses: [Expense] = getThisMonthExpenses(expenses: expenses)
        return aggregateExpenses(expenses: thisMonthExpenses)
    }
    
    static func getLastMonthTotalExpense(expenses: [Expense]) -> Double {
        let lastMonthExpenses: [Expense] = getLastMonthExpenses(expenses: expenses)
        return aggregateExpenses(expenses: lastMonthExpenses)

    }
}
