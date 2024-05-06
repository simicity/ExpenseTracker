//
//  BarChartView.swift
//  ExpenseTracker
//
//  Created by Miho Shimizu on 5/2/24.
//

import SwiftUI
import SwiftData
import Charts

enum TimeRange: Int, CaseIterable, Identifiable {
    case week = 0, month, year, all

    var label: String {
        switch self {
        case .week:
            "1W"
        case .month:
            "1M"
        case .year:
            "1Y"
        case .all:
            "ALL"
        }
    }
    
    var unit: Calendar.Component {
        switch self {
        case .week:
            .day
        case .month:
            .day
        case .year:
            .month
        case .all:
            .year
        }
    }
    
    var id: Self {
        return self
    }
}

struct BarChartView: View {

    private var date7DaysAgo: Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = -7
        return calendar.date(byAdding: dateComponents, to: Date())!
    }

    private var date1MonthAgo: Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = -1
        return calendar.date(byAdding: dateComponents, to: Date())!
    }

    private var date1YearAgo: Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = -1
        return calendar.date(byAdding: dateComponents, to: Date())!
    }

    @Query(sort: \Expense.category?.title) var expenses: [Expense]
    @State var selectedTimeRange: TimeRange = .month
    private var expenseData: [Expense] {
        switch selectedTimeRange {
        case .week:
            expenses.filter({ Date.now >= $0.date && $0.date >= date7DaysAgo })
        case .month:
            expenses.filter({ Date.now >= $0.date && $0.date >= date1MonthAgo })
        case .year:
            expenses.filter({ Date.now >= $0.date && $0.date >= date1YearAgo })
        case .all:
            expenses
        }
    }

    var body: some View {
        VStack {
            rangePicker
            
            if expenses.isEmpty {
                ContentUnavailableView("No data to show yet.", systemImage: "chart.xyaxis.line")
            } else {
                barChart
            }
                
            Spacer()
        }
    }
}

#Preview {
    BarChartView()
}

extension BarChartView {
    
    private var rangePicker: some View {
        VStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .foregroundStyle(.secondary.opacity(0.1))
                        .frame(height: 65)
                        .frame(maxWidth: .infinity)

                    Capsule()
                        .foregroundStyle(Color(UIColor.systemBackground))
                        .frame(width: geometry.size.width * 0.85 / CGFloat(TimeRange.allCases.count), height: 55)
                        .shadow(color: .customBlack.opacity(0.2), radius: 20, x: 0, y: 0)
                        .offset(x: CGFloat(selectedTimeRange.rawValue) * geometry.size.width / CGFloat(TimeRange.allCases.count) + 10)
                    
                    HStack {
                        ForEach(TimeRange.allCases) { timeRange in
                            Button {
                                withAnimation(.bouncy) {
                                    selectedTimeRange = timeRange
                                }
                            } label: {
                                Text(timeRange.label)
                                    .frame(width: geometry.size.width * 0.95 / CGFloat(TimeRange.allCases.count))
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                }
            }
        }
        .frame(height: 70)
        .padding(.bottom)
    }
    
    private var barChart: some View {
        GeometryReader { geometry in
            Chart {
                ForEach(expenseData) { expense in
                    BarMark(
                        x: .value("Date", expense.date, unit: selectedTimeRange.unit),
                        y: .value("Expense", expense.amount)
                    )
                    .foregroundStyle(Color(hex: expense.category?.color ?? Constants.defaultCategoryColor)!)
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: selectedTimeRange.unit, count: 1)) { _ in
                    AxisValueLabel(format: (selectedTimeRange == .week || selectedTimeRange == .month) ? .dateTime.day() : (selectedTimeRange == .year ? .dateTime.month(.abbreviated) : .dateTime.year()), centered: true)
                }
            }
            .frame(height: geometry.size.height * 0.6)
            .padding(20)
            .background(Color(UIColor.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
