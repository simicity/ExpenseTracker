//
//  BudgetForm.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 5/1/24.
//

import SwiftUI

struct BudgetForm: View {
    @Environment(\.dismiss) private var dismiss
    var budget: Double = UserDefaults.standard.double(forKey: UserDefaultsKey.budget.rawValue)
    @State private var budgetText: String = ""

    func getDoubleFromString(text: String) -> Double {
        if let doubleValue = Double(text) {
            return doubleValue
        } else {
            return 0.0
        }
    }
    
    var enableSave: Bool {
        budgetText != ""
    }
    
    func saveBudget() {
        let budget = getDoubleFromString(text: budgetText)
        UserDefaults.standard.set(budget, forKey: UserDefaultsKey.budget.rawValue)
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("$")
                        .font(.title2)
                        .fontWeight(.bold)
                        .offset(x: 4, y: 4)

                    TextField("0.00", text: $budgetText)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }

                Text("/month")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .offset(x: 4, y: 4)
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
                    Text("Set Budget")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        saveBudget()
                        dismiss()
                    } label: {
                        Text("Save")
                            .foregroundStyle(enableSave ? .primary : .tertiary)
                    }
                    .disabled(!enableSave)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .font(.title2)
            .tint(.primary)
        }
        .padding(.vertical)
        .onAppear {
            budgetText = budget <= 0 ? "0.00" : budget.asNumberString()
        }
    }
}

#Preview {
    BudgetForm()
}
