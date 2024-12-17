//
//  CategoryCardView.swift
//  BudgetTracker
//
//  Created by zakariaa belhimer on 17/12/24.
//

import SwiftUI

struct CategoryCardView: View {
    var name: String
    var percentage: Float
    var total: Float
    var color: Color

    var body: some View {
        VStack {
           
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

          
            HStack {
                Text(name)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Spacer()

                Circle()
                    .fill(color)
                    .frame(width: 20, height: 20)
            }
        }
        .padding()
        .frame(height: 140)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 5) 
    }
}


