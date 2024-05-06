//
//  MainTabView.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/26/24.
//

import SwiftUI

enum TabItems: Int, CaseIterable{
    case home = 0
    case list
    case stats
    case profile
    
    var imageName: String {
        switch self {
        case .home:
            return "house"
        case .list:
            return "list.bullet.rectangle"
        case .stats:
            return "chart.bar"
        case .profile:
            return "bookmark"
        }
    }
}

struct MainTabView: View {   
    @State var selectedTab = 0
    @State var showSheet: Bool = false
    @State var animateBudgetButton: Bool = false
    @State var lastMonthRemainingBudget: Double = 0.0

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView(selectedTab: $selectedTab, animateBudgetButton: $animateBudgetButton, lastMonthRemainingBudget: $lastMonthRemainingBudget)
                    .tag(0)
                
                ExpenseListView()
                    .tag(1)

                ExpenseStatisticsView()
                    .tag(2)
                
                SavingListView(lastMonthRemainingBudget: $lastMonthRemainingBudget)
                    .tag(3)
            }

            Capsule()
                .frame(height: 110)
                .offset(y: 40)
                .foregroundColor(Color(UIColor.systemBackground))

            Button {
                showSheet = true
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .padding()
                    .background(.customRed)
                    .clipShape(Circle())
                    .offset(y: 20)
            }
            .padding()
            .shadow(color: .black.opacity(0.2), radius: 10)
            
            HStack {
                ForEach(TabItems.allCases, id: \.self) { item in
                    Button {
                        selectedTab = item.rawValue
                        animateBudgetButton = false
                    } label: {
                        CustomTabItem(imageName: item.imageName, isActive: (item.rawValue == selectedTab))
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                    if item.rawValue == TabItems.allCases.count / 2 - 1 {
                        ForEach(0..<10) { _ in
                            Spacer()
                        }
                    }
                }
            }
            .padding(.horizontal)
            .frame(height: 70)
        }
        .sheet(isPresented: $showSheet) {
            AddExpenseFormView()
        }
    }
}

extension MainTabView {
    func CustomTabItem(imageName: String, isActive: Bool) -> some View {
        HStack(alignment: .center) {
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(isActive ? .primary : .secondary.opacity(0.5))
                .frame(width: 25, height: 25)
                .offset(y: 15)
            Spacer()
        }
    }
}

#Preview {
    MainTabView()
}
