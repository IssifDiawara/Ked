//
//  MapView.swift
//  Ked
//
//  Created by Issif DIAWARA on 03/04/2023.
//

import SwiftUI
import Combine
import MapKit

struct MapView: UIViewRepresentable {

    @Binding var centerCoordinate: CLLocationCoordinate2D?
    @Binding var annotations: [MKPointAnnotation]?
    @Binding var selectedAnnotation: MKPointAnnotation?
    @Binding var shouldCenterAroundMe: Bool

    var defaultCoordinate : MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 48.856_5, longitude: 2.348_9),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView(frame: .zero)
        map.delegate = context.coordinator

        // Default coordinates
        map.region = defaultCoordinate

        map.showsUserLocation = true
        map.isUserInteractionEnabled = true

        annotations.map(map.addAnnotations)
        map.showAnnotations(annotations ?? [], animated: false)

        return map
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        if selectedAnnotation == nil {
            uiView.selectedAnnotations.forEach { uiView.deselectAnnotation($0, animated: false)}
        }

        if shouldCenterAroundMe {
            shouldCenterAroundMe.toggle()
            uiView.setCenter(defaultCoordinate.center, animated: true)
        } else {
            let currentAnnotations = uiView.annotations.compactMap { $0 as? MKPointAnnotation }
            uiView.removeAnnotations(currentAnnotations)
            annotations.map(uiView.addAnnotations)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

}

extension MapView {

    class Coordinator: NSObject, MKMapViewDelegate {

        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            DispatchQueue.main.async {
                self.parent.centerCoordinate = mapView.centerCoordinate
            }
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Tree")
            annotationView.image = UIImage(systemName: "tree.circle.fill")
            return annotationView
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            UIView.animate(withDuration: 0.15, animations: {
                view.frame.size = CGSize(width: view.frame.size.width * 1.5, height: view.frame.size.height * 1.5)
            }, completion: { finished in
                if finished {
                    self.parent.selectedAnnotation = view.annotation as? MKPointAnnotation
                    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    if let coordinate = view.annotation?.coordinate {
                        let region = MKCoordinateRegion(center: coordinate, span: span)
                        mapView.setRegion(region, animated: true)
                    }
                }
            })
        }

        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            view.frame.size = CGSize(width: view.frame.size.width * 2 / 3 , height: view.frame.size.height * 2 / 3)
        }
    }

}
