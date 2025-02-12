//
//  SignPageView.swift
//  Zomato
//
//  Created by Celestial on 30/01/25.
//

import SwiftUI

//MARK: SignUp Page View

struct SignPageView: View {
    @EnvironmentObject var authManager: AuthManager //Getting AuthManager object
    @State var phone : String = ""
    var body: some View {
        NavigationStack{
            VStack{
                ZStack(alignment:.topTrailing){
                    Image("logBG")
                        .resizable()
                    //                .scaledToFit()
                        .frame(height: 330)
                    
                    //MARK: MainTabView Navigation
                    NavigationLink(destination: MainTabView()) {
                        Text("Skip")
                            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                            .background(Color.brown)
                            .cornerRadius(20)
                            .foregroundStyle(Color.white)
                    .padding(EdgeInsets(top: 60, leading: 0, bottom: 0, trailing: 20))
                    }
                      
                }
               
                Spacer()
                
                Text("India's #1 Food Delivery and Dining App")
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack{
                    Rectangle()
                        .frame(width: 100,height: 0.4)
                        .foregroundStyle(Color("DividerColor"))
                        Text("Log in or sign up")
                        .fontWeight(.semibold)
                    Rectangle()
                        .frame(width: 100,height: 0.4)
                        .foregroundStyle(Color("DividerColor"))
                        
                    }
                .foregroundStyle(Color.gray)
                
                
                HStack{
                    HStack{
                        Image(systemName: "flag.2.crossed")
                        Image(systemName: "chevron.down")
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.0)
                        .foregroundStyle(Color(.systemGray4))
                    )
                    HStack{
                            Text("+91")
                            TextField("Enter Phone Number", text: $phone){
          
                        }
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.0)
                        .foregroundStyle(Color(.systemGray4))
                    )
                }.padding()
               
                //MARK: OTP Verification
            
                NavigationLink(destination: OTPVerification(contactNumber: phone)) {
                    Text("Continue")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding()
                }
               
                
                HStack{
                    Rectangle()
                        .frame(width: 170,height: 0.4)
                        .foregroundStyle(Color("DividerColor"))
                        Text("or")
                        .fontWeight(.semibold)
                    Rectangle()
                        .frame(width: 170,height: 0.4)
                        .foregroundStyle(Color("DividerColor"))
                        
                    }
                .foregroundStyle(Color.gray)
                .padding(.bottom)
                
                HStack{
                    Spacer()
                    Image("google")
                        .resizable()
                        .frame(width: 40,height: 40)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 1.0)
                            .foregroundStyle(Color(.systemGray4))
                        )
                    
                    Spacer()
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .frame(width: 40,height: 40)
                    Spacer()
                }
                
                Spacer()
                
                Text("By continuing, you agree to our")
                HStack{
                    Text("Terms of Service")
                    Text("Privacy Policy")
                    Text("Content Policy")
                }
               
                Spacer()
                
            }
            .ignoresSafeArea()
           
        }
        .onAppear(perform: {
            authManager.logout()
        })
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SignPageView()
}
