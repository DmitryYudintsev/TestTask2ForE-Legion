//
//  Model.swift
//  TestTask2ForE-Legion
//
//  Created by Дмитрий Юдинцев on 18.10.2020.
//

import Foundation
import MapKit
import UIKit


class People: NSObject, MKAnnotation {
    var name: String?
    var coordinate: CLLocationCoordinate2D
    var info: String

    init(name: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.name = name
        self.coordinate = coordinate
        self.info = info
    }
}



