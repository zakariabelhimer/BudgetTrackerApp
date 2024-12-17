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
    @State private var showEditProfileModal = false
    
    
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
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 30) {
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
                                    LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                                                   startPoint: .leading, endPoint: .trailing)
                                    .frame(width: CGFloat(dayInMonth) / CGFloat(daysInCurrentMonth) * geometry.size.width, height: 8)
                                    .cornerRadius(4)
                                    
                                    Circle()
                                        .fill(Color.purple)
                                        .frame(width: 12, height: 12)
                                        .position(
                                            x: CGFloat(dayInMonth) / CGFloat(daysInCurrentMonth) * geometry.size.width,
                                            y: 4
                                        )
                                }
                                .frame(height: 8)
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        WalletCardView(balance: .constant(user.balance), name: .constant(user.name))
                            .shadow(radius: 5, x: 2, y: 2)
                            .padding(.horizontal, 20)
                        
                        SpentCardView(user: user)
                            .shadow(radius: 5, x: 2, y: 2)
                        
                        RecentExpensesCard(expenses: user.expenses)
                            .shadow(radius: 5, x: 2, y: 2)
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                }
                
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
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("Hello, \(user.name)!")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showEditProfileModal = true
                    }) {
                        Image(systemName: "person.crop.circle")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    .accessibilityLabel("Edit Profile")
                }
            }
            .sheet(isPresented: $showAddExpenseModal) {
                AddExpenseModal(user: user)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showAddBalanceModal) {
                AddBalanceModal(user: user)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showEditProfileModal) {
                EditProfileModal(user: user)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}






struct RecentExpensesCard: View {
    var expenses: [Expense]
    
    private var recentExpenses: [Expense] {
        Array(expenses
            .sorted(by: { $0.date > $1.date })
            .prefix(3))
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
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 5, x: 2, y: 2)
        .padding(.horizontal, 20)
    }
}



import SwiftUI

struct EditProfileModal: View {
    @Bindable var user: User
    @Environment(\.dismiss) private var dismiss
    
    @State private var isEditing: Bool = false
    @State private var updatedFirstName: String = ""
    @State private var updatedLastName: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("First Name")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    if isEditing {
                        TextField("Enter First Name", text: $updatedFirstName)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(12)
                            .font(.system(size: 16))
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                    } else {
                        Text(user.name)
                            .font(.title2)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Last Name")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    if isEditing {
                        TextField("Enter Last Name", text: $updatedLastName)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(12)
                            .font(.system(size: 16))
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                    } else {
                        Text(user.surname)
                            .font(.title2)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                Button(action: {
                    if isEditing {
                        saveProfile()
                    } else {
                        enableEditing()
                    }
                }) {
                    Text(isEditing ? "Save" : "Edit Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(gradientPurple())
                        .cornerRadius(12)
                }
                .padding(.horizontal, 20)
                
                if isEditing {
                    Button(action: cancelEditing) {
                        Text("Cancel")
                            .font(.headline)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                }
                
                Spacer()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                updatedFirstName = user.name
                updatedLastName = user.surname
            }
        }
    }
    
    private func gradientPurple() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.purple, Color.blue]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    private func enableEditing() {
        isEditing = true
    }
    
    @AppStorage("userFirstName") private var firstName: String = ""
    @AppStorage("userLastName") private var lastName: String = ""
    
    private func saveProfile() {
        firstName = updatedFirstName
        lastName = updatedLastName
        
        user.name = updatedFirstName
        user.surname = updatedLastName
        
        do {
            try user.modelContext?.save()
        } catch {
            print("Failed to save changes: \(error.localizedDescription)")
        }
        dismiss()
    }
    
    
    private func cancelEditing() {
        updatedFirstName = user.name
        updatedLastName = user.surname
        isEditing = false
    }
}

