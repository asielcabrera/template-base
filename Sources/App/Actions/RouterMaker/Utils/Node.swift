//
//  Node.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/20/24.
//

import Foundation
import CoreLocation

struct Node: Hashable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.id == rhs.id && lhs.coordinates == rhs.coordinates
    }
    
    let id: UUID
    let coordinates: CLLocationCoordinate2D
}

extension CLLocationCoordinate2D: @retroactive Equatable {}
extension CLLocationCoordinate2D: @retroactive Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine("\(latitude) - \(longitude)")
    }
    
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
