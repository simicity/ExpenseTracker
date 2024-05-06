//
//  ExpenseStats.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/26/24.
//

import SwiftUI

struct ExpenseStatisticsView: View {
    var body: some View {
        NavigationView {
            VStack {
                BarChartView()
            }
            .padding()
            .background(.customBackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Statistics")
                        .font(.title)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    ExpenseStatisticsView()
}
