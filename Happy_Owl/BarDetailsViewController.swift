//
//  BarDetailsViewController.swift
//  Happy_Owl
//
//  Created by Agustiadi on 21/1/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class BarDetailsViewController: UIViewController {
    
    var barID = NSObject()

    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var barAddress: UILabel!
    @IBOutlet weak var barRegion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let barName2 = self.barID.valueForKey("name") as? String
        let address = self.barID.valueForKey("address_1") as? String
        let region = self.barID.valueForKey("region") as? String
        let geoPoint: PFGeoPoint = self.barID.valueForKey("LatLong") as PFGeoPoint
       
        println(barID)
        
        self.barName.text = barName2
        self.barAddress.text = address
        self.barRegion.text = region
        
        println(geoPoint)
        
        
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
