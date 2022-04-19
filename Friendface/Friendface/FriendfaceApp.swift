//
//  FriendfaceApp.swift
//  Friendface
//
//  Created by CEVAT UYGUR on 19.04.2022.
//

import SwiftUI

@main
struct FriendfaceApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
