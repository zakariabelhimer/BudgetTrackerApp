//
//  WalletCardView.swift
//  BudgetTracker
//
//  Created by zakariaa belhimer on 14/12/24.
//

import SwiftUI



struct WalletCardView: View {
    
    @Binding var balance:Float
    @Binding var name: String
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Balance")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(String(format: "%.2f", balance)) €")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                
                //Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    Image("chip")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                }
                .frame(width: 240)
                
                
                //Spacer()
                
                HStack {
                    Text("\(name)")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                }
                
            }
            .frame(width: 240, height: 120)
            .padding(30)
        }
        .frame(width: 300, height: 170)
        .background(
            LinearGradient(gradient: Gradient(colors: [.purple, .purple, .blue]), startPoint: .bottomLeading, endPoint: .topTrailing)
            )
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}
/*
#Preview {
    WalletCardView(balance: 83.50000, name: "Zakaria")
}*/
