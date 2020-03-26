//
//  MapDataAdapter.swift
//  Map
//
//  Created by Radu Onescu on 20/03/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import Foundation
import MapKit
import FirebaseFirestore

class MapDataAdapter {
    
    static func getMarkersFromData(snap : QuerySnapshot) -> [MKPointAnnotation]{
        var markers = [MKPointAnnotation]() //Create an empty list
         for doc in snap.documents {
             let map = doc.data()
             let text = map["text"] as! String
             let coordinates = map["coordinates"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
             
             let mkAnnotation = MKPointAnnotation()
             mkAnnotation.title = text
             mkAnnotation.coordinate = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
             markers.append(mkAnnotation)
         }
        return markers
    }
}
