//
//  MapView.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 21/07/21.
//

import UIKit
import MapKit
import GenericUtilities

class MapView: UIView {
    
    let mapView = MKMapView()
    
    var location: CLLocationProtocol! {
        didSet{
            setupCurrentLocation()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCurrentLocation() {
        guard let location = location else {return}
        mapView.setRegion(.init(center: location.coordinate,
                                latitudinalMeters: 1000,
                                longitudinalMeters: 1000), animated: true)
        mapView.showsUserLocation = true
    }
    
    func setupView() {
        self.addSubview(mapView)
        mapView.fillSuperview(padding: .init(top: 8,
                                             left: 8,
                                             bottom: 8,
                                             right: 8))
        
        mapView.delegate = self
        mapView.register(ArtworkMarkerView.self,
                         forAnnotationViewWithReuseIdentifier: ArtworkMarkerView.identifier)
    }
    
    func addAnnotation(with annotations: [MKAnnotation]) {
        mapView.addAnnotations(annotations)
    }
    
}

extension MapView: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Annotation else {return nil}
        
        
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: ArtworkMarkerView.identifier, for: annotation) as? ArtworkMarkerView else {
            return nil
        }
        
        return annotationView
    }
    
    func addOverlay(with locations: [CLLocationProtocol]) {
        
        mapView.removeOverlays(mapView.overlays)
        let coordinates = locations.map({$0.coordinate})
        
        let overlay = MKPolygon(coordinates: coordinates,
                                count: coordinates.count)
        mapView.addOverlay(overlay)
        guard let lastCoordinate = coordinates.last else {return}
        let region = MKCoordinateRegion(center: lastCoordinate,
                                        latitudinalMeters: 300,
                                        longitudinalMeters: 300)
        mapView.setRegion(region, animated: true)
    }
}


