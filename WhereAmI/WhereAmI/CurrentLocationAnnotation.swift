//
//  CurrentLocationAnnotation.swift
//  WhereAmI
//
//  Created by Shilpa Bhat on 13/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit
import MapKit

class CurrentLocationAnnotation: NSObject, MKAnnotation {
    
    var coordinate1: CLLocationCoordinate2D
    var address: String
    
    init(coordinate: CLLocationCoordinate2D, address: String) {
        self.coordinate1 = coordinate
        self.address = address
    }
    
    var coordinate: CLLocationCoordinate2D {
        get { return self.coordinate1 }
    }
    
    var title: String? {
        get { return self.address }
    }
}
