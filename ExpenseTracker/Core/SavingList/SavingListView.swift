//
//  WishListView.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/27/24.
//

import SwiftUI
import SwiftData
import TipKit

struct SavingListView: View {
    @Query var savings: [Saving]
    @State var showAddSavingItemForm: Bool = false
    @Binding var lastMonthRemainingBudget: Double
    var lastAddedMonthKey: String = UserDefaults.standard.string(forKey: UserDefaultsKey.lastAddedMonth.rawValue) ?? ""
    
    private let savingListTip = SavingListTip()
    
    @State var showDialog: Bool = false
    
    func usedAmountChanged(usedAmount: Double) {
        if usedAmount > 0 {
            for saving in savings {
                saving.savedAmount -= min(saving.savedAmount, usedAmount)
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TipView(savingListTip, arrowEdge: .none)

                ZStack {
                    if savings.isEmpty {
                        ContentUnavailableView("Add your first saving item!", systemImage: "bookmark")
                    } else {
                        SavingList(savings: savings, onChange: usedAmountChanged)
                    }
                }
            }
            .background(.customBackground)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Savings")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                
                if savings.count < Constants.savingListItemLimit {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showAddSavingItemForm = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.title2)
                                .tint(.primary)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert("Hooray! Last month's remaining budget has been added! 🥳🎉",
                   isPresented: $showDialog) {
                Button("OK") {
                    UserDefaults.standard.set(DateFormatter.dateAsYearMonth.string(from: Date.now), forKey: UserDefaultsKey.lastAddedMonth.rawValue)
                    for saving in savings {
                        saving.savedAmount += lastMonthRemainingBudget
                    }
                }
            }
            .sheet(isPresented: $showAddSavingItemForm) {
                AddSavingItemFormView()
            }
            .task {
                try? Tips.configure([
                    .displayFrequency(.immediate),
                    .datastoreLocation(.applicationDefault)
                ])
            }
        }
        .onAppear {
            showDialog = savings.count > 0 && lastMonthRemainingBudget > 0 && lastAddedMonthKey < DateFormatter.dateAsYearMonth.string(from: Date.now)
        }
    }
}

#Preview {
    SavingListView(lastMonthRemainingBudget: .constant(40.0))
}
