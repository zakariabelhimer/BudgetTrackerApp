//
//  InsightsView.swift
//  BudgetTracker
//
//  Created by zakariaa belhimer on 14/12/24.
//

import SwiftUI
import Charts

struct InsightsView: View {
    @Bindable var user: User

    // Raggruppa le spese per categoria
    private var expensesByCategory: [String: Float] {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: Date())
        let currentYear = calendar.component(.year, from: Date())

        let filteredExpenses = user.expenses.filter { expense in
            let expenseMonth = calendar.component(.month, from: expense.date)
            let expenseYear = calendar.component(.year, from: expense.date)
            return expenseMonth == currentMonth && expenseYear == currentYear
        }

        return Dictionary(grouping: filteredExpenses, by: { $0.category })
            .mapValues { $0.reduce(0) { $0 + $1.amount } }
    }

    // Totale delle spese di questo mese
    private var totalSpentThisMonth: Float {
        expensesByCategory.values.reduce(0, +)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Titolo della pagina
                Text("Expenses")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                // Grafico Donut con il totale al centro
                ZStack {
                    DonutChartView(data: expensesByCategory)
                        .frame(width: 300, height: 300)

                    Text(String(format: "%.2f €", totalSpentThisMonth))
                        .font(.title)
                        .fontWeight(.bold)
                }

                // Griglia delle card delle categorie
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(expensesByCategory.sorted(by: { $0.value > $1.value }), id: \.key) { category, value in
                        CategoryCardView(
                            name: category,
                            percentage: (value / totalSpentThisMonth) * 100,
                            total: value,
                            color: colorForCategory(category: ExpenseCategory(rawValue: category) ?? .Other)
                        )
                    }
                }
                .padding(.horizontal, 10)

                Spacer()
            }
        }
        .padding(.bottom, 20)
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all)) // Supporto Dark Mode
    }

    // Funzione per mappare i colori
    private func colorForCategory(category: ExpenseCategory) -> Color {
        switch category {
        case .FoodAndDrinks:
            return .red
        case .Shopping:
            return .pink
        case .Transportation:
            return .blue
        case .Housing:
            return .green
        case .Entertainment:
            return .purple
        case .HealthCare:
            return .orange
        case .Education:
            return .yellow
        case .Services:
            return .teal
        case .Other:
            return .gray
        }
    }
}



