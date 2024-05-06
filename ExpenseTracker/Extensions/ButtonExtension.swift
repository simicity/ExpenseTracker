//
//  ButtonExtension.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/27/24.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(1.0)
            .animation(.bouncy, value: 1)
    }
}
