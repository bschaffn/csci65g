//
//  StatisticsViewController.swift
//  Assignment4
//
//  Created by tinaun on 7/18/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    
    @IBOutlet weak var aliveCells: UILabel!
    @IBOutlet weak var bornCells: UILabel!
    @IBOutlet weak var deadCells: UILabel!
    @IBOutlet weak var emptyCells: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sel = #selector(StatisticsViewController.watchForNotifications(_:))
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: sel, name: "GridChanged", object: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func watchForNotifications(notification: NSNotification) {
        print("notification recieved \(notification)")
        
        if let grid = notification.userInfo!["grid"] {
            let realGrid = grid as! GridProtocol
            
            var (a, b, c, d) = (0, 0, 0, 0)
            
            for y in 0..<realGrid.rows {
                for x in 0..<realGrid.cols {
                    switch realGrid[x, y] {
                    case .Living:
                        a += 1
                    case .Born:
                        b += 1
                    case .Died:
                        c += 1
                    case .Empty:
                        d += 1
                    }
                }
            }
            
            
            aliveCells.text = String(a)
            bornCells.text = String(b)
            deadCells.text = String(c)
            emptyCells.text = String(d)
        }
    }
    

    

}
