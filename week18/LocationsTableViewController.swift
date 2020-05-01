//
//  LocationsTableViewController.swift
//  QuarantineApp
//
//  Created by Radu Onescu on 01/05/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import UIKit

class LocationsTableViewController: UITableViewController {

    let locations = [
        Location(title: "Ryvangens Park", latitude: 55.723554, longitude: 12.567027),
        Location(title: "Faelledparken", latitude: 55.700674, longitude: 12.567631),
        Location(title: "Amagerstrand", latitude: 55.657282, longitude: 12.637615)
    ]
    var selectedLatitude = 0.0
    var selectedLongitude = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            if let destination = segue.destination as? MapViewController {
                destination.destinationLatitude = self.selectedLatitude
                destination.destinationLongitude = self.selectedLongitude
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath);
        cell.textLabel?.text = locations[indexPath.row].title
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLatitude = locations[indexPath.row].latitude!
        selectedLongitude = locations[indexPath.row].longitude!
        self.performSegue(withIdentifier: "showMap", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
