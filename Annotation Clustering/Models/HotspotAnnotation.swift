//
//  HotspotAnnotation.swift
//  Annotation Clustering
//
//  Created by Artyom Gurbovich on 9.03.22.
//

import MapKit

final class HotspotAnnotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
