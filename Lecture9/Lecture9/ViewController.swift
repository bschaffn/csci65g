//
//  ViewController.swift
//  Lecture9
//
//  Created by tinaun on 7/20/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    private var names = ["Karkat", "Kanaya", "Vriska"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
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
    
    
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        guard let editingVC = segue.destinationViewController as? EditViewController
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

