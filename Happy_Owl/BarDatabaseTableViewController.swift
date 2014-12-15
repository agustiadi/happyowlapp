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
    
    var barID = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var query = PFQuery(className:"Establishment")
        //query.whereKey("playerName", equalTo:"Sean Plott")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            self.barName.removeAll(keepCapacity: true)
            
            if error == nil {
                for object in objects {
                    
                    self.barName.append(object["name"] as String)
                    self.barID.append(object as PFObject)

                }
                
                self.tableView.reloadData()
                
            }else {
                
                println(error)
            }
        }
        
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
        return 350
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: BarCardTableViewCell = tableView.dequeueReusableCellWithIdentifier("card", forIndexPath: indexPath) as BarCardTableViewCell
        
        cell.nameOfBar.text = barName[indexPath.row]
        
        var ohQuery = PFQuery(className: "OpeningHours")
        ohQuery.whereKey("parent", equalTo: barID[indexPath.row])
        ohQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            if error == nil {
                for object in objects {
                    
                    switch object["day"] as String {
                        
                        case "Monday" :
                            let startingTime = self.secToTimeConverter(object["fromHour"] as Int)
                            let endTime = self.secToTimeConverter(object["toHour"] as Int)
                            if startingTime.min == 0 && endTime.min == 0 {
                                
                                cell.monday.text = "\(startingTime.hour):00 to \(endTime.hour):00"
                            } else {
                                if startingTime.min == 0 {
                                    cell.monday.text = "\(startingTime.hour):00 to \(endTime.hour):\(endTime.min)"
                                } else if endTime.min == 0 {
                                    cell.monday.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):00"
                                } else {
                                    cell.monday.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):\(endTime.min)"
                                }
                            }
                        case "Tuesday":
                            let startingTime = self.secToTimeConverter(object["fromHour"] as Int)
                            let endTime = self.secToTimeConverter(object["toHour"] as Int)
                            if startingTime.min == 0 && endTime.min == 0 {
                                
                                cell.tuesday.text = "\(startingTime.hour):00 to \(endTime.hour):00"
                            } else {
                                if startingTime.min == 0 {
                                    cell.tuesday.text = "\(startingTime.hour):00 to \(endTime.hour):\(endTime.min)"
                                } else if endTime.min == 0 {
                                    cell.tuesday.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):00"
                                } else {
                                    cell.tuesday.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):\(endTime.min)"
                                }
                        }

                        case "Wednesday":
                            let startingTime = self.secToTimeConverter(object["fromHour"] as Int)
                            let endTime = self.secToTimeConverter(object["toHour"] as Int)
                            if startingTime.min == 0 && endTime.min == 0 {
                                
                                cell.wednesday.text = "\(startingTime.hour):00 to \(endTime.hour):00"
                            } else {
                                if startingTime.min == 0 {
                                    cell.wednesday.text = "\(startingTime.hour):00 to \(endTime.hour):\(endTime.min)"
                                } else if endTime.min == 0 {
                                    cell.wednesday.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):00"
                                } else {
                                    cell.wednesday.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):\(endTime.min)"
                                }
                        }

                        case "Thursday":
                            let startingTime = self.secToTimeConverter(object["fromHour"] as Int)
                            let endTime = self.secToTimeConverter(object["toHour"] as Int)
                            if startingTime.min == 0 && endTime.min == 0 {
                                
                                cell.thursday.text = "\(startingTime.hour):00 to \(endTime.hour):00"
                            } else {
                                if startingTime.min == 0 {
                                    cell.thursday.text = "\(startingTime.hour):00 to \(endTime.hour):\(endTime.min)"
                                } else if endTime.min == 0 {
                                    cell.thursday.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):00"
                                } else {
                                    cell.thursday.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):\(endTime.min)"
                                }
                        }

                        case "Friday":
                            let startingTime = self.secToTimeConverter(object["fromHour"] as Int)
                            let endTime = self.secToTimeConverter(object["toHour"] as Int)
                            if startingTime.min == 0 && endTime.min == 0 {
                                
                                cell.friday.text = "\(startingTime.hour):00 to \(endTime.hour):00"
                            } else {
                                if startingTime.min == 0 {
                                    cell.friday.text = "\(startingTime.hour):00 to \(endTime.hour):\(endTime.min)"
                                } else if endTime.min == 0 {
                                    cell.friday.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):00"
                                } else {
                                    cell.friday.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):\(endTime.min)"
                                }
                        }

                        case "Saturday":
                            let startingTime = self.secToTimeConverter(object["fromHour"] as Int)
                            let endTime = self.secToTimeConverter(object["toHour"] as Int)
                            if startingTime.min == 0 && endTime.min == 0 {
                                
                                cell.saturday.text = "\(startingTime.hour):00 to \(endTime.hour):00"
                            } else {
                                if startingTime.min == 0 {
                                    cell.saturday.text = "\(startingTime.hour):00 to \(endTime.hour):\(endTime.min)"
                                } else if endTime.min == 0 {
                                    cell.saturday.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):00"
                                } else {
                                    cell.saturday.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):\(endTime.min)"
                                }
                        }

                        case "Sunday":
                            
                            let startingTime = self.secToTimeConverter(object["fromHour"] as Int)
                            let endTime = self.secToTimeConverter(object["toHour"] as Int)
                            if startingTime.min == 0 && endTime.min == 0 {
                                
                                cell.sunday.text = "\(startingTime.hour):00 to \(endTime.hour):00"
                            } else {
                                if startingTime.min == 0 {
                                    cell.sunday.text = "\(startingTime.hour):00 to \(endTime.hour):\(endTime.min)"
                                } else if endTime.min == 0 {
                                    cell.sunday.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):00"
                                } else {
                                    cell.sunday.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):\(endTime.min)"
                                }
                        }

                        case "Public Holiday":
                            let startingTime = self.secToTimeConverter(object["fromHour"] as Int)
                            let endTime = self.secToTimeConverter(object["toHour"] as Int)
                            if startingTime.min == 0 && endTime.min == 0 {
                                
                                cell.pH.text = "\(startingTime.hour):00 to \(endTime.hour):00"
                            } else {
                                if startingTime.min == 0 {
                                    cell.pH.text = "\(startingTime.hour):00 to \(endTime.hour):\(endTime.min)"
                                } else if endTime.min == 0 {
                                    cell.pH.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):00"
                                } else {
                                    cell.pH.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):\(endTime.min)"
                                }
                        }

                        case "Eve of Public Holiday":
                            let startingTime = self.secToTimeConverter(object["fromHour"] as Int)
                            let endTime = self.secToTimeConverter(object["toHour"] as Int)
                            if startingTime.min == 0 && endTime.min == 0 {
                                
                                cell.evePH.text = "\(startingTime.hour):00 to \(endTime.hour):00"
                            } else {
                                if startingTime.min == 0 {
                                    cell.evePH.text = "\(startingTime.hour):00 to \(endTime.hour):\(endTime.min)"
                                } else if endTime.min == 0 {
                                    cell.evePH.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):00"
                                } else {
                                    cell.evePH.text = "\(startingTime.hour):\(startingTime.min) to \(endTime.hour):\(endTime.min)"
                                }
                        }
                        default:
                            println("There is an error in the database")
                        
                    }
                    
                    

                }
                
                
            } else {
                println(error)
            }
            
            
        }
        

        return cell
    }
    
    func secToTimeConverter(seconds:Int) -> (hour: Int, min: Int) {
        
        var rawTime = Float(seconds)
        
        var floatHour: Float = Float()
        var hour: Int = Int()
        var floatMin: Float = Float()
        var min: Int = Int()
        
        floatHour = (rawTime / 3600)
        hour = Int(floatHour)
        
        floatMin = ((rawTime / 3600) - Float(hour)) * 60
        min = Int(floatMin)
        
        return (hour, min)
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

}
