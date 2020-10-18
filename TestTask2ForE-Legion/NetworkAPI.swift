//
//  NetworkAPI.swift
//  TestTask2ForE-Legion
//
//  Created by Дмитрий Юдинцев on 18.10.2020.
//

import Foundation
import MapKit
import UIKit

// Заглушка для сетевого запроса списка друзей
func loadingFriends(completion : @escaping ([People]) -> Void) {
    completion(randomizeDest())
}

// Генерация списка друзей
func randomizeDest() -> [People] {
    
    let myFriends = [People(name: "Dima",
                     coordinate: CLLocationCoordinate2D(latitude: 49.810352, longitude: 86.590763),
                     info: "friend"),
              People(name: "Sasha",
                     coordinate: CLLocationCoordinate2D(latitude: 49.85, longitude: 87.66667),
                     info: "friend"),
              People(name: "Lena",
                     coordinate: CLLocationCoordinate2D(latitude: 50.083531, longitude: 87.778774),
                     info: "friend")]

    for i in myFriends {
        i.coordinate.latitude = Double.random(in: 20...50)
        i.coordinate.longitude = Double.random(in: 20...50)
    }
    return myFriends
}
