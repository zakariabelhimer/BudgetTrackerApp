//
//  AddBalanceModal.swift
//  BudgetTracker
//
//  Created by zakariaa belhimer on 17/12/24.
//

import SwiftUI
import SwiftData

struct AddBalanceModal: View {
    @Bindable var user: User

    @State private var amountToAdd: String = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Amount to Add", text: $amountToAdd)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                    .font(.system(size: 16))
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)

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

    private func gradientGreen() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.green, Color.green.opacity(0.7)]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    private func addBalance() {
        guard let amount = Float(amountToAdd), amount > 0 else { return }
                user.balance += amount
        
        dismiss()
    }
}


