//
//  UIMapsView.swift
//  Maps
//
//  Created by Egor on 08/04/2019.
//  Copyright © 2019 Egor Markov. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class UIMapsView: UIView {
    private var locationManager = CLLocationManager()
    var mapView: GMSMapView!
    var destinationMarker: GMSMarker!
    var locationMarker: GMSMarker?
    weak var locationManagerDelegate: LocationManagerDelegate? {
        didSet {
            //mapView.isMyLocationEnabled = true
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let camera = GMSCameraPosition.camera(withLatitude: MapsConfig.markerPosition.latitude, longitude: MapsConfig.markerPosition.longitude, zoom: 10.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: mapView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: mapView, attribute: .bottom, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: mapView, attribute: .trailing, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: mapView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        addConstraints([topConstraint, bottomConstraint, trailingConstraint, leadingConstraint])
        //mapView.settings.myLocationButton = true
        spawnDestinationMarker()
    }
    
    private func spawnDestinationMarker() {
        destinationMarker = GMSMarker()
        destinationMarker.position = CLLocationCoordinate2D(latitude: MapsConfig.markerPosition.latitude, longitude: MapsConfig.markerPosition.longitude)
        destinationMarker.title = "Точка 2"
        let image = UIImage.getSizedImage(image: UIImage(named: "Info")!, scaledToSize: CGSize(width: 32, height: 32))
        destinationMarker.iconView = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
        destinationMarker.iconView?.tintColor = UIColor(red: 0.95, green: 0.47, blue: 0.42, alpha: 1.0)
        destinationMarker.map = mapView
    }
    
    func spawnLocationMarker(at position: CLLocationCoordinate2D) {
        guard locationMarker == nil else { return }
        locationMarker = GMSMarker()
        locationMarker?.position = position
        locationMarker?.title = "Ваше местоположение"
        let image = UIImage.getSizedImage(image: UIImage(named: "Pin")!, scaledToSize: CGSize(width: 32, height: 32))
        locationMarker?.iconView = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
        locationMarker?.map = mapView
    }
}

extension UIMapsView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationManagerDelegate?.locationManager(manager, didUpdateLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            break
        case .restricted:
            break
        case .denied:
            locationManagerDelegate?.deniedLocationAccess()
            break
        default:
            break
        }
    }

}
