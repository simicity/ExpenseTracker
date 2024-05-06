//
//  ExpenseMockData.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/26/24.
//

import Foundation

struct MockData {
    static let expenses: [Expense] = [
        .init(note: "Sushi", amount: 45.8, date: Date(), category: categories[0]),
        .init(note: "Burrito", amount: 45.8, date: Date(), category: categories[0]),
        .init(note: "Thai Food", amount: 45.8, date: Date(), category: categories[0]),
        .init(note: "Chicken", amount: 45.8, date: Date(), category: categories[0]),
        .init(note: "Sushi", amount: 45.8, date: Date(), category: categories[0]),
        .init(note: "Burrito", amount: 45.8, date: Date(), category: categories[0]),
        .init(note: "Thai Food", amount: 45.8, date: Date(), category: categories[0]),
        .init(note: "Chicken", amount: 45.8, date: Date(), category: categories[0]),
    ]
    
    static let categories: [Category] = [
        .init(title: "Food", color: "green"),
        .init(title: "Hobbies", color: "blue"),
        .init(title: "Event", color: "red")
    ]
    
    static let savings: [Saving] = [
        .init(title: "Cyber Truck", amount: 300000, savedAmount: 20000, category: categories[0]),
        .init(title: "Cyber Truck", amount: 300000, savedAmount: 20000, category: categories[0]),
        .init(title: "Cyber Truck", amount: 300000, savedAmount: 20000, category: categories[0]),
    ]
}
