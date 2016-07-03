//
//  Problem2ViewController.swift
//  Assignment2
//
//  Created by tinaun on 7/2/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

class Problem2ViewController: UIViewController {
    
    @IBOutlet weak var OutputText: UITextView!
    
    @IBOutlet weak var RunButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Problem 2";
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RunButtonPressed(sender: AnyObject) {
        OutputText.text = "Button 2 Pressed."
        print("Button 2 Pressed")
    }
    
}