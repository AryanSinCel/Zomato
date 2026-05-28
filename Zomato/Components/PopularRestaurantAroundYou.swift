//
//  PopularRestaurantAroundYou.swift
//  Zomato
//
//  Created by Celestial on 30/01/25.
//

import SwiftUI

struct PopularRestaurantAroundYou: View {
    let restuarant: Restaurant
    var body: some View {
            ZStack(alignment:.bottom){
                ImageCarouselView()
                    .frame(width: 380,height: 340)
                    .scaledToFill()
                    .cornerRadius(20)
                
                ZStack{
                    VStack(alignment:.leading, spacing: 0){
                        VStack(alignment:.leading){
                            Text("PRE-BOOK TABLE ─────")
                            Text("Flat \(restuarant.discount)% OFF + 3 more")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(Color.white)
                        .padding(5)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue,Color.clear]), startPoint: .leading, endPoint: .trailing))
                       
                        VStack{
                            HStack{
                                Text(restuarant.name)
                                    .font(.title)
                                    .bold()
                                Spacer()
                                Text(restuarant.rating)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Image(systemName: "star.fill")
                                    .foregroundStyle(Color.white)
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                            HStack{
                                Text(restuarant.location)
                                Spacer()
                                Text("\(restuarant.distance) km")
                            }
                            .foregroundStyle(Color.gray)
                            
                            HStack{
                                Text("\(restuarant.foodType) • \(restuarant.foodBelong)")
                                Spacer()
                                Text("₹\(restuarant.priceForOne) for one")
                            }
                            .foregroundStyle(Color.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        
                    }
                        .cornerRadius(10)
                        .padding()
                        
                        
                }
                .frame(width: 390)
                
                   
            }
    }
}

#Preview {
    PopularRestaurantAroundYou(restuarant: StaticData.restaurants.first!)
}
