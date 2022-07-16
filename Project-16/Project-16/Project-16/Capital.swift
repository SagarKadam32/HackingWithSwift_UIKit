//
//  Capital.swift
//  Project-16
//
//  Created by Sagar Kadam on 16/07/22.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
