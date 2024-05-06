//
//  Category.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/27/24.
//

import SwiftUI
import SwiftData

@Model
class Category {
    @Attribute(.unique) var title: String
    var color: String
    @Relationship(deleteRule: .nullify, inverse: \Expense.category)
    var expenses: [Expense]?
    @Relationship(deleteRule: .nullify, inverse: \Saving.category)
    var savings: [Saving]?
    
    init(title: String, color: String) {
        self.title = title
        self.color = color
    }
    
    static func getIcon(title: String) -> Image {
        switch title {
        case "Groceries":
            return Image(systemName: "carrot")
        case "Food":
            return Image(systemName: "carrot")
        case "Transportation":
            return Image(systemName: "bus")
        case "Housing":
            return Image(systemName: "house")
        case "Health and Fitness":
            return Image(systemName: "figure.run")
        case "Entertainment":
            return Image(systemName: "popcorn")
        case "Travel":
            return Image(systemName: "airplane")
        case "Utilities":
            return Image(systemName: "wrench.and.screwdriver")
        case "Education":
            return Image(systemName: "graduationcap")
        case "Debts and Loans":
            return Image(systemName: "banknote.fill")
        case "Investments":
            return Image(systemName: "banknote")
        case "Gifts and Donations":
            return Image(systemName: "gift")
        case "Personal Care":
            return Image(systemName: "heart")
        case "Insurance":
            return Image(systemName: "shield")
        case "Pets":
            return Image(systemName: "dog")
        case "Cloting":
            return Image(systemName: "tshirt")
        default:
            return Image(systemName: "wallet.pass")
        }
    }
    
    func getColor() -> Color {
        return Color(hex: self.color)!
    }
}
