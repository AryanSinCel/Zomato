//
//  ProfileView.swift
//  Zomato
//
//  Created by Celestial on 23/01/25.
//


import SwiftUI
import CoreData

//MARK: Profile View

struct ProfileView: View {
    
    @State private var showMessage = false
    @State private var message: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authManager: AuthManager
    @AppStorage("mode") private var vegModeIsOn: Bool = false // Persistent storage using AppStorage
    @State private var userName: String = "Hi, User"
    @State private var userImage: UIImage? = nil // Store UIImage instead of URL
    let context = PersistenceController.shared.container.viewContext
  
    var body: some View {
        ZStack(alignment:.bottom){
            NavigationStack{
                VStack{
                    ZStack{
                        VStack{
                            HStack{
                                Button {
                                    dismiss()
                                } label: {
                                    Image(systemName: "arrow.left")
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.black)
                                        .padding(12)
                                        
                                }
                                Spacer()
                            }
                            
                            VStack(alignment:.leading){
                                HStack{
                                    // show here user image and name if available else default is person.fill and "" from core data
                                    if let userImage = userImage {
                                                                    Image(uiImage: userImage)
                                                                        .resizable()
                                                                        .frame(width: 70, height: 70)
                                                                        .clipShape(Circle())
                                                                } else {
                                                                    Image(systemName: "person.circle.fill")
                                                                        .resizable()
                                                                        .frame(width: 70, height: 70)
                                                                        .foregroundColor(.blue)
                                                                }
                                    VStack(alignment:.leading){
                                        Text(userName)
                                            .font(.title2)
                                                                        .fontWeight(.semibold)
                                                                        .foregroundStyle(Color.primary)
                                       Text("View activity")
                                            .foregroundStyle(Color.red)
                                    }
                                   
                                    
                                    
                                }.padding()
                                
                                HStack{
                                    Image("goldIcon")
                                        .resizable()
                                        .frame(width: 22,height: 22)
                                    Text("Join Zomato Gold")
                                    
                                    Spacer()
                                    
                                    //MARK: Premium View Navigation
                                    NavigationLink(destination:
                                                    PremiumView()
                                    ){
                                            Image(systemName: "chevron.right")
                                    }
                                }
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("goldS"),Color("goldM"),Color("goldL")]), startPoint: .trailing, endPoint: .leading))
                                .padding()
                                    .frame(width: 370)
                                    .background(Color.black)
                              
                                
                            }   .background(Color.white)
                                .cornerRadius(20)
                             
                        }
                        
                        
                    }
                    Spacer()
                    ScrollView(showsIndicators:false){
                        VStack{
                            HStack{
                                VStack{
                                    Image(systemName: "bookmark.circle.fill")
                                        .font(.system(size: 40))
                                    Text("Collections")
                                }
                                .padding()
                                .onTapGesture {
                                    message = "Collections"
                                    showMessage = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        showMessage = false
                                    }
                                }
                                
                                Spacer()
                                VStack{
                                    Image(systemName: "indianrupeesign.circle.fill")
                                        .font(.system(size: 40))
                                    Text("Money")
                                }
                                .padding()
                                .onTapGesture {
                                    message = "Money"
                                    showMessage = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        showMessage = false
                                    }
                                }

                            }.background(Color.white)
                                .cornerRadius(10)
                            
                            VStack{
                                //MARK: YourProfileView Navigation
                                NavigationLink(destination: YourProfileView()){
                                    HStack{
                                        Image(systemName: "person.fill")
                                        Text("Your profile")
                                        Spacer()
                                        Text("32% completed")
                                    }.padding()
                                        .background(Color.white)
                                            .cornerRadius(10)
                                }.foregroundStyle(Color.black)
                                
                                //MARK: Veg Mode
                                HStack {
                                    Image(systemName: "circle.square.fill")
                                    Text("Veg Mode")
                                    Spacer()
                                    Toggle("", isOn: $vegModeIsOn)
                                        .onChange(of: vegModeIsOn) { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "mode") // Save the updated value
                                        }
                                }
                                .padding()
                                    .background(Color.white)
                                        .cornerRadius(10)
                                HStack{
                                    Image(systemName: "paintpalette.fill")
                                    Text("Appearance")
                                    Spacer()
                                    Button{
                                        //Todo
                                    }label: {
                                        Text("LIGHT")
                                        Image(systemName: "chevron.right")
                                    }.foregroundStyle(Color.gray)
                                }.padding()
                                    .background(Color.white)
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            message = "Appearance"
                                            showMessage = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                showMessage = false
                                            }
                                        }
                                
                                //MARK: Rating
                                HStack{
                                    Image(systemName: "star.fill")
                                    Text("Your rating")
                                    Spacer()
                                    Button{
                                        vegModeIsOn.toggle()
                                    }label: {
                                        Text("--★")
                                        Image(systemName: "chevron.right")
                                    }.foregroundStyle(Color.gray)
                                }.padding()
                                    .background(Color.white)
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            message = "Rating"
                                            showMessage = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                showMessage = false
                                            }
                                        }
                            }
                            
                                VStack(alignment:.leading){
                                 
                                    Text("Food Orders")
                                        .font(.title2)
                                        .fontWeight(.semibold)

                                    //MARK: Order View
                                    NavigationLink(destination: OrderView()) {
                                        HStack{
                                            Image(systemName: "bag.fill")
                                            Text("Your Order")
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                        }
                                        .padding()
                                    }
                                    .foregroundStyle(Color.black)
                                        
    //                                }.foregroundStyle(Color.black)
                                    
                                    Divider()
                                    
                                    //MARK: Favorite Order
                                    HStack{
                                        Image(systemName: "heart.circle.fill")
                                        Text("Favorite orders")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                    .padding()
                                    .onTapGesture {
                                        message = "Favorite orders"
                                        showMessage = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            showMessage = false
                                        }
                                    }
                                    
                                    Divider()
                                    
                                    //MARK: Address book
                                    HStack{
                                        Image(systemName: "book.closed.circle.fill")
                                        Text("Address book")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                    .padding()
                                    .onTapGesture {
                                        message = "Address book"
                                        showMessage = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            showMessage = false
                                        }
                                    }
                                    
                                    Divider()
                                    
                                    //MARK: Hidden Restuarant
                                    HStack{
                                        Image(systemName: "eye.slash.fill")
                                        Text("Hidden Restaurants")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                    .padding()
                                    .onTapGesture {
                                        message = "Hidden Restaurant"
                                        showMessage = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            showMessage = false
                                        }
                                    }
                                    
                                    Divider()
                                    
                                    //MARK: Help
                                    HStack{
                                        Image(systemName: "questionmark.circle.fill")
                                        Text("Online ordering help")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                    .padding()
                                    .onTapGesture {
                                        message = "Help"
                                        showMessage = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            showMessage = false
                                        }
                                    }
                                
                                }.padding()
                                .background(Color.white)
                                    .cornerRadius(10)
                            
                            VStack(alignment:.leading){
                                Text("More")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                //MARK: About
                                HStack{
                                    Image(systemName: "info.circle.fill")
                                    Text("About")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .padding()
                                .onTapGesture {
                                    message = "About"
                                    showMessage = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        showMessage = false
                                    }
                                }
                                
                                Divider()
                                
                                //MARK: Feedback
                                HStack{
                                    Image(systemName: "message.circle.fill")
                                    Text("Send feedback")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .padding()
                                .onTapGesture {
                                    message = "Feedback"
                                    showMessage = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        showMessage = false
                                    }
                                }
                                
                                Divider()
                                
                                //MARK: Report
                                HStack{
                                    Image(systemName: "exclamationmark.circle")
                                    Text("Report a safety emergency")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .padding()
                                .onTapGesture {
                                    message = "Report"
                                    showMessage = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        showMessage = false
                                    }
                                }
                                
                                Divider()
                                
                                //MARK: Setting
                                HStack{
                                    Image(systemName: "gearshape.circle")
                                    Text("Setting")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .padding()
                                .onTapGesture {
                                    message = "Setting"
                                    showMessage = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        showMessage = false
                                    }
                                }
                                
                                
                                Divider()
                                
                                //MARK: SignUpPage View Navigation
                                NavigationLink(destination: SignPageView()){
                             
                                    HStack{
                                        
                                        Image(systemName: "power")
                                        if authManager.isAuthenticated{
                                            Text("Log out")

                                        }else{
                                            Text("Log in")

                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                    .padding()
                                    .foregroundStyle(Color.black)
                                }
                               
                            
                            
                            }.padding()
                                .background(Color.white)
                                    .cornerRadius(10)
                            
                            
                        }
                        
                        
                        
                        
                    }.padding()
                }
                .onAppear {
                               fetchUserDetails()
                           }
                .background(Color("background"))
                .toolbar(.hidden,for: .tabBar)
                .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden(true)
            }
            
            if showMessage {
                Text("\(message) is Selected")
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .transition(.opacity)
            }
        }
        
        .animation(.easeInOut, value: showMessage)
       
        
    }
    
    //fetching user detail to show profile image and name if available
    private func fetchUserDetails() {
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "userNumber == %@", UserDefaults.standard.string(forKey: "userPhoneNumber") ?? "")

            do {
                let users = try context.fetch(fetchRequest)
                if let user = users.first {
                    userName = user.userName ?? "Hi, User"
                    UserDefaults.standard.set(userName, forKey: "userName")
                    
                    // Convert Data to UIImage
                    if let imageData = user.profileImage {
                        userImage = UIImage(data: imageData)
                    } else {
                        userImage = nil
                    }
                } else {
                    userName = "Guest"
                    userImage = nil
                }
            } catch {
                print("Error fetching user: \(error.localizedDescription)")
                userName = "Guest"
                userImage = nil
            }
        }
    
}

#Preview {
    ProfileView()
}
