//
//  MainView.swift
//  BudgetTracker
//
//  Created by zakariaa belhimer on 14/12/24.
//

import SwiftData
import SwiftUI

struct MainView: View {
    @AppStorage("userFirstName") private var firstName: String = ""
    @AppStorage("userLastName") private var lastName: String = ""

    @State private var reloadKey = UUID() // Forza un aggiornamento della vista
    @State private var showSetupView: Bool = false

    var body: some View {
        Group {
            // Forza il refresh usando reloadKey
            UserView()
                .id(reloadKey)
        }
        .onAppear {
            // Mostra SetupUserView se i dati sono mancanti
            showSetupView = firstName.isEmpty || lastName.isEmpty
        }
        .fullScreenCover(isPresented: $showSetupView) {
            SetupUserView {
                // Chiudi e forza il reload
                reloadKey = UUID()
                showSetupView = false
            }
        }
    }
}

struct UserView: View {
    @AppStorage("userFirstName") private var firstName: String = ""
    @AppStorage("userLastName") private var lastName: String = ""

    @Query<User> private var users: [User]
    
    init() {
        _users = Query(filter: #Predicate<User> { user in
            user.name == firstName && user.surname == lastName
        })
    }

    var body: some View {
        if let user = users.first {
            TabView {
                HomeView(user: user)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                InsightsView(user: user)
                    .tabItem {
                        Label("Insights", systemImage: "chart.bar.fill")
                    }
            }
        } else {
            VStack {
                Text("Caricamento...")
                    .font(.headline)
                ProgressView()
            }
        }
    }
}
/*
struct MainView: View {
    
    @AppStorage("userFirstName") private var firstName: String = ""
    @AppStorage("userLastName") private var lastName: String = ""
    
    
    @State private var reload: Bool = false // Stato per forzare il refresh
    
    var body: some View {
        Group {
            if let user = users.first, !reload {
                TabView {
                    HomeView(balance: user.balance, name: user.name)
                        .tabItem {
                            Label("Menu", systemImage: "house.fill")
                        }
                    InsightsView()
                        .tabItem {
                            Label("Order", systemImage: "arrow.trianglehead.2.clockwise.rotate.90")
                        }
                }
            } else {
                Text("Caricamento...")
                    .onAppear {
                        showSetupView = firstName.isEmpty || lastName.isEmpty || users.isEmpty
                    }
            }
        }
        .fullScreenCover(isPresented: $showSetupView) {
            SetupUserView(onSave: {
                reload.toggle() // Forza l'aggiornamento della vista principale
                showSetupView = false
            })
        }
    }
}*/
