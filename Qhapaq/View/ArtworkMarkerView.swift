//
//  ArtworkMarkerView.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 24/07/21.
//

import MapKit

class ArtworkMarkerView: MKMarkerAnnotationView{
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        canShowCallout = true
        calloutOffset = .init(x: -5, y: 5)
        rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        markerTintColor = .purple
//        glyphText = ""
        glyphImage = UIImage(systemName: "heart.fill")
    }
}

