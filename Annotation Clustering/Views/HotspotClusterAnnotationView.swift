//
//  HotspotClusterAnnotationView.swift
//  Annotation Clustering
//
//  Created by Artyom Gurbovich on 9.03.22.
//

import MapKit

final class HotspotClusterAnnotationView: MKAnnotationView {
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        guard let cluster = annotation as? MKClusterAnnotation else { return }
        if cluster.memberAnnotations.count >= 100 {
            bounds = CGRect(x: 0, y: 0, width: 64, height: 64)
            centerOffset = CGPoint(x: 0, y: -32)
        } else if cluster.memberAnnotations.count >= 50 {
            bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
            centerOffset = CGPoint(x: 0, y: -25)
        } else if cluster.memberAnnotations.count >= 25 {
            bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
            centerOffset = CGPoint(x: 0, y: -20)
        } else {
            bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
            centerOffset = CGPoint(x: 0, y: -16)
        }
        displayPriority = .required
        collisionMode = .circle
        image = #imageLiteral(resourceName: "HotspotCluster")
    }
}
