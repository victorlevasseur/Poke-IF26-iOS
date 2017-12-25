//
//  MapViewController.swift
//  Poke-IF26
//
//  Created by user134638 on 12/12/17.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import GoogleMaps
import RxCocoa
import RxSwift
import UIKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var mapView: GMSMapView? = nil
    
    var userMarker: GMSMarker? = nil;
    
    var pokemonsMarkers: [(marker: GMSMarker, circle: GMSCircle)] = []
    
    override func loadView() {
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0))
        view = self.mapView
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() && CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        } else {
            let alertController = UIAlertController(title: "Erreur", message: "Veuillez autoriser l'application à accéder à votre position afin de capturer des pokémons puis redémarrez l'application.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a marker and a circle for each pokemon.
        // TODO: Move to viewWillAppear and clean the data in viewDidDisappear so that it reloaded when the tab changes
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let _ = PokemonsService.getInstance().fetchNotCapturedPokemons()
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { (pokemons) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                // Add the markers
                pokemons.forEach({ (pokemon) in
                    let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: pokemon.pokemon.latitude, longitude: pokemon.pokemon.longitude))
                    marker.title = pokemon.pokemonName
                    marker.icon = pokemon.pokemonBitmap
                    marker.map = self.mapView
                })
            }) { (err) in
                let alertController = UIAlertController(title: "Erreur", message: "Impossible de charger les pokémons !", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Retour", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
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
        self.mapView?.animate(to: GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 18.0, bearing: CLLocationDirection(exactly: 0)!, viewingAngle: 45.00))
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
