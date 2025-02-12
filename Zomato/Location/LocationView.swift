import SwiftUI
import CoreLocation
import MapKit

struct LocationView: View {
    @State private var location: String = ""
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ViewModel()
    @State var places = [Feature]()
    @State var address : String = UserDefaults.standard.string(forKey: "address") ?? "Tap here to enable your device location for a better experience."
    @State var enabling : String = "Device location not enabled"
    @State var enable : Bool = false
    
    @StateObject var locationManager: LocationManager = .init()
    
    @EnvironmentObject var coordinate : GlobalData
    
    // MARK: Navigation Tag to push view to MapView
    @State private var navigationTag: String?
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                HStack {
                    Image(systemName: "chevron.down")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
                    Text("Select a location")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                }
            }
            .padding()
            .zIndex(1)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .fontWeight(.semibold)
                    .imageScale(.large)
                
                TextField("Search for area, street name...", text: $locationManager.searchText)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .foregroundStyle(Color.red)
            .tint(.black)
            .frame(height: 44)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(Color(.systemGray4))
            ).padding(.top,50)
            .padding()
            .background(Color.background)
        }
        .frame(height: 80)
        .background(Color.background)
        
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                // Device location
                VStack {
                    HStack {
                        Image(systemName: "location.circle")
                            .font(.title3)
                            .fontWeight(.semibold)
                        VStack(alignment: .leading, spacing: 10) {
                            Text(enabling)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.red)
                            Text(address)
                        }
                        Spacer()
                        Button {
                            // Handle enabling location
                        } label: {
                            if enable {
                                Image(systemName: "chevron.right")
                            } else {
                                Text("Enable")
                                    .font(.title3)
                            }
                        }
                        .foregroundStyle(Color.red)
                    }
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    
                    Divider()
                    
                    // Getting Current location
                    Button {
                        let userLocation = coordinate
                        locationManager.setMapRegion(coordinate: CLLocationCoordinate2D(latitude: userLocation.coordinate.lat, longitude: userLocation.coordinate.lon))
                        address = "Your Current Location"
                        navigationTag = "MAPVIEW"
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Address")
                                .fontWeight(.semibold)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    .foregroundStyle(Color.red)
                    .background(Color.white)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                
                HStack {
                    Image(systemName: "square.and.arrow.down.on.square")
                        .font(.title3)
                        .fontWeight(.semibold)
                    VStack(alignment: .leading) {
                        Text("Import addresses from Blinkit")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text("Get saved addresses in one click")
                    }
                    Spacer()
                    Button {
                        // Handle import action
                    } label: {
                        Text("Import")
                            .font(.title3)
                            .foregroundStyle(Color.red)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                
                HStack {
                    Rectangle()
                        .frame(width: 80, height: 0.4)
                        .foregroundStyle(Color("DividerColor"))
                    Text("NEARBY LOCATIONS")
                    Rectangle()
                        .frame(width: 80, height: 0.4)
                        .foregroundStyle(Color("DividerColor"))
                }
                .foregroundStyle(Color.gray)
                .padding(.top)
                
                // List of Fetched Places
                VStack(alignment: .leading) {
                    LazyVStack {
                        if !locationManager.fetchedPlaces.isEmpty {
                            ForEach(locationManager.fetchedPlaces, id: \.self) { place in
                                HStack {
                                    Button(action: {
                                        navigationTag = "MAPVIEW"
                                        locationManager.setMapRegion(coordinate: place.location!.coordinate)
                                        address = place.name ?? "nil"
                                        UserDefaults.standard.set(address, forKey: "address")
                                        
                                    
                                    }) {
                                        HStack(spacing: 15) {
                                            Image(systemName: "mappin.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.gray)
                                            
                                            VStack(alignment: .leading, spacing: 6) {
                                                Text(place.name ?? "Unknown Place")
                                                    .font(.title3.bold())
                                                    .foregroundStyle(.primary)
                                                
                                                Text(place.locality ?? "Unknown Locality")
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        .foregroundStyle(Color.black)
                                        .padding(5)
                                    }
                                    Spacer()
                                }
                            }
                        } else {
                            // Show this list when data is fetched from fetchPlaceNames
                            ForEach(places, id: \.self) { item in
                                HStack {
                                    Button {
                                        print(item.properties.address_line1!)
                                        address = item.properties.address_line1 ?? "Nil"
                                        UserDefaults.standard.set(address, forKey: "address")
                                    } label: {
                                        HStack {
                                            VStack {
                                                Image("location")
                                                    .resizable()
                                                    .renderingMode(.template)
                                                    .frame(width: 20, height: 20)
                                                    .foregroundColor(.gray)
                                            }
                                            VStack(alignment: .leading) {
                                                Text(item.properties.address_line1 ?? "nil")
                                                    .fontWeight(.semibold)
                                                Text("\(item.properties.suburb ?? "nil"), \(item.properties.state ?? "nil")")
                                                    .foregroundColor(.gray)
                                            }
                                            Spacer()
                                        }
                                        .padding(.vertical, 8)
                                    }
                                    .tint(Color.black)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .frame(width: 330)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            }
            .background {
                NavigationLink(tag: "MAPVIEW", selection: $navigationTag) {
                    MapViewSelection()
                        .environmentObject(locationManager)

                        .ignoresSafeArea()
                } label: {}
                .labelsHidden()
            }
            .padding()
            .toolbar(.hidden, for: .tabBar)
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
        .background(Color.background)
        .onAppear {
            // Perform the location status check asynchronously
            DispatchQueue.global(qos: .background).async {
                let status = checkStatus()

                // Update UI on the main thread after checking the status
                DispatchQueue.main.async {
                    if status != 0 {
                        self.enabling = "Device location enabled"
                        address = UserDefaults.standard.string(forKey: "address") ?? "Tap here to enable your device location for a better experience."
                        enable = true
                    }
                }
            }

            // Fetch places after status check
            viewModel.fetchPlaceNames { GeoapifyResponse in
                self.places = GeoapifyResponse.features
            }
        }

    }
    
    func checkStatus() -> Int {
        let locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
                case .notDetermined, .restricted, .denied:
                    return 0
                case .authorizedAlways, .authorizedWhenInUse:
                    return 1
                @unknown default:
                    break
            }
        } else {
            return -1
        }
        return -1
    }
}

// Add a preview provider
#Preview {
    LocationView()
}
