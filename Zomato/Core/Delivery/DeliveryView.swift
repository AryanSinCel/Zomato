//
//  ContentView.swift
//  Zomato
//
//  Created by Celestial on 20/01/25.
//

import SwiftUI

//MARK: Delivery View
struct DeliveryView: View {
    @State private var showDetailedView : Bool = false
    var body: some View {
        NavigationStack{
            NonBouncingScrollView{
                
                NavigationView()
                    .foregroundStyle(Color.white)
                    .tint(Color.white)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.yellow,.orange]), startPoint: .bottom, endPoint: .top)
                    )
                
                Image("FlashSale")
                    .resizable()
                    .cornerRadius(20)
//                    .scaledToFit()
                    .frame(width: 405,height:300)
                    .padding(EdgeInsets(top: -19, leading: 0, bottom: 0, trailing: 0))
                    
                
                Spacer()
                HStack{
                        
                    Rectangle()
                        .frame(width: 140,height: 0.4)
                        .foregroundStyle(Color("DividerColor"))
                        Text("EXPLORE")
                    Rectangle()
                        .frame(width: 140,height: 0.4)
                        .foregroundStyle(Color("DividerColor"))
                        
                    }
                .foregroundStyle(Color.gray)
                .padding(.bottom)
                
                //MARK: Showing Explore View
                ExploreView()
                    .frame(height: 120)
                
                HStack{
                    Rectangle()
                        .frame(width: 70,height: 0.4)
                        .foregroundStyle(Color("DividerColor"))
                        Text("WHAT'S ON YOUR MIND?")
                    Rectangle()
                        .frame(width: 70,height: 0.4)
                        .foregroundStyle(Color("DividerColor"))
                        
                    }
                .foregroundStyle(Color.gray)
                .padding(.bottom)
                
                WhatsOnYourMindView()
                
                HStack{
                    Rectangle()
                        .frame(width: 90,height: 0.4)
                        .foregroundStyle(Color("DividerColor"))
                        Text("ALL RESTAURANTS")
                    Rectangle()
                        .frame(width: 90,height: 0.4)
                        .foregroundStyle(Color("DividerColor"))
                        
                    }
                .foregroundStyle(Color.gray)
                
                //MARK: Showing Filter View
                FilterView()
                
                Text("1991 restaurants delivering to you")
                    .foregroundStyle(Color.gray)
                    .padding(.bottom)
                
                Text("FEATURED")
                    .foregroundStyle(Color.gray)
                 
                //MARK: Showing Restaurant View
                RestaurantsView()
                
                
                Spacer()
                
            }
            .background(Color.orange.edgesIgnoringSafeArea(.top))
        }
        
        .toolbarBackground(Color.black, for: .navigationBar) // Set the navigation bar background color to black
        .toolbarColorScheme(.dark, for: .navigationBar) // Use a dark color scheme for navigation bar
    }
}

#Preview {
    DeliveryView()
}

