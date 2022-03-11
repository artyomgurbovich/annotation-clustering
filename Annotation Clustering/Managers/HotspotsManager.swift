//
//  HotspotsManager.swift
//  Annotation Clustering
//
//  Created by Artyom Gurbovich on 9.03.22.
//

import MapKit

protocol HotspotsManagerProtocol {
    func fetchHotspots(completionHandler: @escaping ([Hotspot]) -> Void)
}

final class HotspotsManager: HotspotsManagerProtocol {
    
    private let dispatchQueue = DispatchQueue(label: String(describing: HotspotsManager.self))
    
    func fetchHotspots(completionHandler: @escaping ([Hotspot]) -> Void) {
        guard let hotspotsPath = Bundle.main.url(forResource: "hotspots", withExtension: "csv")?.path,
              let content = try? String(contentsOfFile: hotspotsPath) else { return }
        dispatchQueue.async {
            var hotspots = [Hotspot]()
            content.components(separatedBy: "\n").forEach {
                let line = $0.components(separatedBy: ",")
                guard line.count == 4,
                      let latitude = Double(line[2]),
                      let longitude = Double(line[3]) else { return }
                hotspots.append(Hotspot(latitude: latitude, longitude: longitude))
            }
            DispatchQueue.main.async {
                completionHandler(hotspots)
            }
        }
    }
}
