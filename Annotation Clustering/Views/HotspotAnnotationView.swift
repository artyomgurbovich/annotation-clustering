//
//  HotspotAnnotationView.swift
//  Annotation Clustering
//
//  Created by Artyom Gurbovich on 9.03.22.
//

import MapKit

final class HotspotAnnotationView: MKMarkerAnnotationView {
        
    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultHigh
        markerTintColor = .systemBlue
        glyphImage = #imageLiteral(resourceName: "Hotspot")
    }
}
