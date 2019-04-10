//
//  LocationManagerDelegate.swift
//  Maps
//
//  Created by Egor on 08/04/2019.
//  Copyright © 2019 Egor Markov. All rights reserved.
//

import Foundation
import GoogleMaps

protocol LocationManagerDelegate: class {
    func locationManager(_ manager: CLLocationManager, didUpdateLocation location: CLLocation)
    func deniedLocationAccess()
}
