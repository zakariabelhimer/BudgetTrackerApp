//
//  expense.swift
//  BudgetTracker
//
//  Created by zakariaa belhimer on 16/12/24.
//

import Foundation
import SwiftData

enum ExpenseCategory: String, CaseIterable, Codable {
    case FoodAndDrinks
    case Shopping
    case Transportation
    case Housing
    case Entertainment
    case HealthCare
    case Education
    case Services
    case Other
}

@Model
class Expense {
    var amount: Float
    var name: String
    var date: Date
    var category: String
    
    init(amount: Float = 0.0, name: String = "", date: Date = .now, category: String = "Other") {
        self.amount = amount
        self.name = name
        self.date = date
        self.category = category
    }
}

@Model
class User {
    var name: String
    var surname: String
    var balance: Float
    @Relationship var expenses: [Expense] // Usa un array per compatibilità
    
    init(name: String, surname: String, balance: Float = 0) {
        self.name = name
        self.surname = surname
        self.balance = balance
        self.expenses = []
    }
}
