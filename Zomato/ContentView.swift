//
//  ContentView.swift
//  Zomato
//
//  Created by Celestial on 20/01/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
        
        if authManager.isAuthenticated {
                   MainTabView() // Show main app
            } else {
                SignPageView() // Show login screen
        }
            
    }
}

#Preview {
    ContentView()
}


