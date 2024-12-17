//
//  DonutChartView.swift
//  BudgetTracker
//
//  Created by zakariaa belhimer on 17/12/24.
//

import SwiftUI
import Charts

import SwiftUI
import Charts

struct DonutChartView: View {
    var data: [String: Float]
    
    private let categoryColors: [String: Color] = [
        "FoodAndDrinks": .red,
        "Shopping": .pink,
        "Transportation": .blue,
        "Housing": .green,
        "Entertainment": .purple,
        "HealthCare": .orange,
        "Education": .yellow,
        "Services": .teal,
        "Other": .gray
    ]

 
    private var chartData: [(category: String, value: Float)] {
        var result: [(String, Float)] = []
        let spacerValue: Float = 0.005

        for (key, value) in data {
            result.append((key, value))
            result.append(("Spacer", spacerValue))
        }

        return result
    }

    var body: some View {
        Chart {
            ForEach(chartData, id: \.category) { item in
                if item.category == "Spacer" {
                   
                    SectorMark(
                        angle: .value("Amount", item.value),
                        innerRadius: .ratio(0.85),
                        outerRadius: .ratio(1.0)
                    )
                    .foregroundStyle(.clear)
                } else {
                    SectorMark(
                        angle: .value("Amount", item.value),
                        innerRadius: .ratio(0.85),
                        outerRadius: .ratio(1.0)
                    )
                    .cornerRadius(10)
                    .foregroundStyle(categoryColors[item.category, default: .gray])                 }
            }
        }
        .frame(width: 300, height: 300)
        .chartLegend(.hidden) 
    }
}





