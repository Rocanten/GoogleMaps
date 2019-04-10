//
//  MapsViewController.swift
//  Maps
//
//  Created by Egor on 08/04/2019.
//  Copyright © 2019 Egor Markov. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MapsViewController: UIViewController {
    @IBOutlet weak var mapView: UIMapsView!
    @IBOutlet weak var topBarView: UITopBarView!
    var currentPosition: CLLocation?
    var nonAuthorized = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.locationManagerDelegate = self
        topBarView.delegate = self
    }
}

extension MapsViewController: LocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocation location: CLLocation) {
        manager.stopUpdatingLocation() // Consider commenting
        currentPosition = location
        let markerLocation = CLLocation(latitude: MapsConfig.markerPosition.latitude, longitude: MapsConfig.markerPosition.longitude)
        let dist = markerLocation.distance(from: location)
        let distanceStr = dist > 1000 ? String(format: "%.1f км", dist / 1000) : String(format: "%.0f м", dist)
        topBarView.updateLabelDistance(distanceStr)
        mapView.spawnLocationMarker(at: location.coordinate)
    }
    
    func deniedLocationAccess() {
        nonAuthorized = true
    }
}

extension MapsViewController: TopBarDelegate {
    func topBar(didTapRouteButton button: UIButton) {
        if let currentPosition = currentPosition {
            let destStr = "\(MapsConfig.markerPosition.latitude),\(MapsConfig.markerPosition.longitude)"
            let posStr = "\(currentPosition.coordinate.latitude),\(currentPosition.coordinate.longitude)"
            let address = "comgooglemaps://?saddr=\(posStr)&daddr=\(destStr)&directionsmode=walking"
            UIApplication.shared.openURL(URL(string: address)!)
        } else if nonAuthorized {
            let alert = UIAlertController(title: "Невозможно построить маршрут", message: "Вы запретили приложению доступ к вашей геолокации", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
