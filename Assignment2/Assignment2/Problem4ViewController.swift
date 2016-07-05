//
//  Problem4ViewController.swift
//  Assignment2
//
//  Created by tinaun on 7/2/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

class Problem4ViewController: UIViewController {

    
    @IBOutlet weak var OutputText: UITextView!
    @IBOutlet weak var RunButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Problem 4"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RunButtonPressed(sender: AnyObject) {
        OutputText.text = "Button 4 Pressed.\n"
        print("Button 4 Pressed.")
        
        //create 10 x 10 array
        var initialStep = World(size: 10)
        
        //fill with values
        initialStep.randomFill(percentTrue: 33)
        
        //count values
        OutputText.text = OutputText.text + "before count: \(initialStep.count).\n"
        
        print("previous world:")
        print(initialStep)
        
        //get next generation
        let nextStep = World.step2(prev: initialStep)
        
        print("current world:")
        print(nextStep)
        
        //count new values
        OutputText.text = OutputText.text + "after count: \(nextStep.count)."
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
