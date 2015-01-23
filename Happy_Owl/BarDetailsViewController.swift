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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bar Basic Information
        let barName2 = self.barID.valueForKey("name") as? String
        let address = self.barID.valueForKey("address_1") as? String
        let region = self.barID.valueForKey("region") as? String
        let geoPoint: PFGeoPoint = self.barID.valueForKey("LatLong") as PFGeoPoint
        
        
        // Y-position of all the views on this BarDetailsViewController
        let navH = self.navigationController?.navigationBar.frame.height
        let imageY = navH! + 20
        let nameY = imageY + 180
        let happyHourY = nameY + 50
        let additionalInfoY = happyHourY + 100
        let infoY = additionalInfoY + 80
        let mapY = infoY + 150
        
        
        // Bar Image View
        let barImageView = UIImageView(frame: CGRectMake(0, imageY, self.view.frame.width, 180))
        //barImageView.image = UIImage(named: "testimage")
        //barImageView.clipsToBounds = true
        barImageView.backgroundColor = UIColor.redColor()
        
        // Bar Name Label View
        let nameLabel = UILabel(frame: CGRectMake(0, nameY, self.view.frame.width, 50))
        nameLabel.text = "   \(barName2!)"
        nameLabel.backgroundColor = UIColor.blueColor()
        nameLabel.textColor = UIColor.whiteColor()
        
        // Happy Hour Collection View
        let happyHourCollectionView = UIView(frame: CGRectMake(0, happyHourY, self.view.frame.width, 100))
        happyHourCollectionView.backgroundColor = UIColor.yellowColor()
        
        // Additional Info of Bar Collection View
        let additionalInfoCollectionView = UIView(frame: CGRectMake(0, additionalInfoY, self.view.frame.width, 80))
        additionalInfoCollectionView.backgroundColor = UIColor.greenColor()
        
        // Bar Basic Info View
        let basicInfoView = UIView(frame: CGRectMake(0, infoY, self.view.frame.width, 150))
        basicInfoView.backgroundColor = UIColor.blackColor()
        
        // Map View
        
        let map = MKMapView(frame: CGRectMake(0, mapY, self.view.frame.width, 250))
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
        
        // Setting up Scroll View
        let scrollView = UIScrollView(frame: CGRectMake(0, -imageY, self.view.frame.width, self.view.frame.height + imageY))
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: mapY + 250)
        scrollView.addSubview(barImageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(happyHourCollectionView)
        scrollView.addSubview(additionalInfoCollectionView)
        scrollView.addSubview(basicInfoView)
        scrollView.addSubview(map)
        
        self.view.addSubview(scrollView)
        
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
