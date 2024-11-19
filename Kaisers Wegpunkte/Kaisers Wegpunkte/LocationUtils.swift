//
//  LocationUtils.swift
//  Kaisers Wegpunkte
//
//  Created by sahi on 30.11.21.
//

import Foundation
import CoreLocation

class LocationEnvironment: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    
    @Published var places = [
        Places(headline: "Bikini Berlin", reminder: "Frau Kaiser braucht noch einen Bikini", latitude: 52.505408, longitude: 13.337878),
        Places(headline: "Waldorf Astoria", reminder: "Hotelreservierung stornieren", latitude: 52.505414, longitude: 13.332905),
        Places(headline: "Siegessäule", reminder: "Fußballspiel steht heute an", latitude: 52.514134, longitude: 13.350866),
        Places(headline: "Humboldt Universität", reminder: "Vorlesungsinhalt für Kurs vorbereiten", latitude: 52.517309, longitude: 13.393891),
        Places(headline: "Reichstag", reminder: "Bundestagswahlen stehen bald an", latitude: 52.518006, longitude: 13.376059),
        Places(headline: "Berliner Dom", reminder: "Sonntag ist Gottesdienst", latitude: 52.51864, longitude: 13.401813)
    ]
    
    func initPositionService() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        
        for region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
        for place in places {
            locationManager.startMonitoring(for: place.region)
        }
        
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        for i in 0..<places.count {
            if (places[i].id.uuidString == region.identifier) {
                places[i].setStatus(.yellow)
            }
        }
    }
}

class Places: Identifiable, ObservableObject {
    let id = UUID()
    let headline: String
    let reminder: String
    let latitude: Double
    let longitude: Double
    var status: Status = .red
    var placesDelegates: [PlacesDelegate] = []
    
    init(headline: String, reminder: String, latitude: Double, longitude: Double) {
        self.headline = headline
        self.reminder = reminder
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func setStatus(_ status: Status) {
        self.status = (self.status != .green) ? status : .green
        for delegate in placesDelegates {
            delegate.changeStatus(to: self.status)
        }
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    var region: CLCircularRegion {
        CLCircularRegion(center: self.location, radius: 1, identifier: id.uuidString)
    }
    
    func addDelegate(_ delegate: PlacesDelegate) {
        placesDelegates.append(delegate)
    }
}

enum Status {
    case red, yellow, green
}

protocol PlacesDelegate {
    func changeStatus(to: Status)
}
