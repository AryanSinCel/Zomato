//
//  CartView.swift
//  Zomato
//
//  Created by Celestial on 29/01/25.
//

import SwiftUI
import CoreData

//MARK: Cart View

struct CartView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = CartViewModel()
    @State private var restuarantName : String = ""
    var restaurant : String
    @State private var isPurchased : Bool = false
    @State private var isProcessing : Bool = false
    
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                                .padding(12)
                                
                           
                            Text(viewModel.cartItems.first?.restuarantName ?? "")
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundStyle(Color.black)
                        }
                        Spacer()
                    
                    Image(systemName: "arrowshape.turn.up.forward")
                        .font(.title2)
                        .padding(12)
                }
                .background(Color.white)
                
                ScrollView(showsIndicators:false){
                    
                    VStack(alignment:.leading){
                        HStack(spacing:10){
                            VStack{
                                Image("goldIcon")
                                    .resizable()
                                    .frame(width: 20,height: 20)
                                Spacer()
                            }
                          
                            VStack(alignment:.leading,spacing: 5){
                                Text("Get Gold for 3 months")
                                    .fontWeight(.semibold)
                                Text("Unlimited free deliveries & more benefits")
                                    .foregroundStyle(Color.gray)
                            }
                            Spacer()
                            VStack(alignment:.trailing,spacing: 5){
                                
                                NavigationLink(destination: PremiumView()) {
                                    Text("ADD")
                                        .padding(EdgeInsets(top: 5, leading: 27, bottom: 5, trailing: 27))
                                }
//                                Button{
//                                    
//                                }label: {
                              
//                                }
                                .foregroundStyle(Color.red)
                                .overlay(RoundedRectangle(cornerRadius: 5)
                                    .stroke(lineWidth: 1.0)
                                    .foregroundStyle(Color(.red)))
                                
                                Text("₹30")
                                    .fontWeight(.semibold)
                            }
                            
                        }
                        
                     
                        ForEach(viewModel.cartItems){item in
                            HStack{
                                VStack{
                                    Image(systemName: "circle.square.fill")
                                        .foregroundStyle(Color.green)
                                    Spacer()
                                }
                                VStack(alignment:.leading,spacing: 5){
                                    Text(item.dishName ?? "")
                                        .fontWeight(.semibold)
                                    Text("₹\(Int(item.price))")
                                        .foregroundStyle(Color.gray)
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                                Spacer()
                                
                                VStack(alignment:.trailing){
                                    HStack {
                                        Button{
    //                                        if numberOfItem > 1{
    //                                            numberOfItem -= 1
    //                                        }
                                            viewModel.decreaseQuantity(for: item)
                                        }label: {
                                            Text("-")
                                                
                                        }
                                        .foregroundStyle(Color.red)
                                        
                                        Spacer()
                                        Text("\(Int64(item.quantity))")
                                            .foregroundStyle(Color.black)
                                     
                                        Spacer()
                                        Button{
    //                                        numberOfItem += 1
    //                                        increaseQuantity(for: item)
                                            viewModel.increaseQuantity(for: item)
                                            
                                        }label: {
                                            Text("+")
                                            
                                        }
                                        
                                        .foregroundStyle(Color.red)
                                    }
                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    .overlay(RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 1.0)
                                        .foregroundStyle(Color(.red))
                                    )
                                    .frame(width: 90)
                                    
                                    Text("₹\(Int(Double(item.quantity) * item.price))")

                                }
                                
                            }
                        }
                       

                        HStack{
                            Button{
                                
                            }label: {
                                Image(systemName: "plus")
                                Text("Add items")
                                    .fontWeight(.semibold)
                            }.foregroundStyle(Color.red)
                           
                        }
                           
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack{
                        Button{
                            
                        }label: {
                            Image("offer")
                                .resizable()
                                .frame(width: 20,height: 20)
                            Text("View all coupons")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundStyle(Color.black)
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                 
                    VStack(spacing:15){
                        HStack{
                            Image(systemName: "stopwatch")
                            Text("Delivery in **19 mins**")
                            Spacer()
                        }
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .frame(height: 1)
                            .foregroundStyle(Color.gray)
                            
                        HStack{
                            Image("home")
                                .resizable()
                                .frame(width: 20,height: 20)
                            
                            VStack(alignment:.leading){
                                Text("Delivery at **Home**")
                                Text(UserDefaults.standard.string(forKey: "address") ?? "")
                                    .foregroundStyle(Color.gray)
                            }
     
                            Spacer()
                            VStack
                            {
                                Image(systemName: "chevron.right")
                                Spacer()
                            }
                            
                        }
                        
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .frame(height: 1)
                            .foregroundStyle(Color.gray)
                        
                        HStack{
                           
                            Image(systemName: "phone.badge.waveform")
                            Text("\(UserDefaults.standard.string(forKey: "userName") ?? "User") , **+91-\(UserDefaults.standard.string(forKey: "userPhoneNumber") ?? "")**")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .frame(height: 1)
                            .foregroundStyle(Color.gray)
                        
                        HStack{
                            Image(systemName: "text.page")
                            VStack(alignment:.leading,spacing: 5){
                                Text("Total Bill **₹\(String(format: "%.2f", viewModel.totalPrice))**")

                                Text("Incl. taxes and charges")
                                    .foregroundStyle(Color.gray)
                            }
                            Spacer()
                            VStack{
                                Image(systemName: "chevron.right")
                                Spacer()
                            }
                        }
                    }.padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    HStack{
                        VStack(alignment:.leading){
                            Text("CANCELLATION POLICY")
                                .fontWeight(.semibold)
                            Text("Help us reduce food waste by avoiding cancellations. The amount paid is non-refundable after placing the order.")
                        }
                        Spacer()
                    }
                    .padding(.top)
                    .foregroundStyle(Color.gray)
                    
                   
                    
                    
                }.padding()
                
                
                VStack {
                    HStack {
                        Button {
                            // Show progress
                            isProcessing = true
                            
                            // Simulate payment processing delay
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                // Remove items from the cart after delay
                                
                                //Saving Item in orders
                                saveOrder()
                                
                                viewModel.clearCart()
                                isPurchased = true
                                isProcessing = false
                                
                            }
                            
                        } label: {
                            Spacer()
                            if isProcessing {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else if isPurchased {
                                Text("Thank You For Purchase")
                                    .foregroundStyle(Color.white)
                            } else {
                                Text("Payment")
                                    .foregroundStyle(Color.white)
                            }
                            Spacer()
                        }
                        .padding()
                        .frame(width: 350)
                        .background(Color.red)
                        .cornerRadius(10)
                    }
                }

                
            }
            .onAppear(perform: {
                viewModel.fetchCartItems(for: restaurant)
                print("restuarantName : \(restaurant)")
            })
                .background(Color.background)
                .toolbar(.hidden,for: .tabBar)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
        }
       
       
    }
    
    func saveOrder(){
        let context = PersistenceController.shared.container.viewContext
        let newOrder = Order(context: context)
        newOrder.id = UUID()
        newOrder.address = UserDefaults.standard.string(forKey: "address")
        newOrder.orderDate = formattedDate(Date())
        newOrder.orderItemImage = viewModel.cartItems.first?.dishImage
        newOrder.restaurantName = restaurant
        newOrder.total = String(viewModel.totalPrice)
        newOrder.userNumber = UserDefaults.standard.string(forKey: "userPhoneNumber")
        
        do{
            try context.save()
            print("Order added successfully")
        }catch{
            print(error.localizedDescription)
            print("Failed to add successfully")
        }
        
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, h:mm a" // Example: 11 Feb, 12:40 PM
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: date)
    }
    
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
