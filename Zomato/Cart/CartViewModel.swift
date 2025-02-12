import SwiftUI
import CoreData

//MARK: CartViewModel

class CartViewModel: ObservableObject {
    @Published var cartItems: [Cart] = []
    var restaurantName: String = ""
    var userNumber = UserDefaults.standard.string(forKey: "userPhoneNumber") ?? ""
    
    func fetchCartItems(for restaurant: String) {
        self.restaurantName = restaurant  // Store restaurant name
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "restuarantName == %@ AND userNumber == %@", restaurant, userNumber)
        print("name : \(restaurant)")
        do {
            let cart = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.cartItems = cart
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func increaseQuantity(for item: Cart) {
        let context = PersistenceController.shared.container.viewContext
        item.quantity += 1
        saveContext()
    }

    func decreaseQuantity(for item: Cart) {
        let context = PersistenceController.shared.container.viewContext
        
        if item.quantity > 1 {
            item.quantity -= 1
        } else {
            context.delete(item)
        }
        saveContext()
    }
    
    func clearCart() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Cart.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "restuarantName == %@ AND userNumber == %@", restaurantName, userNumber)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            cartItems.removeAll()
        } catch {
            print("Failed to clear cart: \(error.localizedDescription)")
        }
    }

    private func saveContext() {
        let context = PersistenceController.shared.container.viewContext
        do {
            try context.save()
            fetchCartItems(for: restaurantName)  // Fetch updated items
        } catch {
            print("Failed to save changes: \(error.localizedDescription)")
        }
    }
    
    // Computed property to calculate total price
    var totalPrice: Double {
        cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
}
