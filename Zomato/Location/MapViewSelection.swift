//
//  MapViewSelection.swift
//  Zomato
//
//  Created by Celestial on 28/01/25.
//

import SwiftUI
import MapKit
import CoreLocation


// MARK: Mapview live selection
struct MapViewSelection: View {
    @EnvironmentObject var locationManager: LocationManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            MapViewHelper()
                .environmentObject(locationManager)
                .ignoresSafeArea()

            if let place = locationManager.pickedPlaceMark {
                VStack(spacing: 15) {
                    
                    Text("Confirm Location")
                        .font(.title2.bold())

                    HStack(spacing: 15) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)

                        VStack(alignment: .leading, spacing: 6) {
                            Text(place.name ?? "Unknown Place")
                                .font(.title3.bold())

                            Text(place.locality ?? "Unknown Locality")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 10)

                    Button {
                        // Confirm location action
                        UserDefaults.standard.set(place.name, forKey: "address")
                        
                        dismiss()
                        
                    } label: {
                        Text("Confirm Location")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.red)
                            }
                            .overlay(alignment: .trailing) {
                                Image(systemName: "arrow.right")
                                    .font(.title3.bold())
                                    .padding(.trailing)
                            }
                            .foregroundStyle(Color.white)
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                        .ignoresSafeArea()
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
       
        .onDisappear {
            // Remove all annotations when the view disappears
            locationManager.mapView.removeAnnotations(locationManager.mapView.annotations)

            // Reset picked location and place mark
            locationManager.pickedLocations = nil
            locationManager.pickedPlaceMark = nil
        }
        .toolbarBackground(Color.white, for: .navigationBar)
                   .toolbarBackground(.visible, for: .navigationBar)
                   .navigationTitle("Confirm delivery location")
                   
      

            
    }
    
    
}




// MARK: UIKIT Mapview
struct MapViewHelper:UIViewRepresentable{
    @EnvironmentObject var locationManager: LocationManager
    func makeUIView(context: Context) -> MKMapView {
        locationManager.mapView.mapType = .standard
        locationManager.mapView.overrideUserInterfaceStyle = .light
        return locationManager.mapView
        
    }
    
    func makeUIView2(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.mapType = .standard
        mapView.overrideUserInterfaceStyle = .light
        mapView.backgroundColor = .white
        return mapView
    }

    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
}

