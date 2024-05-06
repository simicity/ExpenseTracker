//
//  HomeView.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/26/24.
//

import SwiftUI
import SwiftData
import SwiftData

struct HomeView: View {

    static var firstDayOfMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date.now)
        var dateComponents = DateComponents()
        dateComponents.year = components.year
        dateComponents.month = components.month
        dateComponents.day = 1
        return calendar.date(from: dateComponents)!
    }
    
    static var lastDayOfMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date.now)
        var lastDayComponents = DateComponents()
        lastDayComponents.year = components.year
        lastDayComponents.month = components.month! + 1
        lastDayComponents.day = 0
        return calendar.date(from: lastDayComponents)!
    }
    
    static var firstDayOfLastMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date.now)
        var dateComponents = DateComponents()
        dateComponents.year = components.year
        dateComponents.month = components.month == 1 ? 12 : components.month! - 1
        dateComponents.day = 1
        return calendar.date(from: dateComponents)!
    }
    
    static var lastDayOfLastMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date.now)
        var lastDayComponents = DateComponents()
        lastDayComponents.year = components.year
        lastDayComponents.month = components.month
        lastDayComponents.day = 0
        return calendar.date(from: lastDayComponents)!
    }

    @Binding var selectedTab: Int
    @Query(filter: #Predicate<Expense> { $0.date >= firstDayOfMonth && $0.date <= lastDayOfMonth }) var thisMonthExpenses: [Expense]
    @Query(filter: #Predicate<Expense> { $0.date >= firstDayOfLastMonth && $0.date <= lastDayOfLastMonth }) var lastMonthExpenses: [Expense]
    @State var budget: Double = UserDefaults.standard.double(forKey: UserDefaultsKey.budget.rawValue)
    @State var showBudgetSetting: Bool = false
    @Binding var animateBudgetButton: Bool
    @Binding var lastMonthRemainingBudget: Double

    private var thisMonthTotalExpense: Double {
        Expense.aggregateExpenses(expenses: thisMonthExpenses)
    }

    private var lastMonthTotalExpense: Double {
        Expense.aggregateExpenses(expenses: lastMonthExpenses)
    }

    private var remainingBudget: Double {        
        budget - thisMonthTotalExpense
    }
    
    private var usedRatio: CGFloat {
        guard budget > 0 else { return 0.0 }
        return thisMonthTotalExpense / budget
    }
    
    func updateBudget() {
        budget = UserDefaults.standard.double(forKey: UserDefaultsKey.budget.rawValue)
        animateBudgetButton = budget == 0
    }

    private var greetingMessage: String {
        let hour = Calendar.current.component(.hour, from: Date.now)
        switch hour {
        case 0..<2:
            return "Good evening!"
        case 2..<12:
            return "Good morning!"
        case 17..<24:
            return "Good evening!"
        default:
            return "Hello!"
        }
    }
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                headerSection
                
                summarySection
                    .padding(.vertical)
                
                wishListSection
                    .padding(.vertical)
                
                recentExpensesSection
                    .padding(.vertical)
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(.customBackground)
        .sheet(isPresented: $showBudgetSetting, onDismiss: updateBudget) {
            BudgetForm()
        }
        .onAppear {
            animateBudgetButton = budget == 0
            lastMonthRemainingBudget = budget - lastMonthTotalExpense
        }
    }
}

#Preview {
    HomeView(selectedTab: .constant(0), animateBudgetButton: .constant(false), lastMonthRemainingBudget: .constant(40.0))
}

extension HomeView {
    
    private var headerSection: some View {
        HStack {
            Text(greetingMessage)
                .font(.title2)
                .fontWeight(.semibold)

            Spacer()
            
            Button {
                showBudgetSetting = true
            } label: {
                Image(systemName: "gearshape")
                    .tint(.customBlack)
                    .font(.title2)
            }
            .background(
                ButtonAnimationView(animate: $animateBudgetButton)
            )
        }
    }
    
    private var summarySection: some View {
        VStack {
            totalExpenseView
            expenseReferenceView
        }
    }
    
    private var totalExpenseView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Total Expenses")
                        .font(.caption)

                    HStack {
                        if lastMonthTotalExpense <= thisMonthTotalExpense {
                            Image(systemName: "arrow.up")
                                .foregroundStyle(.customRed)
                        } else {
                            Image(systemName: "arrow.up")
                                .rotationEffect(.init(degrees: 180))
                                .foregroundStyle(.customGreen)
                        }

                        Text(thisMonthTotalExpense.asCurrencyWith2Decimals())
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    }

                    Text("of \(budget.asCurrencyWith2Decimals())")
                        .font(.caption)
                }
                .padding()
                .foregroundStyle(.customBackground)

                Spacer()
                
                BudgetRingView(progressRatio: usedRatio)
            }
            .background(.customBlack)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }

    private var expenseReferenceView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Last Month's Expenses")
                        .font(.caption)

                    Text(lastMonthTotalExpense.asCurrencyWith2Decimals())
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .padding()
                .foregroundStyle(.customBackground)

                Spacer()
                
                Divider()
                    .background(.customBackground)
                    .padding(.vertical)
                    .frame(width: 2)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Remaining Budget")
                        .font(.caption)

                    Text(remainingBudget.asCurrencyWith2Decimals())
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .padding()
                .foregroundStyle(.customBackground)
            }
            .background(.customBlack)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    private var wishListSection: some View {
        VStack {
            HStack {
                Text("Savings")
                    .font(.title2)
                
                Spacer()
                
                Button {
                    withAnimation(.spring()) {
                        selectedTab = 3
                    }
                } label: {
                    Text("See All")
                        .foregroundStyle(.customTextBlue)
                }
            }
            .fontWeight(.semibold)
            
            HomeSavingList()
        }
    }
    
    private var recentExpensesSection: some View {
        VStack {
            HStack {
                Text("Recent Expenses")
                    .font(.title2)

                Spacer()
                
                Button {
                    withAnimation(.spring()) {
                        selectedTab = 1
                    }
                } label: {
                    Text("See All")
                        .foregroundStyle(.customTextBlue)
                }
            }
            .fontWeight(.semibold)
            
            RecentExpenseList()
        }
    }
    
}
