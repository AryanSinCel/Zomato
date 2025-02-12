import SwiftUI
import CoreLocation


class GlobalData: ObservableObject {
    @Published var coordinate: (lat: Double, lon: Double) = (0, 0)
}


//MARK: Navigation View

struct NavigationView: View {
    @StateObject private var coordinate = GlobalData()
    @State private var placeCity: String = (UserDefaults.standard.string(forKey: "locality") ?? "nil")
    @State private var placeState: String = (UserDefaults.standard.string(forKey: "administrativeArea") ?? "nil")
    @State private var placeCountry: String = (UserDefaults.standard.string(forKey: "country") ?? "nil")
    @State private var food = ""
    private let geocoder = CLGeocoder()
    private let locationService = DeviceLocationService()
//    @StateObject var coordinate = GlobalData()

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    
                    //MARK: Location View
                    NavigationLink(
                        destination:
                            LocationView().environmentObject(coordinate)
                        
                    ) {
                        HStack {
                            Image("location")
                                .resizable()
                                .frame(width: 30, height: 30)

                            VStack {
                                HStack {
                                    Text(placeCity)
                                        .frame(height: 14)
                                        .font(.title2)
                                        .fontWeight(.heavy)

                                    Image(systemName: "chevron.down")
                                }

                                Text("\(placeState), \(placeCountry)")
                            }
                        }
                    }
                    .tint(Color.black)

                    Spacer()

                    // MARK: Profile View
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.fill")
                            .padding()
                            .imageScale(.large)
                            .overlay(RoundedRectangle(cornerRadius: 30)
                                .stroke(lineWidth: 1.0)
                                .foregroundStyle(Color(.systemGray4)))
                    }
                }
                .padding(.bottom)

                HStack {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.medium)

                    TextField("Search Pizza", text: $food)

                    Button {
                        // Todo
                    } label: {
                        Divider()
                        Image(systemName: "microphone")
                            .tint(.black)
                            .imageScale(.medium)
                    }
                }
                .foregroundStyle(Color.red)
                .tint(.black)
                .frame(height: 44)
                .padding(.horizontal)
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1.0)
                    .foregroundStyle(Color(.systemGray4)))
                .background(Color.white)
                .cornerRadius(8)
            }
            .padding()
            .onAppear {
                setupLocationService()
            }
        }
        .environmentObject(coordinate)
        .frame(height: 150)
    }

    func setupLocationService() {
        locationService.requestLocationUpdates(
            onLocationUpdate: { coordinates in
                self.coordinate.coordinate = (coordinates.latitude, coordinates.longitude)
                fetchPlaceName(for: coordinates.latitude, longitude: coordinates.longitude)
                UserDefaults.standard.set(coordinates.latitude, forKey: "latitude")
                UserDefaults.standard.set(coordinates.longitude, forKey: "longitude")
            },
            onAccessDenied: {
                print("Show some kind of alert to the user")
            }
        )
    }

    func fetchPlaceName(for latitude: Double, longitude: Double) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                self.placeCity = "Unknown"
                self.placeState = "Unknown"
                self.placeCountry = "Unknown"
            } else if let placemark = placemarks?.first {
                self.placeCity = placemark.locality ?? "Unknown"
                self.placeState = placemark.administrativeArea ?? "Unknown"
                self.placeCountry = placemark.country ?? "Unknown"
                
                UserDefaults.standard.set(placemark.locality, forKey: "locality")
                UserDefaults.standard.set(placemark.administrativeArea, forKey: "administrativeArea")
                UserDefaults.standard.set(placemark.country, forKey: "country")
                
            } else {
                self.placeCity = "Unknown"
                self.placeState = "Unknown"
                self.placeCountry = "Unknown"
            }
        }
    }
}



#Preview {
    NavigationView()
    
}
