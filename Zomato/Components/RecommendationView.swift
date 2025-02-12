//
//  RecommendationView.swift
//  Zomato
//
//  Created by Celestial on 22/01/25.
//

import SwiftUI

//MARK: Recommendation View
struct RecommendationView: View {
    @State private var showRecommendationView : Bool = true
    @State private var showCartView : Bool = false
    @State private var selectedDish : Dish? = nil
    @ObservedObject var cartViewModel: CartViewModel //Getting from passed view from where i have navigated from
    
    let dishes : [Dish]
    let restuarant: Restaurant
    @State private var vegMode : Bool = UserDefaults.standard.bool(forKey: "mode")
    
    var body: some View {
        VStack{
            HStack{
                Text("Recommended for you")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
                Button{
                    if showRecommendationView{
                        showRecommendationView = false
                    }else{
                        showRecommendationView = true
                    }
                }label: {
                    if showRecommendationView{
                        Image(systemName: "chevron.up")
                            .foregroundStyle(Color.black)
                    }else{
                        Image(systemName: "chevron.down")
                            .foregroundStyle(Color.black)
                    }
                    
                }
                
            }
           
        }.padding()
            .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
        
        //MARK: Showing Recommendation View
        if showRecommendationView {
        
            ForEach(dishes.filter { vegMode ? $0.mode == "veg" : true }) { food in
                LazyVStack {
                    HStack {
                        VStack(alignment: .leading) {
                            if food.mode == "veg"{
                                Image(systemName: "circle.square.fill")
                                    .font(.title3)
                                    .foregroundStyle(Color.green)
                            }else{
                                Image(systemName: "arrowtriangle.up.square")
                                    .font(.title3)
                                    .foregroundStyle(Color.green)
                            }
                                
                            Text(food.name)
                                .font(.title2)
                                .fontWeight(.semibold)
                                
                            ratingView(for: food.rating, review: food.review)
                                
                            Text("₹\(food.price)")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text(food.description)
                            Spacer()
                            HStack {
                                Image(systemName: "bookmark.circle.fill")
                                Image(systemName: "arrowshape.turn.up.right.circle.fill")
                            }
                            .font(.title2)
                            .foregroundStyle(Color.green)
                        }
                        VStack {
                            AsyncImage(url: URL(string: food.image)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                } else if phase.error != nil {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 150)
                                        .foregroundColor(.gray)
                                } else {
                                    ProgressView()
                                        .frame(width: 150, height: 150)
                                }
                            }

                            Button {
                                selectedDish = food
                            } label: {
                                Text("ADD +")
                                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                    .background(Color.white)
                                    .fontWeight(.bold)
                            }
                            
                            //MARK: Opening Customization Sheet
                            
                            .sheet(item: $selectedDish) { dish in
                                CustomizationView(food: dish, restuarant: restuarant)
                                    .onDisappear{
                                        //
                                        cartViewModel.cartItems
                                    }
                                
                            }
                            .padding(EdgeInsets(top: -35, leading: 0, bottom: 0, trailing: 0))
                            .foregroundStyle(Color.red)
                            .background(Color.white)
                        }
                        .cornerRadius(20)
                        .shadow(radius: 5)
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }

        
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
           
    }
    
    func ratingView(for rating: Float, review: Int) -> some View {
        HStack {
            ForEach(0..<5) { index in
                Image(systemName: index < Int(rating) ? "star.fill" : "star")
                    .foregroundStyle(Color.yellow)
            }
            Text("(\(review))")
        }
    }

    
}

//#Preview {
//    RecommendationView()
//}
