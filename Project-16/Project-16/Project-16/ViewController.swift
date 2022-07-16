//
//  ViewController.swift
//  Project-16
//
//  Created by Sagar Kadam on 16/07/22.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select Map Type", style: .plain, target: self, action: #selector(changeMapType))

        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand of years ago")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8675, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        /*
        mapView.addAnnotation(london)
        mapView.addAnnotation(oslo)
        mapView.addAnnotation(paris)
        mapView.addAnnotation(rome)
        mapView.addAnnotation(washington) */
        
        mapView.addAnnotations([london,oslo,paris,rome,washington])
    }
    
    @objc func changeMapType() {
        let ac = UIAlertController(title: "Choose Map Type", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: setMapType))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: setMapType))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: setMapType))
        ac.addAction(UIAlertAction(title: "Satellite Flyover", style: .default, handler: setMapType))
        ac.addAction(UIAlertAction(title: "Muted Standard", style: .default, handler: setMapType))
        
       present(ac,animated: true)
    }

    func setMapType(action: UIAlertAction) {
        var mapType : MKMapType
        guard let actionTitle = action.title else {return}
        
        switch actionTitle {
        case "Standard":
            mapType = .standard
        case "Satellite":
            mapType = .satellite
        case "Hybrid":
            mapType = .hybrid
        case "Satellite Flyover":
            mapType = .hybridFlyover
        case "Muted Standard":
            mapType = .mutedStandard
            
        default:
            mapType = .standard
        }
        
        mapView.mapType = mapType
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else {return nil}
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        
        if annotationView == nil {
            
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = UIColor.blue

            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        }else{
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else {return}
        
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
       // ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.addAction(UIAlertAction(title: "Show Details", style: .default, handler: { _ in
            // Navigate to the Wikipedia entry for the city.
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CityDetails") as? CityDetailsView {
                vc.cityTitle = placeName
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }))
        present(ac, animated: true)
    }
}

