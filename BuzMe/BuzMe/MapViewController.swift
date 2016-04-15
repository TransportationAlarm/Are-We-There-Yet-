//
//  MapViewController.swift
//  BuzMe
//
//  Created by Anita on 3/30/16.
//  Copyright © 2016 BuzMe-codepath. All rights reserved.
//

import UIKit
import SRKUtility
import GoogleMaps

class MapViewController: UIViewController, UISearchBarDelegate, LocateOnTheMap {
    
    @IBOutlet weak var setAlarmButton: UIButton!
    @IBOutlet weak var googleMapsContainer: UIView!
    @IBOutlet weak var directionsView: UIView!
    
    var googleMapsView: GMSMapView!
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()

    var placesClient: GMSPlacesClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placesClient = GMSPlacesClient()
        //getCurrentLocation()
        


    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        self.googleMapsView = GMSMapView(frame: self.googleMapsContainer.frame)
        self.view.addSubview(self.googleMapsView)
        
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
        
        googleMapsView.myLocationEnabled = true
        googleMapsView.settings.myLocationButton = true
        
        //getCurrentLocation()
        
        // draw route
        // let strHome = SRKUtility.addURLEncoding("Banana Republic, Grant Avenue, San Francisco, CA")
        // let strOffice = SRKUtility.addURLEncoding("Union Square, San Francisco, CA")
//        let strOrigin = "37.7905153,-122.4099926"
//        let strDestination = "37.7890994,-122.4100355"
//        let str = "https://maps.googleapis.com/maps/api/directions/json?origin=\(strOrigin)&destination=\(strDestination)&key=AIzaSyAROhx7BpyklgsThy6g-SpAtZxqnVgHX8I"
//        print(str)
//
//        SRKUtility.invokeRequestForJSON(NSMutableURLRequest(URL: NSURL(string: str)!)) { (obj:AnyObject?, error:NSString?) -> Void in
//            if let r = error {
//                print("Error occured \(r)")
//            } else if let objD = obj as? NSDictionary {
//                print("Response in dictionary form \(objD)")
//                self.parseAndDisplayDirection(objD)
//            } else if let objA = obj as? NSArray {
//                print("Response in array form \(objA)")
//            }
//        }
    }
    
    func parseAndDisplayDirection(objD:NSDictionary) {
        if let routes = objD.valueForKey("routes") as? NSArray {
            if let routesD = routes.objectAtIndex(0) as? NSDictionary {
                
                if let legs = routesD.valueForKey("legs") as? NSArray {
                    if let legs0 = legs.objectAtIndex(0) as? NSDictionary {
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            let endAddress = legs0.valueForKey("end_address") as! String
                            let startAddress = legs0.valueForKey("start_address") as! String
                            let startLoc = legs0.valueForKey("start_location") as! NSDictionary
                            let endLoc = legs0.valueForKey("end_location") as! NSDictionary
                            let startCoOd = CLLocationCoordinate2D(latitude: startLoc.valueForKey("lat") as! Double, longitude: startLoc.valueForKey("lng") as! Double)
                            let endCoOd = CLLocationCoordinate2D(latitude: endLoc.valueForKey("lat") as! Double, longitude: endLoc.valueForKey("lng") as! Double)
                            
                            let startMarker = GMSMarker(position: startCoOd)
                            let endMarker = GMSMarker(position: endCoOd)
                            startMarker.title = startAddress.componentsSeparatedByString(",")[0]
                            endMarker.title = endAddress.componentsSeparatedByString(",")[0]
                            startMarker.map = self.googleMapsView
                            endMarker.map = self.googleMapsView
                            let bounds = GMSCoordinateBounds(coordinate: startCoOd, coordinate: endCoOd)
                            self.googleMapsView?.animateWithCameraUpdate(GMSCameraUpdate.fitBounds(bounds))
                        })
                    }
                }
                
                if let polyLine = routesD.valueForKey("overview_polyline") as? NSDictionary {
                    if let points = polyLine.valueForKey("points") as? String {
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            let path = GMSPath(fromEncodedPath: points)
                            let line = GMSPolyline(path: path)
                            line.map = self.googleMapsView
                        })
                    }
                }
            }
        }
    }
    
    @IBAction func searchWithAddress(sender: AnyObject) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        self.presentViewController(searchController, animated: true, completion: nil)
        
    }
    
    func locateWithLongitude(long: Double, andLatitude lat: Double, andTitle title: String) {
        dispatch_async(dispatch_get_main_queue()) {
            
            self.googleMapsView.clear()
            
            let position = CLLocationCoordinate2DMake(lat, long)
            let marker = GMSMarker(position: position)
            
            let camera = GMSCameraPosition.cameraWithLatitude(lat, longitude: long, zoom: 18)
            self.googleMapsView.camera = camera
            
            marker.title = title
            marker.map = self.googleMapsView
            marker.draggable = true
            
            self.searchResultController.reloadInputViews()
        }
    }
        
    func searchBar(searchBar: UISearchBar,
                   textDidChange searchText: String){
        
        let placesClient = GMSPlacesClient()
        placesClient.autocompleteQuery(searchText, bounds: nil, filter: nil) { (results, error:NSError?) -> Void in
            self.resultsArray.removeAll()
            if results == nil {
                return
            }
            for result in results!{
                if let result = result as? GMSAutocompletePrediction{
                    self.resultsArray.append(result.attributedFullText.string)
                }
            }
            self.searchResultController.reloadDataWithArray(self.resultsArray)
        }
    }
    
    func getCurrentLocation() {
        placesClient?.currentPlaceWithCallback({
            (placeLikelihoodList: GMSPlaceLikelihoodList?, error: NSError?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
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
                        longitude: long, zoom: 16)
                    let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
                    
                    self.view = mapView

                    mapView.myLocationEnabled = true
                    
//                    let marker = GMSMarker()
//                    marker.position = CLLocationCoordinate2DMake(lat, long)
//                    marker.map = mapView
                    
                    mapView.settings.myLocationButton = true
                    mapView.settings.scrollGestures = true
                    mapView.settings.zoomGestures = true
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
