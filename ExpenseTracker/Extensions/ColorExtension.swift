//
//  ColorExtension.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 4/29/24.
//

import SwiftUI

extension Color {

    init?(hex: String) {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255

                    self.init(red: r, green: g, blue: b)
                    return
                }
            }
        }

        return nil
    }

    func toHexString() -> String? {
        guard let components = UIColor(self).cgColor.components, components.count >= 3 else {
            return "FFFFFF"
        }

        let red = UInt8(components[0] * 255)
        let green = UInt8(components[1] * 255)
        let blue = UInt8(components[2] * 255)

        return String(format: "#%02X%02X%02X", red, green, blue)
    }

}
