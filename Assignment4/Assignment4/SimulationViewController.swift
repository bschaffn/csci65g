//
//  SecondViewController.swift
//  Assignment4
//
//  Created by tinaun on 7/15/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegate {
    var engine: EngineProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        engine = StandardEngine.singletonInstance
        engine.delegate = self
        
        let sel = #selector(SimulationViewController.watchForNotifications(_:))
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: sel, name: "GridStepped", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //dispatches notifications as they arrive
    func watchForNotifications(notification: NSNotification) {
        
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        
    }

}

