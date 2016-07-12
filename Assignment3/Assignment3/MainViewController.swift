//
//  MainViewController.swift
//  Assignment3
//
//  Created by tinaun on 7/11/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var fillButton: UIButton!
    
    @IBOutlet weak var lifeGrid: GridView!
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    // i should put this in a custom gesture recogniser class but w/e
    var heldState: CellState = .Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        
        lifeGrid.grid = World.step(prev: lifeGrid.grid)
        
        print("live cell count: \(lifeGrid.grid.count)")
        
        lifeGrid.setNeedsDisplay()
    }
    
    @IBAction func fillButtonPressed(sender: AnyObject) {
        lifeGrid.grid = World(rows: lifeGrid.rows, cols: lifeGrid.cols)
        
        lifeGrid.grid.randomFill(percentTrue: 33)
        
        lifeGrid.setNeedsDisplay()
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
            heldState = CellState.toggle(lifeGrid.getCellAtPoint(touchPoint!))
            fallthrough
        case .Changed:
            lifeGrid.setCellAtPoint(touchPoint!, state: heldState)
        case .Ended:
            print("ended pan.")
        default:
            ()
        }
    }

    
    
    
}
