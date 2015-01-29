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
        let region = self.barID.valueForKey("region") as? String
        let phone = self.barID.valueForKey("phone") as? Int
        let geoPoint: PFGeoPoint = self.barID.valueForKey("LatLong") as PFGeoPoint
        
        let address1 = self.barID.valueForKey("address_1") as? String
        let address2 = self.barID.valueForKey("address_2") as? String
        var address: String
        
        if address2 == nil || address2 == "" {
            address = address1!
        } else {
            address = "\(address1!), \(address2!)"
        }
        
        
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
        self.getBarCellImage(barID as PFObject, imageView: barImageView)
        barImageView.clipsToBounds = true
        barImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        // Bar Name Label View
        let nameLabel = UILabel(frame: CGRectMake(0, nameY, self.view.frame.width, 50))
        nameLabel.text = "   \(barName2!)"
        nameLabel.backgroundColor = UIColor.whiteColor()
        nameLabel.textColor = UIColor(red: (40/255.0), green: (100/255.0), blue: (109/255.0), alpha: 1.0)
        
        // Happy Hour Deals Collection View
        self.getHappyHourDealTimes(barID as PFObject)
        let happyHourCollectionView = UIView(frame: CGRectMake(0, happyHourY, self.view.frame.width, 100))
        happyHourCollectionView.backgroundColor = UIColor(red: (40/255.0), green: (100/255.0), blue: (109/255.0), alpha: 1.0)
            // Need to add logic for additional happy hours
        
        // Additional Info of Bar Collection View
        let additionalInfoCollectionView = UIView(frame: CGRectMake(0, additionalInfoY, self.view.frame.width, 80))
        additionalInfoCollectionView.backgroundColor = UIColor.whiteColor()
        
        // Bar Basic Info View
        let basicInfoView = UIView(frame: CGRectMake(0, infoY, self.view.frame.width, 150))
        basicInfoView.backgroundColor = UIColor(red: (40/255.0), green: (100/255.0), blue: (109/255.0), alpha: 1.0)
        
        let addressLabel = UILabel(frame: CGRectMake(20, 15, self.view.frame.width, 30))
        addressLabel.text = "Address: \(address)"
        addressLabel.textColor = UIColor.whiteColor()
        
        let regionLabel = UILabel(frame: CGRectMake(20, 55, self.view.frame.width, 30))
        regionLabel.text = "Region: \(region!), Singapore"
        regionLabel.textColor = UIColor.whiteColor()
        
        let phoneLabel = UILabel(frame: CGRectMake(20, 100, self.view.frame.width, 30))
        phoneLabel.text = "Phone: +65 \(String(phone!))"
        phoneLabel.textColor = UIColor.whiteColor()
        
        
        basicInfoView.addSubview(addressLabel)
        basicInfoView.addSubview(regionLabel)
        basicInfoView.addSubview(phoneLabel)
    
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
    
    func getBarCellImage(bar: PFObject, imageView: UIImageView){
        
        // Extracting Bar Cell Image from Parse
        var imageQuery = PFQuery(className: "PhotoGallery")
        imageQuery.whereKey("parent", equalTo: bar)
        imageQuery.findObjectsInBackgroundWithBlock ({
            (imageObjects: [AnyObject]!, imageError: NSError!) -> Void in
            
            if imageError == nil {
                for imageObject in imageObjects {
                    
                    // Extracting UIImage from PFFile
                    let imageFile = imageObject["imageFile"] as PFFile
                    imageFile.getDataInBackgroundWithBlock{
                        (imageData: NSData!, error: NSError!) -> Void in
                        
                        if error == nil {
                            let image = UIImage(data: imageData)
                            imageView.image = image
                        }else {
                            println(error)
                        }
                    }
                    
                }
                
            }else {
                println(imageError)}
        })
        
    }
    
    func getHappyHourDealTimes(bar: PFObject){
        
        // Extracting Happy Hour Deal Times for a particular bar from Parse
        var happyHourDealQuery = PFQuery(className: "HappyHourTime")
        happyHourDealQuery.whereKey("parent", equalTo: bar)
        happyHourDealQuery.findObjectsInBackgroundWithBlock({
            (dealTimesObjects: [AnyObject]!, dealTimesError: NSError!) -> Void in
            
            if dealTimesError == nil {
                
                println(dealTimesObjects)
                
            }else {
                println(dealTimesError)
            }
            
        })

        
    }
    
    func getHappyHourDealTimePeriod(start: String, end: String){
        
        
    }

    func getBarHappyHourDeal(happyHourTime: PFObject) {
        
        // Extracting Happy Hours for a particular bar from Parse
        var happyHourDealQuery = PFQuery(className: "HappyHourDeal")
        happyHourDealQuery.whereKey("parent", equalTo: happyHourTime)
        happyHourDealQuery.findObjectsInBackgroundWithBlock({
            (dealObjects: [AnyObject]!, dealError: NSError!) -> Void in
            
            if dealError == nil {
                
                println(dealObjects)
                
            }else {
                println(dealError)
            }
            
        })
        
        
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
