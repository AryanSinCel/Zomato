//
//  DetailedDeliveryView.swift
//  Zomato
//
//  Created by Celestial on 22/01/25.
//

import SwiftUI

struct DetailedDeliveryView: View {
    @Environment(\.dismiss) var dismiss
    let restuarant: Restaurant
    @StateObject private var viewModel = CartViewModel()
    
    
    var body: some View {
        ZStack(alignment:.bottom){
            ScrollView(showsIndicators:false){
                    ZStack(alignment: .topLeading) {
                        Color.white
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                                .padding(12)
                                .overlay(Circle()
                                    .stroke(lineWidth: 1.0)
                                    .foregroundStyle(Color(.systemGray4))
                                )
                           
                            Text(restuarant.name)
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundStyle(Color.black)
                        }
                    }.padding()
                
                    VStack{
                        HStack{
                            Text(restuarant.name)
                                .font(.title)
                                .fontWeight(.semibold)
                            Spacer()
                            Text(restuarant.rating)
                                .font(.title2)
                                .fontWeight(.semibold)
                            Image(systemName: "star.fill")
                                .font(.title2)
                                .foregroundStyle(Color.white)
                                .background(Color.green)
                                .cornerRadius(20)
                            
                        }.padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                    
                        VStack{
                            HStack{
                                Image(systemName: "stopwatch")
                                Text("\(restuarant.duration) mins • \(restuarant.distance) km • \(restuarant.location)")
                                Image(systemName: "chevron.down")
                                Spacer()
                            }
                            HStack{
                                Image(systemName: "stopwatch")
                                Text("Schedule For Later")
                                Image(systemName: "chevron.down")
                                Spacer()
                            }
                            Divider()
                            HStack{
                                Text("Save up to ₹75")
                                Spacer()
                                Text("2 Offer")
                                Image(systemName: "chevron.down")
                                
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        
                    }

                    //MARK: Showing Filter View
                    FilterView()
                
                //MARK: Showing Recommendation View
                RecommendationView(cartViewModel: viewModel, dishes: restuarant.dishes, restuarant: restuarant)
                    
                
                
                
                
            }
            .toolbar(.hidden,for: .tabBar)
        
            //MARK: Showing Bottom Cart Navigation
            if !viewModel.cartItems.isEmpty {
                BottomCartNavigation(cartViewModel: viewModel, dishes: dishes, restuarant: restuarant)
                    .background(Color.white)
            }
        }
      
       
        // show this bottom cart view when their is cart item present with restuarant.name
        // Fetching the restuarant Name on appear
        .onAppear {
            viewModel.fetchCartItems(for: restuarant.name)
                        print("Restaurant Name: \(restuarant.name)")
                    }
                    
                    // **Bottom Cart View - Appears when cart items exist**
//                    if !viewModel.cartItems.isEmpty {
//                        BottomCartNavigation(cartViewModel: viewModel, dishes: dishes, restuarant: restuarant)
//
//                    }
       
    }
}

//#Preview {
//    DetailedDeliveryView()
//}
