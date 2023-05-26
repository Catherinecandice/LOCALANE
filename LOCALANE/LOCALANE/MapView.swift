//
//  MapView.swift
//  LOCALANE
//
//  Created by Catherine Candice on 26/05/23.
//

import MapKit
import SwiftUI

// Showing the map of the location memory lane
struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    func makeCoordinator() -> MapViewCoordinator {
      return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // Indonesia
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -3.104976, longitude: 119.854142), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        mapView.setRegion(region, animated: true)
        
        // (Source) Apple Academy
        let p0 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: -6.302230, longitude: 106.652264))

        // (Destination) Hyde Park
        let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: -6.109867, longitude: 106.739221))
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p0)
        request.destination = MKMapItem(placemark: p1)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
            mapView.addAnnotations([p0, p1])
//            mapView.showAnnotations(mapView.annotations, animated: false)
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
              route.polyline.boundingMapRect,
              edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
              animated: true)
            
        }
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
      func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
        renderer.lineWidth = 5
        return renderer
      }
    }
}

