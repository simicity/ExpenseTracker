//
//  SavingFormView.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/29/24.
//

import SwiftUI
import SwiftData

struct AddSavingItemFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Query var categories: [Category]
    @State private var title = ""
    @State private var amountText: String = ""
    @State private var selectedCategory: Category?

    private var amount: Double {
        if let doubleValue = Double(amountText) {
            doubleValue
        } else {
            0
        }
    }

    var enableAdd: Bool {
        title != "" && amount > 0
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
                    TextField("What do you want to buy?", text: $title)
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
                    Text("Add Saving Item")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let newSaving = Saving(title: title, amount: amount, savedAmount: 0, category: selectedCategory)
                        context.insert(newSaving)
                        dismiss()
                    } label: {
                        Text("Add")
                            .foregroundStyle(enableAdd ? .primary : .tertiary)
                    }
                    .disabled(!enableAdd)
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
    AddSavingItemFormView()
}
