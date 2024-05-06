//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/26/24.
//

import SwiftUI
import SwiftData

@main
struct ExpenseTrackerApp: App {
    var container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(container)
    }
    
    init() {
        let addDefaultCategory: Bool = {
            let config = ModelConfiguration("ExpenseTracker")
            let container = try? ModelContainer(for: Category.self, configurations: config)
            
            var fetchDescriptor = FetchDescriptor<Category>()
            fetchDescriptor.fetchLimit = 1
            
            guard let container = container,
                  (try? container.mainContext.fetch(fetchDescriptor))?.count == 0 else { return false }
            return true
        }()
    
        let schema = Schema([Expense.self, Saving.self])
        let config = ModelConfiguration("ExpenseTracker", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Failed to configure SwiftData container.")
        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        
        if addDefaultCategory {
            let defaultCategories: [Category] = [
                .init(title: "Groceries", color: "#FF5722"),
                .init(title: "Dining", color: "#FFA726"),
                .init(title: "Transportation", color: "#4CAF50"),
                .init(title: "Housing", color: "#2196F3"),
                .init(title: "Health and Fitness", color: "#FFC107"),
                .init(title: "Entertainment", color: "#9C27B0"),
                .init(title: "Travel", color: "#FF9800"),
                .init(title: "Utilities", color: "#607D8B"),
                .init(title: "Education", color: "#03A9F4"),
                .init(title: "Debts and Loans", color: "#F44336"),
                .init(title: "Investment", color: "#8BC34A"),
                .init(title: "Gift and Donations", color: "#E91E63"),
                .init(title: "Personal Care", color: "#795548"),
                .init(title: "Insurance", color: "#673AB7"),
                .init(title: "Pets", color: "#9E9E9E"),
                .init(title: "Clothing", color: "#FF4081")
            ]
                
            for category in defaultCategories {
                container.mainContext.insert(category)
            }
        }
    }
}
