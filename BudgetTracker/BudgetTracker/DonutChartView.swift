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
    var data: [String: Float] // Dati con categorie come stringhe e i valori delle spese

    // Mappa dei colori per le categorie
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

    // Genera i dati con segmenti vuoti per simulare lo spazio tra categorie
    private var chartData: [(category: String, value: Float)] {
        var result: [(String, Float)] = []
        let spacerValue: Float = 0.005 // Valore molto piccolo per creare spazio

        for (key, value) in data {
            result.append((key, value))
            result.append(("Spacer", spacerValue)) // Aggiunge un segmento vuoto
        }

        return result
    }

    var body: some View {
        Chart {
            ForEach(chartData, id: \.category) { item in
                if item.category == "Spacer" {
                    // Segmento trasparente per simulare lo spazio
                    SectorMark(
                        angle: .value("Amount", item.value),
                        innerRadius: .ratio(0.85),
                        outerRadius: .ratio(1.0)
                    )
                    .foregroundStyle(.clear)
                } else {
                    // Segmenti principali con angoli arrotondati e colore personalizzato
                    SectorMark(
                        angle: .value("Amount", item.value),
                        innerRadius: .ratio(0.85),
                        outerRadius: .ratio(1.0)
                    )
                    .cornerRadius(10)
                    .foregroundStyle(categoryColors[item.category, default: .gray]) // Colore della categoria
                }
            }
        }
        .frame(width: 300, height: 300)
        .chartLegend(.hidden) // Nasconde la legenda
    }
}





