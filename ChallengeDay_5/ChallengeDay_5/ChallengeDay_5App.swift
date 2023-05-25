//
//  ChallengeDay_5App.swift
//  ChallengeDay_5
//
//  Created by Mateusz Ratajczak on 20/05/2023.
//

import SwiftUI

@main
struct ChallengeDay_5App: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
