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
        typealias LifeGrid = Array<Array<Bool>>
        
        OutputText.text = "Button 2 Pressed.\n"
        print("Button 2 Pressed.")
        
        //utility functions
        func wprint(world: LifeGrid) {
            for line in world {
                print(line.map({
                    $0 ? "X" : "."
                }).reduce("", combine: +));
            }
            print("")
        }
        
        func aliveCount(world: LifeGrid) -> Int {
            return world.reduce(0) {
                (fold: Int, elem: Array<Bool>) -> Int in
                return fold + elem.map({
                    $0 ? 1 : 0
                }).reduce(0, combine: +)
            }
        }
        
        //create 10 x 10 array
        var squarray = [Array<Bool>](count: 10, repeatedValue: [Bool](count: 10, repeatedValue: false))
        
        
        //fill with values
        for i in 0..<squarray.count {
            for j in 0..<squarray[0].count {
                if arc4random_uniform(3) == 1 {
                    squarray[i][j] = true;
                }
            }
        }
    
        //count values
        let before = aliveCount(squarray)
        OutputText.text = OutputText.text + "before count: \(before).\n"
        
        print("previous world:")
        wprint(squarray)
        
        //get next generation
        var nextStep = [Array<Bool>](count: 10, repeatedValue:[Bool](count: 10, repeatedValue: false))
        
        func neighbors(world: LifeGrid, cell: (Int, Int)) -> Int {
            let neighborList = [
                (cell.0 + 1, cell.1 + 1),
                (cell.0 + 1, cell.1),
                (cell.0 + 1, cell.1 - 1),
                
                (cell.0, cell.1 + 1),
                (cell.0, cell.1 - 1),
    
                (cell.0 - 1, cell.1 + 1),
                (cell.0 - 1, cell.1),
                (cell.0 - 1, cell.1 - 1)
            ]
            
            var neighbors = 0
            for (y, x) in neighborList {
                let clampedY = (y + world.count) % world.count
                let clampedX = (x + world[0].count) % world[0].count
                
                neighbors += world[clampedY][clampedX] ? 1 : 0
            }
            
            return neighbors
        }
        
        for i in 0..<squarray.count {
            for j in 0..<squarray[0].count {
                switch (squarray[i][j], neighbors(squarray, cell: (i,j))) {
                case (true, 2), (_, 3):
                    nextStep[i][j] = true
                default:
                    ()
                }
            }
        }
        
        print("current world:")
        wprint(nextStep)
        
        let after = aliveCount(nextStep)
        
        OutputText.text = OutputText.text + "after count: \(after)."
    }
    
}