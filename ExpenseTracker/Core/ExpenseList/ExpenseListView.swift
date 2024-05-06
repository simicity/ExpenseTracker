//
//  ExpenseListView.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/26/24.
//

import SwiftUI

struct ExpenseListView: View {
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            ExpenseList()
            .padding(.horizontal)
            .background(.customBackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Expenses")
                        .font(.title)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    ExpenseListView()
}
