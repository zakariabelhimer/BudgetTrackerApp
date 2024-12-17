//
//  SetupUserView.swift
//  BudgetTracker
//
//  Created by zakariaa belhimer on 16/12/24.
//

import SwiftUI
import SwiftData

struct SetupUserView: View {
    @Environment(\.modelContext) private var context
    @AppStorage("userFirstName") private var firstName: String = ""
    @AppStorage("userLastName") private var lastName: String = ""

    @State private var tempFirstName: String = ""
    @State private var tempLastName: String = ""
    @State private var tempBalance: String = ""

    var onSave: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            TextField("Enter your first name", text: $tempFirstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("Enter your last name", text: $tempLastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Enter your current balance", text: $tempBalance)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button(action: saveUser) {
                Text("Save")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
    }

    private func saveUser() {
        guard !tempFirstName.isEmpty, !tempLastName.isEmpty, let balance = Float(tempBalance) else {
            return // Evita di salvare dati incompleti o errati
        }
        
        // Inserisci e salva manualmente nel contesto
        let newUser = User(name: tempFirstName, surname: tempLastName, balance: balance)
        context.insert(newUser)
        
        do {
            try context.save()
            print("User saved successfully.")
        } catch {
            print("Error saving user: \(error)")
        }

      
        firstName = tempFirstName
        lastName = tempLastName
        
                onSave()
    }
}
