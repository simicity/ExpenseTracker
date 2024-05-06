//
//  WishListItem.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/27/24.
//

import SwiftUI
import SwiftData

@Model
class Saving {
    var title: String
    var amount: Double
    var savedAmount: Double
    var category: Category?

    init(title: String, amount: Double, savedAmount: Double, category: Category? = nil) {
        self.title = title
        self.amount = amount
        self.savedAmount = savedAmount
        self.category = category
    }
    
    var savedRatio: Double {
        amount > 0 ? savedAmount / amount : 0
    }

    var savedPercentage: Double {
        savedRatio * 100
    }
}
