//
//  RecentExpenseList.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/27/24.
//

import SwiftUI
import SwiftData

struct RecentExpenseList: View {
    @Query(recentExpensesDescriptor) var expenses: [Expense]

    var body: some View {
        if expenses.isEmpty {
            Text("No expense found.")
                .padding(.top)
        } else {
            VStack {
                ForEach(expenses, id: \.self) { expense in
                    ExpenseListItemView(expense: expense)
                }
            }
        }
    }
    
    static var recentExpensesDescriptor: FetchDescriptor<Expense> {
        var descriptor = FetchDescriptor<Expense>(sortBy: [SortDescriptor(\.date, order: .reverse)])
        descriptor.fetchLimit = 5
        return descriptor
    }
}

#Preview {
    RecentExpenseList()
}
