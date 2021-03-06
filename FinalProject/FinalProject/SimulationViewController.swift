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
    
    @IBOutlet weak var lifeGrid: GridView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var lastUsedRLE: NSURL?
    var heldState: CellState = .Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.setNavigationBarHidden(true, animated: false)
        
        engine = StandardEngine.singletonInstance
        engine.delegate = self
        
        engine.rows = 20
        engine.cols = 20
        
        let sel = #selector(SimulationViewController.watchForNotifications(_:))
        LifeGridNotification.addObserver(self, selector: sel)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //dispatches notifications as they arrive
    func watchForNotifications(notification: NSNotification) {
        print("notification recieved \(notification)")
        
        if let speed = notification.userInfo!["speed"] {
            engine.refreshRate = speed as! Double
        }
        
        if let rule = notification.userInfo!["rule"] {
            engine.rule = LifeRule(ruleString: rule as! String)!
        }
        
        if let grid = notification.userInfo!["grid"] {
            engineDidUpdate( grid as! GridProtocol )
        }
        
        if let rows = notification.userInfo!["rows"] {
            engine.rows = rows as! Int
        }
        
        if let cols = notification.userInfo!["cols"] {
            engine.cols = cols as! Int
        }
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        StandardEngine.singletonInstance.grid = withGrid
        
        lifeGrid.grid = withGrid
        lifeGrid.setNeedsDisplay()
    }
    
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        
        let next = engine.step()
        LifeGridNotification.gridChanged(next)
    }
    
    @IBAction func gridViewTap(gesture: UITapGestureRecognizer?) {
        let touchPoint = gesture?.locationInView(lifeGrid)
        
        print(touchPoint!)
        
        lifeGrid.toggleCellAtPoint(touchPoint!)
    }
    
    @IBAction func gridViewDragged(gesture: UIPanGestureRecognizer?) {
        let touchPoint = gesture?.locationInView(lifeGrid)
        print("state: \(gesture!.state.rawValue) \(touchPoint!)")
        
        switch(gesture!.state) {
        case .Began:
            heldState = lifeGrid.getCellAtPoint(touchPoint!).toggle()
            fallthrough
        case .Changed:
            lifeGrid.setCellAtPoint(touchPoint!, state: heldState)
        case .Ended:
            print("ended pan.")
        default:
            ()
        }
    }
    
    @IBAction func clearGrid(sender: AnyObject) {
        lifeGrid.grid.clear()
        lifeGrid.setNeedsDisplay()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let rlePattern = segue.destinationViewController as? LoaderViewController
            else {
                preconditionFailure("incorrect view controller")
        }
        
        if let url = self.lastUsedRLE {
            rlePattern.urlForPattern = url
        } else {
            rlePattern.urlForPattern = NSURL(string: "http://conwaylife.com/patterns/pulsar.rle")!
        }
        
        rlePattern.commit = { (pattern, url) in
            self.lifeGrid.embed(pattern: pattern)
            self.lastUsedRLE = url
            
            if let rule = pattern.metadata.ruleString {
                LifeGridNotification.ruleChanged(rule)
            }
            
            LifeGridNotification.gridChanged(self.lifeGrid.grid)
        }
    }
    
    

}

