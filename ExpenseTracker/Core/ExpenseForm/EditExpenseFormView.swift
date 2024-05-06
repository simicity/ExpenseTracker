//
//  EditExpenseFormView.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/29/24.
//

import SwiftUI
import SwiftData

struct EditExpenseFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    var expense: Expense
    @Query var categories: [Category]
    @State private var note = ""
    @State private var amountText: String = ""
    @State private var date = Date.now
    @State private var selectedCategory: Category?

    init(expense: Expense) {
        self.expense = expense
        _note = State(initialValue: self.expense.note)
        _amountText = State(initialValue: self.expense.amount.asNumberString())
        _date = State(initialValue: self.expense.date)
        _selectedCategory = State(initialValue: self.expense.category)
    }
    
    private var amount: Double {
        if let doubleValue = Double(amountText) {
            doubleValue
        } else {
            0
        }
    }
    
    var enableUpdate: Bool {
        note != "" && amount > 0
        && (
            note != expense.note
            || amount != expense.amount
            || date != expense.date
            || selectedCategory != expense.category
        )
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("$")
                        .font(.title2)
                        .fontWeight(.bold)
                        .offset(x: 4, y: 4)

                    TextField("0.00", text: $amountText)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                
                Divider()

                LabeledContent {
                    TextField("What did you buy?", text: $note)
                } label: {
                    Image(systemName: "note.text")
                }
                .padding(.vertical)

                LabeledContent {
                    Picker("Category", selection: $selectedCategory) {
                        Text("Select Category")
                            .tag(nil as Category?)
                        ForEach(categories, id: \.self) { category in
                            Text(category.title)
                                .tag(category as Category?)
                        }
                    }
                } label: {
                    Image(systemName: "folder")
                }
                .tint(.primary)
                .padding(.bottom)

                LabeledContent {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                } label: {
                    Image(systemName: "calendar")
                }
                
                Spacer()
            }
            .padding()
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Edit Expense")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        expense.note = note
                        expense.amount = amount
                        expense.date = date
                        expense.category = selectedCategory
                        dismiss()
                    } label: {
                        Text("Update")
                            .foregroundStyle(enableUpdate ? .primary : .tertiary)
                    }
                    .disabled(!enableUpdate)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .font(.title2)
            .tint(.primary)
        }
        .padding(.vertical)
    }
}

#Preview {
    EditExpenseFormView(expense: MockData.expenses[0])
}
