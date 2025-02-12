//
//  YourProfileView.swift
//  Zomato
//
//  Created by Celestial on 30/01/25.
//

import SwiftUI

//MARK: Your Profile View

struct YourProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var name : String = ""
    @State private var email: String = ""
    @State private var number : String = ""
    @State private var dob : Date = Date()
    @State private var showDatePicker: Bool = false
    @State private var addProfile: Bool = false
    @State private var personImage = UIImage()
    @State private var gender: String = ""
    @State private var anniversary: Date = Date()
    
    @EnvironmentObject var authManager: AuthManager
    
    let genderOptions = ["Male","Female","Trans"]
    
    var body: some View {
        VStack(spacing:0){
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .padding(12)
                    Text("Your Profile")
                        .font(.title2)
                        .fontWeight(.bold)
                        
                }
                .foregroundStyle(Color.black)
                Spacer()
            }
            
//            Spacer()
            
        //MARK: Profile Details
        
        ScrollView(showsIndicators:false){
            ZStack(alignment:.center){
                
                Image(uiImage: personImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100,height: 100)
//                    .background(Color.red)
                    .cornerRadius(50)
                    .padding(.top,-350)
                    .overlay(content: {
                        Circle()
                            .stroke()
                            .cornerRadius(50)
                    })
                
                    .zIndex(2)
                Image("profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 360)
//                    .foregroundStyle(Color.white)
                    .background(Color.purple)
//                    .cornerRadius(65)
                    .zIndex(1)
                    .padding(EdgeInsets(top: -380, leading: 0, bottom: 0, trailing: 0))
                    .onTapGesture {
                        addProfile.toggle()
                    }
                    //MARK: Opening Image Picker
                    .sheet(isPresented: $addProfile){
                    
                        ImagePicker(selectedImage: $personImage)
                    }
                VStack{
                    TextField(text: $name) {
                        Text("Name")
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.0)
                        .foregroundStyle(Color(.systemGray4))
                    )
                    TextField(text: $number) {
                       Text("Mobile")
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.0)
                        .foregroundStyle(Color(.systemGray4))
                    )
                    TextField(text: $email) {
                        Text("Email")
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.0)
                        .foregroundStyle(Color(.systemGray4))
                    )
                    
                        DatePicker(
                                "Date of birth",
                                selection: $dob,
                                displayedComponents: [.date]
                            )
                        .datePickerStyle(CompactDatePickerStyle())
                        .foregroundStyle(Color.gray)

                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.0)
                        .foregroundStyle(Color(.systemGray4))
                    )
                    
                    DatePicker(
                            "Anniversary",
                            selection: $anniversary,
                            displayedComponents: [.date]
                        )
                    .foregroundStyle(Color.gray)
                    .datePickerStyle(CompactDatePickerStyle())

                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundStyle(Color(.systemGray4))
                )
                    
                    Button{
                        //
                    }label: {
                        Text("Gender")
                        Spacer()
                        Picker("Gender", selection: $gender) {
                            ForEach(genderOptions, id: \.self) {
                                            Text($0)
                                        }
                                    }
                                    .pickerStyle(.menu)
                                    .tint(Color.gray)
                    }.foregroundStyle(Color.gray)
                    
                    
                             

                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.0)
                        .foregroundStyle(Color(.systemGray4))
                    )
                }
                    .frame(height: 550)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding()
            }
            .padding(.top,100)
                
        }
        .padding()
        
        //MARK: Update Button
        
        Button{
            
            updateUserProfile()
            
        }label: {
            Text("Update profile")
                .font(.title2)
                .foregroundStyle(Color.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.red)
        .cornerRadius(10)
        .padding()
        
        Spacer()
        }.background(Color.background)
            .onAppear {
                        if authManager.isAuthenticated {
                            loadUserProfile()
                        }
                    }
            .toolbar(.hidden,for: .tabBar)
            .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
    }
    
    //Methods to load user profile
    private func loadUserProfile() {
            if let userProfile = UserProfileManager.shared.fetchUserProfile(userNumber: authManager.userPhoneNumber) {
                name = userProfile.userName ?? ""
                email = userProfile.userEmail ?? ""
                number = userProfile.userNumber ?? ""
                gender = userProfile.gender ?? ""
                dob = userProfile.userDob.flatMap { UserProfileManager.shared.formatStringToDate(dateString: $0) } ?? Date()
                anniversary = userProfile.anniversaryDate.flatMap { UserProfileManager.shared.formatStringToDate(dateString: $0) } ?? Date()
                
                if let imageData = userProfile.profileImage, let image = UIImage(data: imageData) {
                    personImage = image
                }
            }
        }
        
        private func updateUserProfile() {
            UserProfileManager.shared.updateUserProfile(
                userNumber: number,
                name: name,
                email: email,
                dob: dob,
                gender: gender,
                image: personImage,
                anniversary: anniversary
            )
        }
    
}

#Preview {
    YourProfileView()
}

extension UserProfileManager {
    func formatStringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
}
