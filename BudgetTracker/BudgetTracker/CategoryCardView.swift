//
//  CategoryCardView.swift
//  BudgetTracker
//
//  Created by zakariaa belhimer on 17/12/24.
//

import SwiftUI

struct CategoryCardView: View {
    var name: String       // Nome della categoria
    var percentage: Float  // Percentuale della spesa
    var total: Float       // Totale speso nella categoria
    var color: Color       // Colore della categoria

    var body: some View {
        VStack {
            // Riga superiore: Percentuale e Totale
            HStack {
                Text(String(format: "%.2f %%", percentage))
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Spacer()

                Text(String(format: "%.2f €", total))
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }

            Spacer()

            // Riga inferiore: Nome categoria a sinistra e cerchio colorato a destra
            HStack {
                Text(name)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Spacer()

                Circle()
                    .fill(color) // Colore della categoria
                    .frame(width: 20, height: 20) // Dimensione del cerchio
            }
        }
        .padding()
        .frame(height: 140) // Altezza maggiore della larghezza
        .background(Color(UIColor.secondarySystemBackground)) // Supporto per Dark Mode
        .cornerRadius(12) // Bordi arrotondati
        .shadow(radius: 5) // Ombra morbida
    }
}


