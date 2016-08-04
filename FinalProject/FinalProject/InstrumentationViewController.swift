//
//  FirstViewController.swift
//  FinalProject
//
//  Created by tinaun on 7/25/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var ruleEditor: RuleView!
    @IBOutlet weak var rulePicker: UIPickerView!
    
    
    var ruleNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ruleNames = LifeRule.namedRule.values.sort()
        ruleNames.append("Custom Rule")
        
        rulePicker.delegate = self
        rulePicker.dataSource = self
        rulePicker.selectRow(3, inComponent: 0, animated: false)
        
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

