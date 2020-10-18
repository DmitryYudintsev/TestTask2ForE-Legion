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
    
    var isSelected: Bool = false
    var selectedCellIndex = 0
    var timer: Timer?  //создаем таймер
    let locationManager = CLLocationManager()
    var myFriends = [People]()
    var myCoordinates = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createTimer() //внутри таймера получаем данные
        setupUI()
        myDest()
        setupTableView()
    }
    
    // MARK: - Funcs
    func createTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 3,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
    
    @objc func updateTimer() {
        //в реальном проекте loadingFriends метод нужно вынести во ViewModel
        loadingFriends { peoples in
            self.myFriends = peoples
        }
        self.table.reloadData()
    }
    
    //инит для получения моих координат
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
        table.register(MyTableViewCell.nib(), forCellReuseIdentifier: MyTableViewCell.identifire)
    }
}

// MARK: - Extention CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.myCoordinates = locValue
        myCoordinatesLabel?.text = "\(locValue.latitude.rounded(toPlaces: 5))" + "   " + "\(locValue.longitude.rounded(toPlaces: 5))"
    }
}

// MARK: - Extention UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = table.dequeueReusableCell(withIdentifier: MyTableViewCell.identifire, for: indexPath) as! MyTableViewCell

        let myLoc = CLLocation(latitude: myCoordinates.latitude,
                               longitude: myCoordinates.longitude)
        let friendLoc = CLLocation(latitude: myFriends[indexPath.row].coordinate.latitude,
                                   longitude: myFriends[indexPath.row].coordinate.longitude)
        
        if isSelected {
            let currentLoc = CLLocation(latitude: myFriends[selectedCellIndex].coordinate.latitude,
                                        longitude: myFriends[selectedCellIndex].coordinate.longitude)
            cell.setup(name: String(myFriends[indexPath.row].name!),
                       distanse: String((currentLoc.distance(from: friendLoc) / 1000 / 2).rounded(toPlaces: 2)) + " км",
                       image: String(myFriends[indexPath.row].info))
        } else {
            cell.setup(name: String(myFriends[indexPath.row].name!),
                       distanse: String((myLoc.distance(from: friendLoc) / 1000 / 2).rounded(toPlaces: 2)) + " км",
                       image: String(myFriends[indexPath.row].info))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !isSelected {
            let cell = table.cellForRow(at: indexPath)
            selectedCellIndex = indexPath.row
            isSelected = true
            cell?.layer.borderWidth = 1.0
            cell?.layer.borderColor = UIColor.red.cgColor
            table.reloadData()
        } else
        if isSelected && (selectedCellIndex == indexPath.row) {
            let cell = table.cellForRow(at: indexPath)
            selectedCellIndex = indexPath.row
            isSelected = false
            cell?.layer.borderWidth = 1.0
            cell?.layer.borderColor = UIColor.clear.cgColor
            table.reloadData()
        }
    }
}

// MARK: - Extention UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

