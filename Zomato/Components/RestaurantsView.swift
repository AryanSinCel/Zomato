//
//  RestaurantsView.swift
//  Zomato
//
//  Created by Celestial on 20/01/25.
//

import SwiftUI

//MARK: Restaurant View
struct RestaurantsView: View {

    var body: some View {
        NavigationStack {
            VStack {
                ForEach(StaticData.restaurants) { restuarant in
                    NavigationLink(destination:
                                    
                                    NavigationStack{
                            DetailedDeliveryView(restuarant: restuarant)
                    }
                                  
                                   
                                   
                                   
                    ) {
                        VStack(alignment: .leading) {
                            ImageCarouselView()
                                .frame(width: 370, height: 215)
                                .scaledToFill()
                                .cornerRadius(20)
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "stopwatch")
                                    Text("\(restuarant.duration) mins \(restuarant.distance) km")
                                        .foregroundStyle(Color.red)
                                }
                                
                                HStack {
                                    Text(restuarant.name)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text("\(restuarant.rating)")
                                    Image(systemName: "star.fill")
                                        .foregroundStyle(Color.white)
                                        .background(Color.green)
                                        .cornerRadius(10)
                                }
                                
                                Text("\(restuarant.foodType) • \(restuarant.foodBelong) • ₹\(restuarant.priceForOne) for one")
                                    .foregroundStyle(Color.gray)
                                
                                Text("\(restuarant.discount) % OFF up to ₹75")
                                    .fontWeight(.heavy)
                                    .foregroundStyle(Color.gray)
                            }
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 20))
                        }
                        .frame(width: 370, height: 345)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 1.0)
                                .foregroundStyle(Color(.systemGray4))
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                }
            }
            
        }
        
    }
    
}

#Preview {
    RestaurantsView()
}

