//
//  HotspotsMapViewController.swift
//  Annotation Clustering
//
//  Created by Artyom Gurbovich on 9.03.22.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navigationButton: UIButton!
    
    private let mapViewModel: MapViewModel
    private let locationManager = CLLocationManager()
    private let dispatchQueue = DispatchQueue(label: String(describing: MapViewController.self))
    private var allAnnotations = [HotspotAnnotation]()
    private var currentAnnotations: Set<HotspotAnnotation> = []
    private var isInitiallyCentered = false
        
    init(mapViewModel: MapViewModel) {
        self.mapViewModel = mapViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        setupLocationManager()
        setupUI()
        loadHotspots()
    }
    
    @IBAction func navigationTapped() {
        centerOnUserLocation()
    }
    
    private func setupUI() {
        navigationButton.layer.cornerRadius = 10
        navigationButton.addShadow()
    }
    
    private func loadHotspots() {
        mapViewModel.getHotspotAnnotations { [weak self] hotspotAnnotatios in
            guard let self = self else { return }
            self.allAnnotations = hotspotAnnotatios
            self.updateAnnotations()
        }
    }
    
    deinit {
        mapView.delegate = nil
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is HotspotAnnotation {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation)
            annotationView.clusteringIdentifier = "HotspotsCluster"
            return annotationView
        } else if annotation is MKClusterAnnotation {
            let clusterAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier, for: annotation)
            return clusterAnnotationView
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        updateAnnotations()
    }
    
    private func setupMap() {
        mapView.register(HotspotAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(HotspotClusterAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    private func updateAnnotations() {
        dispatchQueue.async { [weak self] in
            guard let self = self else { return }
            let newAnnotations = self.allAnnotations.filter{self.mapView.visibleMapRect.contains(MKMapPoint($0.coordinate))}
            let oldAnnotations = Array(self.currentAnnotations.subtracting(newAnnotations))
            self.currentAnnotations = Set(newAnnotations)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.mapView.removeAnnotations(oldAnnotations)
                self.mapView.addAnnotations(newAnnotations)
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !isInitiallyCentered else { return }
        centerOnUserLocation()
        isInitiallyCentered = true
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        navigationButton.isHidden = !(status == .authorizedWhenInUse)
    }
    
    private func setupLocationManager() {
        guard CLLocationManager.locationServicesEnabled() else { return }
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func centerOnUserLocation() {
        guard let location = locationManager.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        mapView.setRegion(region, animated: true)
    }
}
