//
//  MainTabView.swift
//  Zomato
//
//  Created by Celestial on 21/01/25.
//

import SwiftUI

//MARK: Main Tab View
struct MainTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.white
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
//        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        //MARK: Tab View
        
        TabView{
            DeliveryView()
                .tabItem {
                    Text("Delivery")
                    Image(systemName: "moped")
                }
        
            DiningView()
                .tabItem {
                    Text("Dining")
                    Image(systemName: "fork.knife")

                }
            LiveView()
                .tabItem {
                    Text("Live")
                    Image(systemName: "livephoto.play")
                }
        }
        .navigationBarBackButtonHidden()
        .tint(.red)
    }
}

#Preview {
    MainTabView()
}
