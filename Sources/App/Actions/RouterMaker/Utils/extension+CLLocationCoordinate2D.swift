//
//  File.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/21/24.
//

import CoreLocation

extension CLLocationCoordinate2D {
    func distance(to coordinate: CLLocationCoordinate2D) -> Double {
        let deltaLat = self.latitude - coordinate.latitude
        let deltaLon = self.longitude - coordinate.longitude
        return sqrt(deltaLat * deltaLat + deltaLon * deltaLon)
    }
}
