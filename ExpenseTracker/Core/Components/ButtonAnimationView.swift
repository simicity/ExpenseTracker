//
//  buttonAnimationView.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 5/5/24.
//

import SwiftUI

struct ButtonAnimationView: View {
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 1.0) : .none, value: animate)
            .foregroundColor(.customBlack.opacity(0.5))
            .frame(width: 50, height: 50)
    }
}
