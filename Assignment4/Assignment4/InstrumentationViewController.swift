//
//  FirstViewController.swift
//  Assignment4
//
//  Created by tinaun on 7/15/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {
    
    //speed controls
    
    @IBOutlet weak var simSpeed: UISlider!
    @IBOutlet weak var enableSwitch: UISwitch!
    
    @IBAction func simEnabled(sender: UISwitch) {
        if !(enableSwitch.on) {
            let center = NSNotificationCenter.defaultCenter()
            let n = NSNotification(name: "GridChanged",
                                   object: nil,
                                   userInfo: ["speed": 0])
            center.postNotification(n)
        } else {
            let center = NSNotificationCenter.defaultCenter()
            let n = NSNotification(name: "GridChanged",
                                   object: nil,
                                   userInfo: ["speed": simSpeed.value])
            center.postNotification(n)
        }
    }
    
    @IBAction func speedChanged(sender: UISlider) {
        if enableSwitch.on {
            let center = NSNotificationCenter.defaultCenter()
            let n = NSNotification(name: "GridChanged",
                                   object: nil,
                                   userInfo: ["speed": sender.value])
            center.postNotification(n)
        }
    }
    
    //size controls
    var rows: Int = 10 {
        didSet {
            rowsText.text = String(rows)
            rowsStep.value = Double(rows)
            
            print("new row value: \(rows)")
            
            StandardEngine.singletonInstance.rows = rows
        }
    }
    var cols: Int = 10 {
        didSet {
            colsText.text = String(cols)
            colsStep.value = Double(cols)
            
            print("new col value: \(cols)")
            
            StandardEngine.singletonInstance.cols = cols
        }
    }
    
    @IBOutlet weak var rowsText: UITextField!
    @IBOutlet weak var colsText: UITextField!
    
    @IBOutlet weak var rowsStep: UIStepper!
    @IBOutlet weak var colsStep: UIStepper!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rowsText.text = String(rows)
        colsText.text = String(cols)
        
        rowsStep.value = Double(rows)
        colsStep.value = Double(cols)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func rowsValueStepped(sender: UIStepper) {
        rows = Int(sender.value)
    }
    @IBAction func rowsValueChanged(sender: UITextField) {
        if let number = Int(sender.text!) {
            rows = number
        }
    }
    
    
    
    @IBAction func colsValueStepped(sender: UIStepper) {
        cols = Int(sender.value)
    }
    @IBAction func colsValueChanged(sender: UITextField) {
        if let number = Int(sender.text!) {
            cols = number
        }
    }

}

