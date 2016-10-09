//
//  NavigationTableViewController.swift
//  Epinephrine
//
//  Created by Cole on 10/8/16.
//  Copyright © 2016 MHacks. All rights reserved.
//

import UIKit

class ScansTableViewController: UITableViewController {
    
    var scans = [Scan]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scans.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> ScanTableViewCell {
        let cellIdentifier = "scanIdentifier"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ScanTableViewCell

        // Configure the cell...
        let scan = scans[indexPath.row]
        cell.idNumberLabel.text = scan.idNumber

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "Show" {
            let scanDetailViewController = segue.destinationViewController as! BarcodeReader
            
            // Get the cell that generated this segue.
            if let selectedScanCell = sender as? ScanTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedScanCell)!
                let selectedScan = scans[indexPath.row]
                scanDetailViewController.scan = selectedScan
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new scan.")
        }
    }
    
    @IBAction func unwindToScanList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? BarcodeReader, scan = sourceViewController.scan {//where the magic happens
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                scans[selectedIndexPath.row] = scan
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new scan.
                let newIndexPath = NSIndexPath(forRow: scans.count, inSection: 0)
                scans.append(scan)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the meals.
            saveScans()
        }
    }
    
    // MARK: NSCoding
    
    func saveScans() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(scans, toFile: Scan.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save scans...")
        }
    }
    
    func loadScans() -> [Scan]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Scan.ArchiveURL.path!) as? [Scan]
    }

 

}
