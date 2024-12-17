//
//  ContentView.swift
//  BudgetTracker
//
//  Created by zakariaa belhimer on 14/12/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Bindable var user: User

    @State private var showAddExpenseModal = false
    @State private var showAddBalanceModal = false

    // Giorno attuale e giorni totali del mese
    private var dayInMonth: Int {
        Calendar.current.component(.day, from: Date())
    }

    private var daysInCurrentMonth: Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: Date())
        return range?.count ?? 30
    }
    
    private var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: Date())
    }

    var body: some View {
        VStack(spacing: 0) {
            // Titolo con Saluto e Nome Utente
            HStack {
                Text("Hello, \(user.name)!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.leading, 20)
                Spacer()
            }
            .padding(.top, 20)

            ScrollView {
                VStack(spacing: 30) { // Spaziatura aumentata tra le sezioni
                    // Timeline: Giorno corrente del mese
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Monthly Timeline")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            Spacer()
                            Text(currentDate)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal, 20)

                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color(UIColor.systemGray4))
                                .frame(height: 8)
                                .cornerRadius(4)

                            GeometryReader { geometry in
                                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.blue]),
                                               startPoint: .leading, endPoint: .trailing)
                                    .frame(width: CGFloat(dayInMonth) / CGFloat(daysInCurrentMonth) * geometry.size.width, height: 8)
                                    .cornerRadius(4)

                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 12, height: 12)
                                    .position(x: CGFloat(dayInMonth) / CGFloat(daysInCurrentMonth) * geometry.size.width, y: 4)
                            }
                        }
                        .frame(height: 8)
                        .padding(.horizontal, 20)
                    }

                    // Carta Wallet
                    WalletCardView(balance: .constant(user.balance), name: .constant(user.name))
                        .shadow(radius: 5, x: 2, y: 2) // Rimosso il color
                        .padding(.horizontal, 20)

                    // Spent Card
                    SpentCardView(user: user)
                        .shadow(radius: 5, x: 2, y: 2) // Rimosso il color

                    // Card delle ultime tre spese
                    RecentExpensesCard(expenses: user.expenses)
                        .shadow(radius: 5, x: 2, y: 2) // Rimosso il color

                    Spacer()
                }
                .padding(.vertical, 10)
            }

            // Bottoni fissi in basso con gradienti
            VStack(spacing: 10) {
                HStack(spacing: 20) {
                    Button(action: {
                        showAddExpenseModal = true
                    }) {
                        Text("Add Expense")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.red, Color.pink]),
                                               startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(12)
                            .shadow(radius: 5, x: 2, y: 2) // Rimosso il color
                    }

                    Button(action: {
                        showAddBalanceModal = true
                    }) {
                        Text("Add Balance")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.green, Color.mint]),
                                               startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(12)
                            .shadow(radius: 5, x: 2, y: 2) // Rimosso il color
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.bottom)) // Sfondo dinamico
        }
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all)) // Sfondo principale dinamico
        .sheet(isPresented: $showAddExpenseModal) {
            AddExpenseModal(user: user)
                .presentationDetents([.medium]) // Altezza a metà schermo
                .presentationDragIndicator(.visible) // Aggiunge il drag indicator
        }
        .sheet(isPresented: $showAddBalanceModal) {
            AddBalanceModal(user: user)
                .presentationDetents([.medium]) // Altezza a metà schermo
                .presentationDragIndicator(.visible)
        }
    }
}




struct RecentExpensesCard: View {
    var expenses: [Expense]

    // Filtra le ultime tre spese
    private var recentExpenses: [Expense] {
        Array(expenses
            .sorted(by: { $0.date > $1.date }) // Ordina per data decrescente
            .prefix(3)) // Prendi le prime tre e convertilo in Array
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recent Expenses")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.horizontal, 20)

            ForEach(recentExpenses, id: \.self) { expense in
                HStack {
                    VStack(alignment: .leading) {
                        Text(expense.name)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)

                        Text(expense.date, style: .date)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    Text(String(format: "-%.2f €", expense.amount))
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }
        }
        .padding(.vertical, 10)
        .background(Color(UIColor.secondarySystemBackground)) // Adattabile alla Dark Mode
        .cornerRadius(12)
        .shadow(radius: 5, x: 2, y: 2) // Ombra dinamica
        .padding(.horizontal, 20)
    }
}


/*
#Preview {
    HomeView()
}*/
