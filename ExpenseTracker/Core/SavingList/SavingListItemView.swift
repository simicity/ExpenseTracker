//
//  SavingListItemView.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/28/24.
//

import SwiftUI

struct SavingListItemView: View {
    @Environment(\.modelContext) private var context
    var saving: Saving
    @State var showEditSavingItemForm: Bool = false
    var onChange: (Double) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(saving.title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 40)

            HStack {
                Text("Balance")
                    .font(.subheadline)

                Spacer()
                
                Text(saving.savedPercentage.asPercentString())
                    .font(.subheadline)

            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .frame(height: 8)
                        .foregroundStyle(Color(UIColor.systemGray6))
                    
                    Capsule()
                        .frame(width: CGFloat(min(1, saving.savedRatio)) * geometry.size.width, height: 8)
                        .foregroundStyle(.black)
                }
            }

            HStack(alignment: .bottom) {
                Text(saving.savedAmount.asCurrencyWith2Decimals())
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text("of \(saving.amount.asCurrencyWith2Decimals())")
                    .font(.subheadline)
                    .offset(x: -2)
            }
            
        }
        .padding()
        .background(Color(hex: saving.category?.color ?? Constants.defaultCategoryColor)!.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .sheet(isPresented: $showEditSavingItemForm) {
            EditSavingItemFormView(saving: saving)
        }
        .contextMenu {
            if saving.savedRatio >= 1 {
                Button {
                    context.delete(saving)
                    onChange(saving.amount)
                } label: {
                    Label("Buy", systemImage: "checkmark")
                }
            }
            
            Button {
                showEditSavingItemForm = true
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            
            Button(role: .destructive) {
                context.delete(saving)
                showEditSavingItemForm = false
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

#Preview {
    SavingListItemView(saving: MockData.savings[0], onChange: { (number: Double) -> Void in
        print("Anonymous function: Number is \(number)")
    })
}
