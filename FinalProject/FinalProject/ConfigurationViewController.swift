//
//  ConfigurationViewController.swift
//  FinalProject
//
//  Created by tinaun on 8/3/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

class ConfigurationViewController: UITableViewController {

    private var names = ["loading..."]
    private var initDataURL = NSURL(string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json")!
    
    override func viewDidLoad() {
        super.viewDidLoad
        
        let fetcher = Fetcher()
        
        fetcher.requestJSON(initDataURL) { (json, message) in
            let op = NSBlockOperation {
                if let json = json as? NSArray {
                    print(json)
                    self.names = json.map { (obj) in
                        obj.title
                    }
                    
                    self.tableView.reloadData()
                } else {
                    var errorMessage: String
                    
                    if let m = message {
                        errorMessage = m
                    } else {
                        errorMessage = "Invalid JSON Data"
                    }
                    
                    
                    let alert = UIAlertController(title: "Invalid", message: errorMessage, preferredStyle: .Alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                        
                    }
                    
                    alert.addAction(defaultAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
            
            NSOperationQueue.mainQueue().addOperation(op)
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return names.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("Default")
            else {
                preconditionFailure("missing Default reuse identifier")
        }
        
        let row = indexPath.row
        guard let nameLabel = cell.textLabel else {
            preconditionFailure("invalid label!")
        }
        
        nameLabel.text = names[row]
        cell.tag = row
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
        guard let editingVC = segue.destinationViewController as? EditPatternViewController
            else {
                preconditionFailure("incorrect view controller")
        }
        
        editingVC.name = "new"
        editingVC.commit = {
            self.names.append($0)
            self.tableView.reloadData()
        }
    }
    

}
