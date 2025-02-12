//
//  LocationManager.swift
//  LocationSearch
//
//  Created by Celestial on 27/01/25.
//

import SwiftUI
import CoreLocation
import MapKit
import Combine

//MARK: Location Manager

class LocationManager: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
    // MARK: Properties
    @Published var mapView: MKMapView = .init()
    @Published var manager: CLLocationManager = .init()
    @Published var searchText: String = ""
    @Published var fetchedPlaces: [CLPlacemark] = []
    @Published var userLocation: CLLocation?
    @Published var pickedLocations: CLLocation?
    @Published var pickedPlaceMark: CLPlacemark?
    
    private var cancellable: AnyCancellable?

    override init() {
        super.init()
        manager.delegate = self
        mapView.delegate = self
        manager.requestWhenInUseAuthorization()
        // Fix: Set explicit background color
          mapView.backgroundColor = .white
          mapView.layer.backgroundColor = UIColor.white.cgColor
        watchSearchText()
       
    }

    private func watchSearchText() {
        cancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] value in
                self?.fetchPlaces(query: value)
            }
    }

    
    func fetchPlaces(query: String) {
        guard !query.isEmpty else {
            DispatchQueue.main.async { self.fetchedPlaces = [] }
            return
        }
        Task {
            do {
                let request = MKLocalSearch.Request()
                request.naturalLanguageQuery = query.lowercased()
                let response = try await MKLocalSearch(request: request).start()
                await MainActor.run {
                    self.fetchedPlaces = response.mapItems.compactMap { $0.placemark }
                    print("Fetched places: \(self.fetchedPlaces)")  // Debugging line
                }
            } catch {
                print("Error fetching places: \(error.localizedDescription)")
            }
        }
    }


    func setMapRegion(coordinate: CLLocationCoordinate2D) {
        mapView.region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        addDraggablePin(coordinate: coordinate)
        updatePlacemark(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
    }

    func addDraggablePin(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Selected Location"
        mapView.addAnnotation(annotation)
    }

    func updatePlacemark(location: CLLocation) {
        Task {
            do {
                guard let place = try await CLGeocoder().reverseGeocodeLocation(location).first else { return }
                await MainActor.run {
                    self.pickedPlaceMark = place
                }
            } catch {
                print("Error updating placemark: \(error.localizedDescription)")
            }
        }
    }

    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager Error: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied:
            print("Location access denied.")
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }

    // MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "DELIVERYPIN")
        marker.isDraggable = true
        return marker
    }

    // Handle dragging annotation and update location
    func mapView(_ mapView: MKMapView, annotationView: MKAnnotationView, didChange state: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        if state == .ending {
            if let newLocation = annotationView.annotation?.coordinate {
                pickedLocations = CLLocation(latitude: newLocation.latitude, longitude: newLocation.longitude)
                updatePlacemark(location: pickedLocations!)
            }
        }
    }
}
