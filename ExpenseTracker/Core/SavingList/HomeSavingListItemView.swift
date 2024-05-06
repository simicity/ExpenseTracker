//
//  WishListItemView.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/27/24.
//

import SwiftUI

struct HomeSavingListItemView: View {
    var saving: Saving
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(saving.title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            
            Text(saving.savedPercentage.asPercentString())
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .frame(height: 8)
                        .foregroundStyle(Color(UIColor.systemGray6))
                    
                    Capsule()
                        .frame(width: CGFloat(min(1, saving.savedRatio)) * geometry.size.width, height: 8)
                        .foregroundStyle(Color(hex: saving.category?.color ?? Constants.defaultCategoryColor)!)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    HomeSavingListItemView(saving: MockData.savings[0])
}
