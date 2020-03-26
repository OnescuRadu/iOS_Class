//
//  FirebaseRepository.swift
//  Map
//
//  Created by Radu Onescu on 20/03/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirebaseRepository{
    private static let db = Firestore.firestore() // gets the instance of the db
    private static let path = "locations"
    
    static func startListener(vc: ViewController)
    {
        db.collection(path).addSnapshotListener { (snap, error) in
            if error != nil {
                return
            }
            if let snapshot = snap {
                vc.updateMarkers(snap: snapshot)
            }
            
        }

    }
    
    static func saveMarker(latitude: Double, longitude: Double, text: String){
        let newDoc = db.collection(path).document()
        var map = [String:Any]()
        map["text"] = text
        map["coordinates"] = GeoPoint.init(latitude: latitude, longitude: longitude)
        newDoc.setData(map)
    }
    
    static func removeMarker(latitude: Double, longitude: Double){
        print(latitude, longitude)
        db.collection(path).whereField("coordinates", isEqualTo: GeoPoint(latitude: latitude, longitude: longitude))
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        document.reference.delete()
                    }
                }
        }
    }
}
