//
//  BudgetRingView.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 5/2/24.
//

import SwiftUI

struct BudgetRingView: View {
    var progressRatio: CGFloat
    private var ringColor: Color {
        switch progressRatio {
        case 0..<0.8:
            return Color(.customGreen)
        case 0.8..<0.9:
            return Color(.customYellow)
        case 0.9...1:
            return Color(.customRed)
        default:
            return Color(.customGreen)
        }
    }

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    Circle()
                        .stroke(Color(UIColor.systemGray5), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                    
                    Circle()
                        .trim(from: 0, to: progressRatio)
                        .stroke(ringColor, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                }
                .padding()
                .rotationEffect(.init(degrees: -90))
                .frame(height: geometry.size.height)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            }
        }
    }
}

#Preview {
    BudgetRingView(progressRatio: 0.9)
}
