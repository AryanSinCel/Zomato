//
//  CustomizationView.swift
//  Zomato
//
//  Created by Celestial on 22/01/25.
//

import SwiftUI

//MARK: Customization View

struct CustomizationView: View {
    @State private var numberOfItem : Int = 1
    @Environment(\.dismiss) private var dismiss
    var userContact = UserDefaults.standard.string(forKey: "userPhoneNumber") ?? ""
    let food: Dish
    let restuarant: Restaurant
    
    var body: some View {
//        Spacer()
        VStack{
//            Spacer()
            VStack{
                
                AsyncImage(url: URL(string: food.image)) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 370,height: 390)
//                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .cornerRadius(20)
                                        } else if phase.error != nil {
                                            Image(systemName: "photo")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 370,height: 395)
                                                .foregroundColor(.gray)
                                                .cornerRadius(20)
                                        } else {
                                            ProgressView()
                                                .frame(width: 370,height: 395)
                                                .cornerRadius(20)

                                        }
                }
                
                HStack{
                    Text(food.name)
                        .foregroundStyle(Color.black)
                        .font(.title)
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "bookmark.circle.fill")
                        .font(.system(size: 40))
                    Image(systemName: "arrowshape.turn.up.right.circle.fill")
                        .font(.system(size: 40))
                }
                .padding()

                VStack(alignment:.leading){
                    HStack{
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color.yellow)
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color.yellow)
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color.yellow)
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color.yellow)
                        Image(systemName: "star")
                            .foregroundStyle(Color.yellow)
                        Text("(\(food.review))")
                        Spacer()
                    }
                    .padding()
                    HStack{
                        Text(food.description)
                            .font(.title3)
                    }
                    .padding()
                }
              
                
            }.frame(height: 650)
            .background(Color.white)
            .cornerRadius(20)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10))
//                .shadow(radius: 30)
                
                
            
            HStack{
                HStack {
                    Button{
                        if numberOfItem > 1{
                            numberOfItem -= 1
                        }
                    }label: {
                        Text("-")
                            .font(.system(size: 30))
                    }
                    Spacer()
                    Text("\(numberOfItem)")
                        .foregroundStyle(Color.black)
                        .font(.system(size: 20))
                    Spacer()
                    Button{
                        numberOfItem += 1
                    }label: {
                        Text("+")
                            .font(.system(size: 30))
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 30))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundStyle(Color(.red))
                )
                
                Spacer()
                Button{
                    // Saving of Data in Cart
                    addToCart()
                    dismiss()
                    
                    
                    
                }label: {
//                    Spacer()
                    Text("Add Item ₹\(numberOfItem * 250)")
                    
//                    Spacer()
                }
                .padding()
                .foregroundStyle(Color.white)
                .background(Color.red)
                .cornerRadius(10)
                

            }.padding()
            
            
        }
        .frame(height: 750)
        .padding()
        .cornerRadius(20)
        .shadow(radius: 10)
    }
    
    private func addToCart(){
        let context = PersistenceController.shared.container.viewContext
        
        let newCart = Cart(context: context)
        newCart.id = UUID()
        newCart.restuarantName = restuarant.name
        newCart.dishName = food.name
        newCart.dishImage = food.image
        newCart.quantity = Int64(numberOfItem)
        newCart.price = Double(food.price)
        newCart.userNumber = userContact
        
        do{
            try context.save()
            print("Added Cart Successfully")
        }catch{
            print(error.localizedDescription)
            print("Failed to Cart")
        }
        
    }
    
}

//#Preview {
//    CustomizationView()
//}
