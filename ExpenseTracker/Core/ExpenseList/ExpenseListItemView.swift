//
//  ExpenseListItemView.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/27/24.
//

import SwiftUI

struct ExpenseListItemView: View {
    @Environment(\.modelContext) private var context
    var expense: Expense
    @State var showEditExpenseItemForm: Bool = false
    
    var body: some View {
        HStack {
            Category.getIcon(title: expense.category?.title ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .padding()
                .foregroundStyle(Color(hex: expense.category?.color ?? Constants.defaultCategoryColor)!)
                .background(Color(hex: expense.category?.color ?? Constants.defaultCategoryColor)!.opacity(0.5))
                .clipShape(Circle())
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(expense.note)
                        .font(.headline)
                        .fontWeight(.semibold)

                    if let category = expense.category {
                        Text(category.title)
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            Text(expense.amount.asCurrencyWith2Decimals())
                .font(.headline)
                .fontWeight(.semibold)
            
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .sheet(isPresented: $showEditExpenseItemForm) {
            EditExpenseFormView(expense: expense)
        }
        .contextMenu {
            Button {
                showEditExpenseItemForm = true
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            
            Button(role: .destructive) {
                context.delete(expense)
                showEditExpenseItemForm = false
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

#Preview {
    ExpenseListItemView(expense: MockData.expenses[0])
}
