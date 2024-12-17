//
//  AddBalanceModal.swift
//  BudgetTracker
//
//  Created by zakariaa belhimer on 17/12/24.
//

import SwiftUI
import SwiftData

struct AddBalanceModal: View {
    @Bindable var user: User // Utente corrente

    @State private var amountToAdd: String = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // TextField con bordi arrotondati e stile pulito
                TextField("Amount to Add", text: $amountToAdd)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(UIColor.systemGray6)) // Sfondo grigio chiaro
                    .cornerRadius(12) // Bordi arrotondati
                    .font(.system(size: 16))
                    .frame(height: 50) // Altezza del TextField
                    .frame(maxWidth: .infinity) // Larghezza massima
                    .padding(.horizontal, 20) // Margine orizzontale esterno

                // Bottone Add Balance con gradiente verde
                Button(action: addBalance) {
                    Text("Add Balance")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(gradientGreen())
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationTitle("Add Balance")
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

    // Gradiente verde per il bottone
    private func gradientGreen() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.green, Color.green.opacity(0.7)]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    private func addBalance() {
        guard let amount = Float(amountToAdd), amount > 0 else { return }
        
        // Aggiunta al bilancio dell'utente
        user.balance += amount
        
        dismiss()
    }
}


