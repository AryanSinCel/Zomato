import Foundation
import CoreLocation

//MARK: - Device Location Helper
class DeviceLocationService: NSObject, CLLocationManagerDelegate {
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()

    private var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)?
    private var onAccessDenied: (() -> Void)?

    func requestLocationUpdates(onLocationUpdate: @escaping (CLLocationCoordinate2D) -> Void, onAccessDenied: @escaping () -> Void) {
        self.onLocationUpdate = onLocationUpdate
        self.onAccessDenied = onAccessDenied

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            onAccessDenied()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        default:
            manager.stopUpdatingLocation()
            onAccessDenied?()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        onLocationUpdate?(location.coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed: \(error.localizedDescription)")
    }
    
   

    
}
