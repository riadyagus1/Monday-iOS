//
//  MapsViewController.swift
//  Monday
//
//  Created by Agus Riady on 11/07/21.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapsViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    var coordinateNow:CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: Posisi Camera
        mapView.camera = GMSCameraPosition.camera(withLatitude: 1.1212744511055954, longitude: 104.04971853163705, zoom: 16.5)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        // Posisi Camera (End)
        
        let position = CLLocationCoordinate2D(latitude: 1.1212744511055954, longitude: 104.04971853163705)
        let marker = GMSMarker(position: position)
        marker.title = "McDonalds' Batam Center"
        marker.map = mapView
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    //MARK: Get Current Coordinate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.coordinateNow = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
    }
    // Get Current Coordinate (End)
    
    //MARK: Back Button
    @IBAction func backBtn(_ sender: UIButton) {
        if let navController = self.navigationController {
          navController.popViewController(animated: true)
        }
        self.dismiss(animated: true, completion: nil)
    }
    // Back Button (End)

}
