//
//  HomeWishList.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/27/24.
//

import SwiftUI
import SwiftData

struct HomeSavingList: View {
    @Query(homeSavingListDescriptor) var savings: [Saving]
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        if savings.isEmpty {
            Text("No saving item.")
                .padding(.top)
        } else {
            LazyVGrid(
                columns: columns,
                alignment: .leading,
                spacing: 10,
                pinnedViews: [],
                content: {
                    ForEach(savings, id: \.self) { saving in
                        HomeSavingListItemView(saving: saving)
                    }
                })
        }
    }
    
    static var homeSavingListDescriptor: FetchDescriptor<Saving> {
        var descriptor = FetchDescriptor<Saving>(sortBy: [SortDescriptor(\.savedAmount, order: .reverse)])
        descriptor.fetchLimit = 4
        return descriptor
    }
}

#Preview {
    HomeSavingList()
}
