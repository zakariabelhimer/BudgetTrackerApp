//
//  SpentCardView.swift
//  BudgetTracker
//
//  Created by zakariaa belhimer on 17/12/24.
//

import SwiftUI

struct SpentCardView: View {
    @Bindable var user: User

    private var totalSpentThisMonth: Float {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: Date())
        let currentYear = calendar.component(.year, from: Date())

        return user.expenses
            .filter { expense in
                let expenseMonth = calendar.component(.month, from: expense.date)
                let expenseYear = calendar.component(.year, from: expense.date)
                return expenseMonth == currentMonth && expenseYear == currentYear
            }
            .reduce(0) { $0 + $1.amount }
    }

    private var totalBalanceAddedThisMonth: Float {
        user.balance + totalSpentThisMonth
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("You spent")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                Spacer()
                Text(String(format: "%.2f €", totalSpentThisMonth))
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
            }

            HStack {
                Text("From")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
                Text(String(format: "%.2f €", totalBalanceAddedThisMonth))
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground)) // Adattabile alla Dark Mode
        .cornerRadius(12)
        .shadow(radius: 5, x: 2, y: 2) // Ombra dinamica
        .padding(.horizontal, 20)
    }
}
