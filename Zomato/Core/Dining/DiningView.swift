//
//  DiningView.swift
//  Zomato
//
//  Created by Celestial on 21/01/25.
//

import SwiftUI

//MARK: Dining View
struct DiningView: View {
    var body: some View {
        NavigationStack {
            //Custom Scrollview
            NonBouncingScrollView {
                VStack {
                    // Navigation Bar
                    NavigationView()
                        .background(Color.black) // Set background to black
                        .foregroundColor(.white) // Set text color to white
                     
                    // Top Image
                    Image("dining_top_image")
                        .resizable()
                        .scaledToFit()
                        .padding(EdgeInsets(top: -10, leading: 0, bottom: 0, trailing: 0))
                }
                
                // Filters and Content
                FilterView()
                
                HStack {
                    Rectangle()
                        .frame(width: 70, height: 0.4)
                        .foregroundStyle(Color("DividerColor"))
                    Text("IN THE LIMELIGHT")
                        .tracking(5)
                        .foregroundStyle(.gray)
                    Rectangle()
                        .frame(width: 70, height: 0.4)
                        .foregroundStyle(Color("DividerColor"))
                }
                
                //MARK: Image Carousel Component
                ImageCarouselView()
                    .frame(width: 370, height: 180)
                    .scaledToFill()
                    .cornerRadius(20)
                    .padding(.top)
                
                HStack {
                    Rectangle()
                        .frame(width: 75, height: 0.4)
                        .foregroundStyle(Color("DividerColor"))
                    Text("WHAT ARE YOU LOOKING FOR?")
                        .tracking(5)
                        .foregroundStyle(.gray)
                    Rectangle()
                        .frame(width: 75, height: 0.4)
                        .foregroundStyle(Color("DividerColor"))
                }
                .padding(.top)
                
                VStack {
                    WhatAreYouLookingForView()
                }
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                
                VStack{
                    Text("POPULAR RESTAURANTS AROUND YOU")
                        .multilineTextAlignment(.center)
                        .tracking(3)
                        .foregroundStyle(.gray)
                        .padding(.bottom)
                    Text("FEATURED")
                        .foregroundStyle(.gray)
                    
                }
                .padding()
                
                VStack{
                    ForEach(0..<5,id: \.self){item in
                        //MARK: Popular Restaurant
                        PopularRestaurantAroundYou()
                    }
                }
                
                Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.top)) // Set safe area color to black
        }
        .toolbarBackground(Color.black, for: .navigationBar) // Set the navigation bar background color to black
        .toolbarColorScheme(.dark, for: .navigationBar) // Use a dark color scheme for navigation bar
    }
}

#Preview {
    DiningView()
}
