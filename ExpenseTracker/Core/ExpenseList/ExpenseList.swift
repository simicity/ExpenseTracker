//
//  ExpenseList.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/27/24.
//

import SwiftUI
import SwiftData
import OrderedCollections

struct ExpenseList: View {
    @Query(expensesDescriptor) var expenses: [Expense]

    private var expensesByDate: ExpenseGroup {
        guard !expenses.isEmpty else { return [:] }
        return ExpenseGroup(grouping: expenses) { DateFormatter.dateAsDictKeyFormat.string(from: $0.date) }
    }

    var body: some View {
        if expenses.isEmpty {
            ContentUnavailableView("Start tracking your expenses!", systemImage: "newspaper")
        } else {
            ScrollView {
                ForEach(Array(expensesByDate), id: \.key) { date, expenses in
                    Section {
                        ForEach(expenses) { expense in ExpenseListItemView(expense: expense)
                        }
                    } header: {
                        if date == DateFormatter.dateAsDictKeyFormat.string(from: Date.now) {
                            Text("Today")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                                .padding(.top)
                        } else {
                            Text(date.dateParsed(), format: .dateTime.year().month().day())
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                                .padding(.top)
                        }
                    }
                }
            }
        }
    }
    
    static var expensesDescriptor: FetchDescriptor<Expense> {
        let descriptor = FetchDescriptor<Expense>(sortBy: [SortDescriptor(\.date, order: .reverse)])
        return descriptor
    }
}

#Preview {
    ExpenseList()
}
