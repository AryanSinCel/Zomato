import SwiftUI
import CoreData

struct OrderView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @State private var orders: [Order] = []
    @State private var filteredOrders: [Order] = []
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .padding(12)
                    Text("Your Order")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
            }
            .foregroundStyle(Color.black)
            
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.medium)
                    
                    TextField("Search by restaurant", text: $searchText, onEditingChanged: { _ in
                        filterOrders()
                    })
                    .foregroundStyle(Color.black)
                    .onChange(of: searchText) { _ in
                        filterOrders()
                    }
          
                    Button {
                        searchText = ""
                        filterOrders()
                    } label: {
                        if !searchText.isEmpty {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .foregroundStyle(Color.red)
                .frame(height: 44)
                .padding(.horizontal)
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1.0)
                    .foregroundStyle(Color(.systemGray4)))
                .background(Color.white)
                .cornerRadius(8)
                .padding()
                .shadow(radius: 2)
            }
            
            if filteredOrders.isEmpty {
                Spacer()
                Image("order")
                    .resizable()
                    .scaledToFit()
                Spacer()
            } else {
                ScrollView {
                    ForEach(filteredOrders) { item in
                        VStack(alignment: .leading) {
                            HStack {
                                AsyncImage(url: URL(string: item.orderItemImage ?? "")) { phase in
                                    if let image = phase.image {
                                        image.resizable()
                                            .frame(width: 80, height: 80)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    } else if phase.error != nil {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .foregroundColor(.gray)
                                    } else {
                                        ProgressView()
                                            .frame(width: 80, height: 80)
                                    }
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(item.restaurantName ?? "Unknown Restaurant")
                                        .fontWeight(.semibold)
                                    Text(item.address ?? "")
                                    Text("View menu")
                                        .font(.callout)
                                        .foregroundStyle(Color.red)
                                }
                            }
                            
                            HStack {
                                Text("Order placed on \(item.orderDate ?? "")")
                                    .font(.callout)
                                Spacer()
                                Text("₹\(item.total ?? "0")")
                                    .fontWeight(.semibold)
                                Image(systemName: "chevron.right")
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                    .padding()
                }
            }
        }
        .onAppear(perform: getAllOrders)
        .navigationBarBackButtonHidden()
        .background(filteredOrders.isEmpty ? Color("background") : Color.white)
    }
    
    //MARK: Getting Order
    func getAllOrders() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Order> = Order.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userNumber == %@", UserDefaults.standard.string(forKey: "userPhoneNumber") ?? "")
        
        do {
            orders = try context.fetch(fetchRequest)
            filteredOrders = orders // Initially show all orders
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: Filter Order
    func filterOrders() {
        if searchText.isEmpty {
            filteredOrders = orders
        } else {
            filteredOrders = orders.filter { $0.restaurantName?.localizedCaseInsensitiveContains(searchText) ?? false }
        }
    }
}
