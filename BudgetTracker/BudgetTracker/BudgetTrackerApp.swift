//
//  BudgetTrackerApp.swift
//  BudgetTracker
//
//  Created by zakariaa belhimer on 14/12/24.
//

import SwiftData
import SwiftUI

@main
struct BudgetTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: User.self)
    }
}
