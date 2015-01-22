//
//  BarDetailsViewController.swift
//  Happy_Owl
//
//  Created by Agustiadi on 21/1/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit
import MapKit

class BarDetailsViewController: UIViewController, MKMapViewDelegate {
    
    var barID = NSObject()

    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var barAddress: UILabel!
    @IBOutlet weak var barRegion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Bar Information
        
        let barName2 = self.barID.valueForKey("name") as? String
        let address = self.barID.valueForKey("address_1") as? String
        let region = self.barID.valueForKey("region") as? String
        let geoPoint: PFGeoPoint = self.barID.valueForKey("LatLong") as PFGeoPoint
        
        self.barName.text = barName2
        self.barAddress.text = address
        self.barRegion.text = region
        
        //println(barID)
        
        // Map Information
        
        let map = MKMapView(frame: CGRectMake(0, 220, self.view.frame.width, 250))
        map.delegate = self
        
        let point = MKPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
        point.title = barName2
        point.subtitle = address
        map.addAnnotation(point)
        map.selectAnnotation(point, animated: false)
        
        var zone = map.region as MKCoordinateRegion
        zone.center = point.coordinate
        zone.span.latitudeDelta = 0.01
        zone.span.longitudeDelta = 0.01
        map.setRegion(zone, animated: false)
        
        self.view.addSubview(map)
    
        
    }
    
    // Add "Direction" button on the Map Annotation
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let reuseID = "pin"
        var anno = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID) as? MKPinAnnotationView
        
        if anno == nil {
            anno = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            anno!.canShowCallout = true
            anno!.animatesDrop = true
            
            // "Direction" button
            let btn = UIButton(frame: CGRectMake(0, 0, 100.0, anno!.bounds.height))
            btn.setTitle("Directions", forState: UIControlState.Normal)
            btn.backgroundColor = UIColor.blackColor()
            btn.addTarget(self, action: "buttonTouched", forControlEvents: UIControlEvents.TouchUpInside)
            
            anno!.rightCalloutAccessoryView = btn
        }
        return anno
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Opening the Google Map when the "Directions" button is pressed
    
    func buttonTouched(){
       
        let googleSGMapString = "http://map.google.com.sg/?daddr="
        let addressString = self.barID.valueForKey("address_1") as? String
       
        let urlString = addressString!.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
       
        let mapURLString = googleSGMapString + urlString
        let mapURL = NSURL(string: mapURLString)
        
        UIApplication.sharedApplication().openURL(mapURL!)
        
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
