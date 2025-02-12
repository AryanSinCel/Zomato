//
//  BottomCartNavigation.swift
//  Zomato
//
//  Created by Celestial on 30/01/25.
//

import SwiftUI

//MARK: Bottom Cart Sheet

struct BottomCartNavigation: View {
    @ObservedObject var cartViewModel: CartViewModel //Getting from passed view from where i have navigated from
    let dishes : [Dish] //Getting from passed view from where i have navigated from
    let restuarant: Restaurant //Getting from passed view from where i have navigated from
    
    var body: some View {
        NavigationStack{
            HStack{
                
    //            Image(dishes.first?.image)
                AsyncImage(url: URL(string: dishes.first!.image)){phase in
                    if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .background(Color.white)
    //                                                .scaledToFill()
                                                    .frame(width: 50, height: 50)
                                                    .cornerRadius(30)
    //                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                            } else if phase.error != nil {
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .background(Color.white)
    //                                                .scaledToFill()
                                                    .frame(width: 50, height: 50)
                                                    .cornerRadius(30)
                                            } else {
                                                ProgressView()
                                                    .frame(width: 50, height: 50)
                                            }
                    
                }
                Spacer()
    //                .resizable()
    //                .background(Color.white)
    //                .frame(width: 50,height: 50)
    //                .cornerRadius(30)
                 
                VStack(alignment:.leading){
                    Text(restuarant.name)
                        .fontWeight(.semibold)
                    HStack{
                        Text("View Menu")
                        Image(systemName: "arrowtriangle.right.fill")
                            .foregroundStyle(Color.red)
                    }
              
                }
                
                Spacer()
                
                NavigationLink {
                    CartView(restaurant: restuarant.name)
                } label: {
                    VStack{
                        Text("View Cart")
                            .fontWeight(.semibold)
                        Text("\(cartViewModel.cartItems.count) item")
                       
                    }
                }
                .padding(8)
                .background(Color.red)
                .foregroundStyle(Color.white)
                .cornerRadius(10)
                
                
               
            }
            .frame(height: 50)
            .padding()
    //        .background(Color.red)
            .cornerRadius(20)
        }
       
    }
}


