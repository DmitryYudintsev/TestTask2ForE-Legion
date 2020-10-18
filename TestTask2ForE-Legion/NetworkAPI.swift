//
//  NetworkAPI.swift
//  TestTask2ForE-Legion
//
//  Created by Дмитрий Юдинцев on 18.10.2020.
//

import Foundation
import MapKit
import UIKit


func loadingFriends(completion : @escaping ([People]) -> Void) {
    let myFriends = [People(name: "Dima",
                     coordinate: CLLocationCoordinate2D(latitude: 49.810352, longitude: 86.590763),
                     info: "friend"),
              People(name: "Sasha",
                     coordinate: CLLocationCoordinate2D(latitude: 49.85, longitude: 87.66667),
                     info: "friend"),
              People(name: "Lena",
                     coordinate: CLLocationCoordinate2D(latitude: 50.083531, longitude: 87.778774),
                     info: "friend")]
    completion(myFriends)
}
