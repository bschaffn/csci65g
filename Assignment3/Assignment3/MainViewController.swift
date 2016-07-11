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
    @IBOutlet weak var lifeGrid: GridView!
    
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
    

}
