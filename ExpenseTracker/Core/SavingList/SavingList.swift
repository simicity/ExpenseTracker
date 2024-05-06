//
//  WishList.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/27/24.
//

import SwiftUI

struct SavingList: View {
    var savings: [Saving]
    var onChange: (Double) -> Void

    var body: some View {
        ScrollView {
            VStack {
                ForEach(savings, id: \.self) { saving in
                    SavingListItemView(saving: saving, onChange: onChange)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    SavingList(savings: MockData.savings, onChange: { (number: Double) -> Void in
        print("Anonymous function: Number is \(number)")
    })
}
