import SwiftUI
import CoreData

//MARK: OTP Verification
struct OTPVerification: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var authManager: AuthManager
    
    let otpLength = 6
    @State private var otpValues: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedIndex: Int?
    
    @State private var timeRemaining = 30
    @State private var timerRunning = false
    @State private var timer: Timer? = nil
    @State private var isVerified = false  // State variable for navigation
    
    var contactNumber: String
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button {
                        dismiss() // back to login page
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                    }
                    
                    Text("OTP Verification")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    NavigationLink(destination: MainTabView()) {
                        Text("Skip")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.black)
                    }
                }
                .padding()
                
                Spacer()
                
                Text("We have sent a verification code to **+91-\(contactNumber)**")
                    .font(.title2)
                    .padding()
                    .multilineTextAlignment(.center)
                
                HStack {
                    ForEach(0..<otpLength, id: \.self) { index in
                        TextField("", text: $otpValues[index])
                            .frame(width: 50, height: 50)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .textContentType(.oneTimeCode)
                            .focused($focusedIndex, equals: index)
                            .foregroundColor(.black)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                                    .foregroundStyle(Color.gray)
                            }
                            .onChange(of: otpValues[index]) { newValue in
                                if newValue.count > 1 {
                                    otpValues[index] = String(newValue.prefix(1))
                                }
                                if !newValue.isEmpty, index < otpLength - 1 {
                                    focusedIndex = index + 1
                                }
                                checkOTP() // Check OTP after input
                                
                            }
                            .onAppear {
                                if index == 0 {
                                    focusedIndex = 0
                                }
                                
                                
                            }
                    }
                }
                
                HStack {
                    Text("Didn't get the OTP?")
                        .fontWeight(.semibold)
                    
                    if timerRunning {
                        Text("Resend SMS in \(timeRemaining)s")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.gray)
                    } else {
                        Button {
                            startTimer()
                        } label: {
                            Text("Resend SMS")
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.red)
                        }
                    }
                }
                .onAppear(perform: startTimer)
                .padding()
                
                Button {
                    // Add other options action
                } label: {
                    Text("Try more options")
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.red)
                }
                
                Spacer()
                Spacer()
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Text("Go Back to login methods")
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.red)
                }
                
                // **Navigation Trigger on OTP Verification**
                NavigationLink(destination: MainTabView(), isActive: $isVerified) {
                    EmptyView()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    //Checking the filled otp
    private func checkOTP() {
        let enteredOTP = otpValues.joined()
        if enteredOTP == "111111" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Delay to ensure UI updates properly
                authManager.login(with: contactNumber)
                // Check the given number in User database if present do nothing otherwise add number to new user with all fields empty
                saveUserIfNotExists()
                
            }
        }
    }
    
    //Checking the existence of user
    private func saveUserIfNotExists() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userNumber == %@", contactNumber)
        
        do {
            let existingUsers = try context.fetch(fetchRequest)
            
            if existingUsers.isEmpty {
                // Create new user since it's not found
                let newUser = User(context: context)
                newUser.userNumber = contactNumber
                newUser.userId = UUID()
                
                try context.save()
                if let storeURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
                    print("Core Data Store Location: \(storeURL)")
                }
                print(contactNumber)
                print("New user added successfully!")
            } else {
                print("User already exists.")
            }
            
            
            
        } catch {
            print("Failed to fetch or save user: \(error.localizedDescription)")
        }
    }

    //Starting timer
    private func startTimer() {
        timeRemaining = 10
        timerRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 1 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                timerRunning = false
            }
        }
    }
}

#Preview {
    OTPVerification(contactNumber: "**********")
}
