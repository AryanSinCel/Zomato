import Foundation
import CoreData
import UIKit

//MARK: Profile Manager
class UserProfileManager {
    static let shared = UserProfileManager()
    let context = PersistenceController.shared.container.viewContext
    
    // Fetch user profile by userNumber
    func fetchUserProfile(userNumber: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "userNumber == %@", userNumber)
        
        do {
            let result = try context.fetch(request)
            return result.first
        } catch {
            print("Error fetching user profile: \(error.localizedDescription)")
            return nil
        }
    }
    
    // Update User Profile
    func updateUserProfile(userNumber: String, name: String, email: String, dob: Date, gender: String, image: UIImage?, anniversary: Date) {
        if let existingProfile = fetchUserProfile(userNumber: userNumber) {
            existingProfile.userName = name
            existingProfile.userEmail = email
            existingProfile.userDob = formatDateToString(date: dob)
            existingProfile.gender = gender
            existingProfile.anniversaryDate = formatDateToString(date: anniversary)
            existingProfile.userNumber = userNumber
            
            // Convert UIImage to Data
            if let img = image {
                existingProfile.profileImage = img.jpegData(compressionQuality: 0.8)
            }
            
            saveContext()
        }
    }
    
    func formatDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust the format as per your requirement
        return dateFormatter.string(from: date)
    }
    
    // Save Data
    private func saveContext() {
        do {
            try context.save()
            print("User profile updated successfully!")
        } catch {
            print("Failed to save user profile: \(error.localizedDescription)")
        }
    }
}
