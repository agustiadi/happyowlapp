//
//  BarDatabaseTableViewController.swift
//  Happy Owl
//
//  Created by Agustiadi on 15/12/14.
//  Copyright (c) 2014 Agustiadi. All rights reserved.
//

import UIKit

class BarDatabaseTableViewController: UITableViewController {
    
    var barName = [String]()
    var barIDs = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var query = PFQuery(className:"Establishment")
        query.findObjectsInBackgroundWithBlock ({
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            // Reset Array
            self.barName.removeAll(keepCapacity: true)
            self.barIDs.removeAll(keepCapacity: true)
            
            if error == nil {
                for object in objects {
                    self.barName.append(object["name"] as String)
                    self.barIDs.append(object as PFObject)
                }
                self.tableView.reloadData()
                
            }else {
                println(error)
            }
            
        })
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return barName.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("card", forIndexPath: indexPath) as UITableViewCell
        
        let cellName = UILabel(frame: CGRectMake(0, (cell.frame.height/2)-25, cell.frame.width, 50))
        cellName.backgroundColor = UIColor.blackColor()
        cellName.alpha = 0.75
        cellName.text = barName[indexPath.row]
        cellName.textAlignment = NSTextAlignment.Center
        cellName.textColor = UIColor.whiteColor()
        
        let cellImage = UIImageView(frame: CGRectMake(0, 0, cell.frame.width, cell.frame.height-2))
    
        // Extracting Bar Cell Image from Parse
        var imageQuery = PFQuery(className: "PhotoGallery")
        imageQuery.whereKey("parent", equalTo: barIDs[indexPath.row])
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
                            cellImage.image = image
                        }else {
                            println(error)
                        }
                    }

                }
                
            }else {
                println(imageError)}
        })

        //cellImage.image = UIImage(named: "testimage")
        cellImage.clipsToBounds = true
        cellImage.contentMode = UIViewContentMode.ScaleAspectFill
    
        cell.backgroundColor = UIColor.whiteColor()
        
        cell.addSubview(cellImage)
        cell.addSubview(cellName)
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "details") {
            
            let vc: BarDetailsViewController = segue.destinationViewController as BarDetailsViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            vc.barID = barIDs[indexPath!.row]
            
            }
    
        }
    
}






    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

