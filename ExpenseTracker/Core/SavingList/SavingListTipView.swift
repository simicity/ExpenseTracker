//
//  SavingListTipView.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 5/2/24.
//

import SwiftUI
import TipKit

struct SavingListTip: Tip {
    var title: Text {
        Text("What's Saving List?")
    }
 
    var message: Text? {
        Text("At the end of each month, any remaining is automatically added to each item's balance. When you've saved up enough, you can buy the desired item(s). Upon purchase, the amount you spent will be deducted from each item's balance.")
    }
}
