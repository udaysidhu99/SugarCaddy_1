//
//  LocationManager.swift
//  SC_Test 2
//
//  Created by Uday Sidhu on 24/07/23.
//

import Foundation

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    static let shared =  LocationManager()
    
    override init(){
        super.init()
        manager.delegate = self
        manager.desiredAccuracy =  kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    func requestLocation(){
        manager.requestWhenInUseAuthorization()
    }
    
    
}

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status:   CLAuthorizationStatus)  {
        switch status{
            
        case .notDetermined:
            print("DEBUG: Not determined")
        case .restricted:
            print("DEBUG: restricted")
        case .denied:
            print("DEBUG: Not denied")
        case .authorizedAlways:
            print("DEBUG: Not auth always")
        case .authorizedWhenInUse:
            print("DEBUG: Auth when in use")
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.userLocation = location
    }
    
    
    
}

