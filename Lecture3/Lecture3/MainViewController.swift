//
//  ViewController.swift
//  Lecture3
//
//  Created by tinaun on 6/29/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var timesPressed = 0;
    
    @IBOutlet weak var MainButton: UIButton!
    @IBOutlet weak var TestTextView: UITextView!
    @IBOutlet weak var ResetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func MainButtonPress(sender: AnyObject) {
        print("button pressed!")
        timesPressed += 1;
        
        TestTextView.text = "pressed \(timesPressed) times."
    }
    @IBAction func ResetPress(sender: AnyObject) {
        timesPressed = 0
        
        TestTextView.text = "never pressed!"
    }
}

