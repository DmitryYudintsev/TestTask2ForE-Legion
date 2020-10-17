//
//  ViewController.swift
//  TestTask2ForE-Legion
//
//  Created by Дмитрий Юдинцев on 18.10.2020.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myNameLabel: UILabel?
    @IBOutlet weak var myCoordinatesLabel: UILabel?
    @IBOutlet weak var table: UITableView?
    
    let locationManager = CLLocationManager()
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        myDest()
        setupUI()

    }
    // MARK: - Funcs
    
    //fetch my destination
    func myDest() {
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    //configure Labels
    func setupUI() {
        myNameLabel?.text = "Dmitry"
        myNameLabel?.textColor = .red
        myNameLabel?.textAlignment = .center
        myCoordinatesLabel?.textColor = .green
        myCoordinatesLabel?.textAlignment = .center
    }


}
// MARK: - Extention CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        myCoordinatesLabel?.text = "\(locValue.latitude.rounded(toPlaces: 5))" + " " + "\(locValue.longitude.rounded(toPlaces: 5))"
    }
}

