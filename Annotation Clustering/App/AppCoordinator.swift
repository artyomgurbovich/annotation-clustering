//
//  AppCoordinator.swift
//  Annotation Clustering
//
//  Created by Artyom Gurbovich on 9.03.22.
//

import UIKit

final class AppCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        openMap()
    }
    
    private func openMap() {
        let hotspotsManager = HotspotsManager()
        let mapViewModel = MapViewModel(hotspotManager: hotspotsManager)
        let mapViewController = MapViewController(mapViewModel: mapViewModel)
        navigationController.pushViewController(mapViewController, animated: true)
    }
}
