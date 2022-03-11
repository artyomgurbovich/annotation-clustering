//
//  HotspotsMapViewModel.swift
//  Annotation Clustering
//
//  Created by Artyom Gurbovich on 9.03.22.
//

import MapKit

final class MapViewModel {

    private let hotspotManager: HotspotsManagerProtocol
    
    init(hotspotManager: HotspotsManagerProtocol) {
        self.hotspotManager = hotspotManager
    }
    
    func getHotspotAnnotations(completionHandler: @escaping ([HotspotAnnotation]) -> Void) {
        hotspotManager.fetchHotspots { hotspots in
            completionHandler(hotspots.map {
                HotspotAnnotation(coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude))
            })
        }
    }
}
