//
//  PremiumView.swift
//  Zomato
//
//  Created by Celestial on 25/01/25.
//

import SwiftUI

//MARK: Premium View
struct PremiumView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
        ScrollView{
            ZStack{
                Color.black
                VStack(alignment:.leading){
                    Button {
                        //Back
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .fontWeight(.light)
                            .foregroundStyle(.white)
                            .padding(12)
                        
                    }
                    Image("gold")
                        .resizable()
                        .scaledToFit()
                    
                    VStack{
                        Text("UNLIMITED FREE DELIVERIES & MORE").zIndex(1)
                            .padding(5)
                            .overlay(RoundedRectangle(cornerRadius: 30)
                                .stroke(lineWidth: 0.5)
                                .foregroundStyle(Color(.systemGray4))
                            )
                            .background(Color.red)
                            .cornerRadius(30)
                            .foregroundStyle(Color.white)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: -25, trailing: 10))
                        
                        
                        VStack{
                            HStack(alignment:.center){
                                Image(systemName: "indianrupeesign")
                                    .font(.title)
                                    .foregroundStyle(Color("goldColor"))
                                Text("30")
                                    .font(.title)
                                
                                Text("for 3 months")
                                    .foregroundStyle(Color.white)
                            }
                            
                            Button{
                                
                            }label: {
                                Text("Join Gold")
                                    .padding()
                                    .fontWeight(.semibold)
                                    .frame(width: 360)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color("goldS"),Color("goldM"),Color("goldL")]), startPoint: .trailing, endPoint: .leading))
                                    .foregroundStyle(Color.black)
                                    .cornerRadius(20)
                            }
                            
                        }.padding(30)
                            .frame(width: 400)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 0.5)
                                .foregroundStyle(Color(.systemGray4))
                            )
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("goldS"),Color("goldM"),Color("goldL")]), startPoint: .trailing, endPoint: .leading))
                        
                    }.zIndex(0)
                    
                    
                    HStack{
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color("goldS"))
                        Text("GOLD BENEFITS")
                            .foregroundStyle(Color.white)
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color("goldS"))
                    }
                    .frame(width: 370)
                    .padding()
                    
                    VStack(alignment:.leading){
                        HStack{
                            Image("scooter")
                                .resizable()
                                .frame(width: 40,height: 40)
                            VStack(alignment:.leading){
                                Text("Free Delivery")
                                    .foregroundStyle(Color.white)
                                Text("At all restaurants under 7 km, on orders above ₹199. May not be applicable at a few restuarants that manage their own delivery")
                                    .foregroundStyle(Color.gray)
                            }
                            
                        }.padding()
                        
                        HStack{
                            Image("coupon")
                                .resizable()
                                .frame(width: 40,height: 30)
                            VStack(alignment:.leading){
                                Text("Up to 30% extra off")
                                    .foregroundStyle(Color.white)
                                Text("Above all existing offers at 20,000+ partner restaurants across India")
                                    .foregroundStyle(Color.gray)
                            }
                            
                        }.padding()
                    }
                    .frame(height: 250)
                    .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 0.5)
                            .foregroundStyle(Color(.systemGray4))
                        )
                    
                    VStack{
                        VStack(alignment:.center){
                            HStack{
                                Image(systemName: "indianrupeesign")
                                    .font(.title)
                                    .foregroundStyle(Color("goldColor"))
                                Text("30")
                                    .font(.title)
                            }
                            
                            
                            Text("for 3 months")
                                .font(.title2)
                                .foregroundStyle(Color.white)
                        }.foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("goldS"),Color("goldM"),Color("goldL")]), startPoint: .trailing, endPoint: .leading))
                            .foregroundStyle(Color.black)
                        
                        Button{
                            
                        }label: {
                            Text("Join Gold")
                                .padding()
                                .fontWeight(.semibold)
                                .frame(width: 360)
                                .background(LinearGradient(gradient: Gradient(colors: [Color("goldS"),Color("goldM"),Color("goldL")]), startPoint: .trailing, endPoint: .leading))
                                .foregroundStyle(Color.black)
                                .cornerRadius(20)
                        }.padding()
                    }
                    
                    VStack{
                        Text("Have questions?")
                            .foregroundStyle(Color.white)
                        Text("Check FAQs and terms")
                    }
                    .frame(width: 400)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("goldS"),Color("goldM"),Color("goldL")]), startPoint: .trailing, endPoint: .leading))
                    
                    
                }
                
            }
        }
        .toolbar(.hidden,for: .tabBar)
        .background(Color.black.edgesIgnoringSafeArea([.top,.bottom]))
        .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PremiumView()
}
