//
//  ViewController.swift
//  TestTask2ForE-Legion
//
//  Created by Дмитрий Юдинцев on 18.10.2020.
//

import UIKit
import MapKit


class ViewController: UIViewController {
    
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var myCoordinatesLabel: UILabel!
    @IBOutlet weak var table: UITableView!
    
    let locationManager = CLLocationManager()
    var myFriends = [People]()
    var myCoordinates = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //в реальном проекте этот метод нужно вынести во ViewModel
        loadingFriends { peoples in
            self.myFriends = peoples
            self.table.reloadData()
        }
        setupUI()
        myDest()
        setupTableView()
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
        myNameLabel.text = "Dmitry"
        myNameLabel.textColor = .red
        myNameLabel.textAlignment = .center
        myCoordinatesLabel?.textColor = .green
        myCoordinatesLabel?.textAlignment = .center
    }
    
    func setupTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }


}
// MARK: - Extention CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.myCoordinates = locValue
        myCoordinatesLabel?.text = "\(locValue.latitude.rounded(toPlaces: 5))" + " " + "\(locValue.longitude.rounded(toPlaces: 5))"
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.textLabel?.text = String(myFriends[indexPath.row].name!)
        cell.imageView?.image = UIImage(named: "placeholder.png")

        let loc1 = CLLocation(latitude: myCoordinates.latitude, longitude: myCoordinates.longitude)
        let loc2 = CLLocation(latitude: myFriends[indexPath.row].coordinate.latitude, longitude: myFriends[indexPath.row].coordinate.longitude)
        cell.detailTextLabel?.text = String((loc1.distance(from: loc2) / 1000 / 2).rounded(toPlaces: 2))

        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}

