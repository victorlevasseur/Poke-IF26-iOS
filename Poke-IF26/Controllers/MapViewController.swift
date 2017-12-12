//
//  MapViewController.swift
//  Poke-IF26
//
//  Created by user134638 on 12/12/17.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import GoogleMaps
import UIKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var mapView: GMSMapView? = nil
    
    var userMarker: GMSMarker? = nil;
    
    override func loadView() {
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0))
        view = self.mapView
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue: CLLocationCoordinate2D = manager.location!.coordinate
        
        if self.userMarker != nil {
            self.userMarker?.map = nil
        }
        
        self.userMarker = GMSMarker()
        self.userMarker?.position = locValue
        self.userMarker?.title = "Votre position"
        self.userMarker?.map = self.mapView
        self.mapView?.animate(to: GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 16.0))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
