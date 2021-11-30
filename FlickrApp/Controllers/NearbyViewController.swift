//
//  NearbyViewController.swift
//  FlickrApp
//
//  Created by Юра Маргітич on 30.11.2021.
//

import UIKit
import CoreLocation

class NearbyViewController: GalleryViewController {
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation()
    }
    
    // MARK: - Helper Methods
    private func getLocation() {
        let authStatus = locationManager.authorizationStatus
        
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    override func loadMoreData() {
        currentPage += 1
        guard let latitude = apiRequest?.latitude, let longitude = apiRequest?.longitude else {
            return
        }
        apiRequest = APIRequest(latitude: latitude, longitude: longitude, page: currentPage)
    }
}

// MARK: - CLLocationManagerDelegate
extension NearbyViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        
        let latitude: Double = newLocation.coordinate.latitude
        let longitude: Double = newLocation.coordinate.longitude
        print("Latitude: \(latitude)", "Longitude: \(longitude)")
        
        currentPage = 1
        apiRequest = APIRequest(latitude: latitude, longitude: longitude, page: currentPage)
        
        manager.stopUpdatingLocation()
        manager.delegate = nil
    }
}
