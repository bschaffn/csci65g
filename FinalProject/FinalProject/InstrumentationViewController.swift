//
//  FirstViewController.swift
//  FinalProject
//
//  Created by tinaun on 7/25/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    //MARK: Pattern Loading Outlets
    
    
    //MARK: Simulation Setting Outlets
    @IBOutlet weak var ruleEditor: RuleView!
    @IBOutlet weak var rulePicker: UIPickerView!
    
    @IBOutlet weak var colField: UITextField!
    @IBOutlet weak var colStepper: UIStepper!
    
    @IBOutlet weak var rowField: UITextField!
    @IBOutlet weak var rowStepper: UIStepper!
    
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var speedToggle: UISwitch!
    
    //MARK: Base Class Definitions
    var ruleNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ruleNames = LifeRule.namedRule.values.sort()
        ruleNames.append("Custom Rule")
        
        speedToggle.on = false
        
        rulePicker.delegate = self
        rulePicker.dataSource = self
        rulePicker.selectRow(ruleNames.indexOf("Life")!, inComponent: 0, animated: false)
        
        colField.delegate = self
        colField.text = "20"
        colField.placeholder = "cols" // this is the worst way to do dispatch, but im to tired to make a subclass of textField
        
        rowField.delegate = self
        rowField.text = "20"
        rowField.placeholder = "rows"
        
        let sel = #selector(InstrumentationViewController.watchForNotifications(_:))
        LifeGridNotification.addObserver(self, selector: sel)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func watchForNotifications(notification: NSNotification) {
        if let rule = notification.userInfo!["rule"] {
            let newRule = LifeRule(ruleString: rule as! String)!
            
            if ruleNames.contains(newRule.getName()) {
                let name = ruleNames.indexOf(newRule.getName())!
                rulePicker.selectRow(Int(name), inComponent: 0, animated: true)
            } else {
                rulePicker.selectRow(ruleNames.count - 1, inComponent: 0, animated: true)
            }
            
            //if the rule wasn't already modified by the ruleEditor, refresh it
            if newRule.description != ruleEditor.rule.description {
                ruleEditor.rule = newRule
                ruleEditor.setNeedsDisplay()
            }
        }
    }
    
    //MARK: Simulation Controls
    @IBAction func speedChanged(sender: AnyObject) {
        if speedToggle.on {
            let value = String(format: "%0.2f", speedSlider.value)
            speedLabel.text = "\(value) gens/sec"
            
            LifeGridNotification.speedChanged(Double(speedSlider.value))
        }
    }
    @IBAction func toggleAuto(sender: AnyObject) {
        if speedToggle.on {
            speedChanged(sender)
        } else {
            speedLabel.text = "n gens/sec"
            LifeGridNotification.speedChanged(0.0)
        }
    }
    
    
    @IBAction func rowStepped(sender: AnyObject) {
        rowField.text = String(Int(rowStepper.value))
        
        LifeGridNotification.resized(rows: Int(rowStepper.value))
    }
    
    @IBAction func colStepped(sender: AnyObject) {
        colField.text = String(Int(colStepper.value))
     
        LifeGridNotification.resized(cols: Int(colStepper.value))
    }
    
    //MARK: Text Field Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let value = Int(textField.text!) {
            switch textField.placeholder {
            case "rows"?:
                rowStepper.value = Double(value)
                rowStepped(self)
            case "cols"?:
                colStepper.value = Double(value)
                colStepped(self)
            default:
                ()
            }
        } else {
            switch textField.placeholder {
            case "rows"?:
                rowField.text = String(Int(rowStepper.value))
            case "cols"?:
                colField.text = String(Int(colStepper.value))
            default:
                ()
            }
        }
        
        return true
    }
    
    
    //MARK: Rule View Gesture Recoginzer
    @IBAction func ruleViewChanged(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            let point = sender.locationInView(ruleEditor)
            let change = ruleEditor.updateRuleWithPoint(point)
            
            let str = ruleEditor.rule.description
            LifeGridNotification.ruleChanged(str)
            
            ruleEditor.setNeedsDisplayInRect(change)
        }
    }
    
    //MARK: Picker Delegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ruleNames[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        for (k, v) in LifeRule.namedRule {
            if v == ruleNames[row] {
                LifeGridNotification.ruleChanged(k)
                break
            }
        }
        
    }
    
    //MARK: Picker Data Source
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ruleNames.count
    }
    


}

