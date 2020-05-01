//
//  MapViewController.swift
//  QuarantineApp
//
//  Created by Radu Onescu on 01/05/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    var destinationLatitude = 0.0;
    var destinationLongitude = 0.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        createRoute()
    }
    
    func createRoute(){
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: locationManager.location!.coordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: destinationLatitude, longitude: destinationLongitude), addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .walking
        
        
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if let response = response {
                for route in response.routes {
                    self.mapView.addOverlay(route.polyline)
                    self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        return renderer
    }
    
    
}
