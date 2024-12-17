//
//  AddExpenseModal.swift
//  BudgetTracker
//
//  Created by zakariaa belhimer on 17/12/24.
//

import SwiftUI
import SwiftData

struct AddExpenseModal: View {
    @Bindable var user: User // Utente corrente

    @State private var expenseName: String = ""
    @State private var expenseAmount: String = ""
    @State private var selectedCategory: ExpenseCategory = .Other
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                TextField("Expense Name", text: $expenseName)
                    .padding()
                    .background(Color(UIColor.systemGray6)) // Sfondo grigio chiaro
                    .cornerRadius(12) // Bordi arrotondati
                    .font(.system(size: 16))
                    .frame(height: 50) // Altezza del TextField
                    .frame(maxWidth: .infinity) // Larghezza massima
                    .padding(.horizontal, 20) // Margine orizzontale esterno

                TextField("Expense Amount", text: $expenseAmount)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                    .font(.system(size: 16))
                    .frame(height: 50) // Altezza del TextField
                    .frame(maxWidth: .infinity) // Larghezza massima
                    .padding(.horizontal, 20)

                
                // Categoria selezionabile con bottoni estetici
                VStack(alignment: .leading, spacing: 10) {
                    Text("Category")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.leading, 15)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(ExpenseCategory.allCases, id: \.self) { category in
                                categoryButton(for: category)
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                // Bottone Add Expense con gradiente rosso
                Button(action: addExpense) {
                    Text("Add Expense")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(gradientRed())
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    // Funzione per creare il bottone della categoria
    private func categoryButton(for category: ExpenseCategory) -> some View {
        let isSelected = selectedCategory == category

        return Button(action: {
            selectedCategory = category
        }) {
            Text(categoryDisplayName(for: category))
                .font(.subheadline)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    isSelected
                        ? gradientRed() // Stato selezionato
                        : gradientGray() // Stato non selezionato
                )
                .cornerRadius(15)
        }
    }

    // Gradiente rosso
    private func gradientRed() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.red, .pink]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    // Gradiente grigio
    private func gradientGray() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.gray.opacity(0.5), Color.gray.opacity(0.3)]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    // Funzione per mostrare nomi leggibili delle categorie
    private func categoryDisplayName(for category: ExpenseCategory) -> String {
        switch category {
        case .FoodAndDrinks: return "Food & Drinks"
        case .Shopping: return "Shopping"
        case .Transportation: return "Transport"
        case .Housing: return "Housing"
        case .Entertainment: return "Entertainment"
        case .HealthCare: return "Health Care"
        case .Education: return "Education"
        case .Services: return "Services"
        case .Other: return "Other"
        }
    }

    private func addExpense() {
        guard let amount = Float(expenseAmount), amount > 0 else { return }
        
        // Creazione della nuova spesa
        let newExpense = Expense(
            amount: amount,
            name: expenseName,
            date: Date(),
            category: selectedCategory.rawValue
        )
        
        // Aggiunta della spesa all'utente e aggiornamento del bilancio
        user.expenses.append(newExpense)
        user.balance -= amount
        
        dismiss()
    }
}




