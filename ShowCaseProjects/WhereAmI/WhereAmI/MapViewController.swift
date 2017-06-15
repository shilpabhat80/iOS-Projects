//
//  MapViewController.swift
//  WhereAmI
//
//  Created by Shilpa Bhat on 12/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit
import MapKit

enum MapType: Int {
    case standard = 0
    case hybrid
    case satellite
}

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var addressTextView: UITextView!
    
    var locationManager = CLLocationManager()
    var currentPosition:String = ""
    var currentAddress:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
        locationManager.startUpdatingLocation()
        
        updateCurrentLoaction()
        
    }
    
    func updateCurrentLoaction() {
        
        let currentLocation = locationManager.location!
        
        currentPosition = "latitude: \(currentLocation.coordinate.latitude) longitude: \(currentLocation.coordinate.longitude)"
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currentLocation, completionHandler: { (placemarks, error) -> Void in
            
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                
                self.currentAddress = ""
                if let placemark = placemarks?.first
                {
                    if let subThoroughfare = placemark.subThoroughfare,
                        let thoroughfare = placemark.thoroughfare {
                        self.currentAddress += "\(subThoroughfare) \(thoroughfare)\n"
                    }
                    
                    if let postalCode = placemark.postalCode,
                        let locality = placemark.locality {
                        self.currentAddress += "\(locality) \(postalCode)\n"
                    }
                    
                    if let administrativeArea = placemark.administrativeArea {                        self.currentAddress += "\(administrativeArea)\n"
                    }
                    
                    if let country = placemark.country {
                        self.currentAddress += "\(country)"
                    }
                    
                    
                    let region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 800, 800)
                    self.mapView.setRegion(self.mapView.regionThatFits(region), animated: true)
                    
                    // Add an annotation
                    let point = CurrentLocationAnnotation(coordinate: currentLocation.coordinate, address: self.currentAddress)
                    self.mapView.addAnnotations([point])
                    
                    self.locationLabel.text = self.currentPosition
                    self.addressTextView.text = self.currentAddress
                }
            }
            else {
                print("Problem with the data received from geocoder")
            }
            
            
        })
    }
    
    @IBAction func mapTypeChanged(_ sender: AnyObject) {
        let mapType = MapType(rawValue: mapTypeSegmentedControl.selectedSegmentIndex)
        switch (mapType!) {
        case .standard:
            mapView.mapType = MKMapType.standard
        case .hybrid:
            mapView.mapType = MKMapType.hybrid
        case .satellite:
            mapView.mapType = MKMapType.satellite
        }
    }
    
    @IBAction func showShareActionSheet(_ sender: AnyObject) {
        
        let shareAlertController = UIAlertController(title: "", message: "What do you want to do with your location info?", preferredStyle: .actionSheet)
        
        let emailAction = UIAlertAction(title: "Email", style: .default) { (action) in
            if let mailURL = URL(string:"message://") {
                UIApplication.shared.open(mailURL, options: ["subject":self.currentAddress], completionHandler: nil)
            }
        }
        shareAlertController.addAction(emailAction)

        let messageAction = UIAlertAction(title: "Text", style: .default) { (action) in
            if let mailURL = URL(string:"message://") {
                UIApplication.shared.open(mailURL, options: ["subject":self.currentAddress], completionHandler: nil)
            }
        }
        shareAlertController.addAction(messageAction)

        let tweetAction = UIAlertAction(title: "Twitter", style: .default) { (action) in
            if let mailURL = URL(string:"message://") {
                UIApplication.shared.open(mailURL, options: ["subject":self.currentAddress], completionHandler: nil)
            }
        }
        shareAlertController.addAction(tweetAction)
        
        let copyToPasteBoardAction = UIAlertAction(title: "Copy To Pasteboard", style: .default) { (action) in
           UIPasteboard.general.string = "\(self.currentAddress)"
        }
        shareAlertController.addAction(copyToPasteBoardAction)
        
        self.present(shareAlertController, animated: true, completion: nil)
    }
}

extension MapViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mapView.showsUserLocation = status == .authorizedAlways
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateCurrentLoaction()
    }
}

extension MapViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Lattitude/Longitude"
            cell.detailTextLabel?.text = self.currentPosition
        }
        else {
            cell.textLabel?.text = "Address"
            cell.detailTextLabel?.text = self.currentAddress
        }
        
        return cell
    }
}
