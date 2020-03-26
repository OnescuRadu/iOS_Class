//
//  ViewController.swift
//  Map
//
//  Created by Radu Onescu on 20/03/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager() // will handle locations (GSP, WIFI) updates
    
    @IBOutlet weak var addressField: UITextField!
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            let touchPoint: CGPoint = sender.location(in: map)
            let newCoordinate: CLLocationCoordinate2D = map.convert(touchPoint, toCoordinateFrom: map)
            showPopup(coordinates: newCoordinate)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
        
        FirebaseRepository.startListener(vc: self)
    }
    
    func showPopup(coordinates: CLLocationCoordinate2D){
        let alert = UIAlertController(title: "What's the name of the location?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input location's name here..."
        })

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

            if let title = alert.textFields?.first?.text {
                self.addMarker(coordinates: coordinates, title: title)
            }
        }))

        self.present(alert, animated: true)
    }
    
    func addMarker (coordinates: CLLocationCoordinate2D, title: String)
    {
        FirebaseRepository.saveMarker(latitude: coordinates.latitude, longitude: coordinates.longitude, text: title)
    }
    
    func updateMarkers(snap: QuerySnapshot){
        let markers = MapDataAdapter.getMarkersFromData(snap: snap)
        map.removeAnnotations(map.annotations)
        map.addAnnotations(markers)
    }
    
    func displayAddress(latitude: Double, longitude: Double){
        let myGeocorder = CLGeocoder()
        
        // Create a location.
        let myLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        // Start reverse geocoding.
        myGeocorder.reverseGeocodeLocation(myLocation, completionHandler: { (placemarks, error) -> Void in
            
            for placemark in placemarks! {
                self.addressField.text = "\(placemark.name ?? ""), \(placemark.locality ?? ""), \(placemark.country ?? "")"
            }
        })
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        if let point = view.annotation as? MKPointAnnotation{
            FirebaseRepository.removeMarker(latitude: point.coordinate.latitude, longitude: point.coordinate.longitude)
        }
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coord = locations.last?.coordinate
        displayAddress(latitude: coord!.latitude, longitude: coord!.longitude)
        ////Setting the region
//        if let coord = locations.last?.coordinate {
//            let region = MKCoordinateRegion(center: coord, latitudinalMeters: 10000, longitudinalMeters: 10000)
            //// will move the "camera"
//            map.setRegion(region, animated: true)
//        }
        
        
    }
}

