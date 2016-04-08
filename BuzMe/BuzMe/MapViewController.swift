//
//  MapViewController.swift
//  BuzMe
//
//  Created by Anita on 3/30/16.
//  Copyright © 2016 BuzMe-codepath. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    var placesClient: GMSPlacesClient?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placesClient = GMSPlacesClient()
        
        placesClient?.currentPlaceWithCallback({
            (placeLikelihoodList: GMSPlaceLikelihoodList?, error: NSError?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            self.nameLabel.text = "No current place"
            self.addressLabel.text = ""
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
//                    print(place.name)
//                    print(place.formattedAddress)
//                    self.nameLabel.text = place.name
//                    print(place.coordinate)
//                    self.addressLabel.text = place.formattedAddress!.componentsSeparatedByString(", ")
//                        .joinWithSeparator("\n")
                    let lat = place.coordinate.latitude
                    let long = place.coordinate.longitude
                    
                    let camera = GMSCameraPosition.cameraWithLatitude(lat,
                        longitude: long, zoom: 6)
                    let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
                    mapView.myLocationEnabled = true
                    self.view = mapView
                    
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2DMake(lat, long)
//                    marker.title = "Sydney"
//                    marker.snippet = "Australia"
                    marker.map = mapView
                }
            }
        })

        
        
    }
    
    // Add a UIButton in Interface Builder to call this function
    @IBAction func getCurrentPlace(sender: UIButton) {
        
        
            }
    
    // get current location
    @IBAction func onCurrLocationBtn(sender: AnyObject) {
        
        placesClient!.currentPlaceWithCallback({ (placeLikelihoods, error) -> Void in
            guard error == nil else {
                print("Current Place error: \(error!.localizedDescription)")
                return
            }
            
            print("Test")
            
            if let placeLikelihoods = placeLikelihoods {
                for likelihood in placeLikelihoods.likelihoods {
                    let place = likelihood.place
//                    print("Current Place name \(place.name) at likelihood \(likelihood.likelihood)")
//                    print("Current Place address \(place.formattedAddress)")
//                    print("Current Place attributions \(place.attributions)")
//                    print("Current PlaceID \(place.placeID)")
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
