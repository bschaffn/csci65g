//
//  GridView.swift
//  Assignment3
//
//  Created by tinaun on 7/10/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        grid = [Array<CellState>](count: rows, repeatedValue:
            [CellState](count: cols, repeatedValue: .Empty))
        
        super.init(coder: aDecoder)
    }
    
    @IBInspectable var rows: Int = 20 {
        didSet {
            grid = [Array<CellState>](count: rows, repeatedValue:
                [CellState](count: cols, repeatedValue: .Empty))
        }
    }
    
    @IBInspectable var cols: Int = 20 {
        didSet {
            grid = [Array<CellState>](count: rows, repeatedValue:
                [CellState](count: cols, repeatedValue: .Empty))
        }
    }
    
    @IBInspectable var livingColor: UIColor = UIColor(red: CGFloat(1.0),
                                                      green: CGFloat(1.0),
                                                      blue: CGFloat(1.0),
                                                      alpha: CGFloat(1.0))
    @IBInspectable var emptyColor: UIColor = UIColor(red: CGFloat(0.0),
                                                     green: CGFloat(0.0),
                                                     blue: CGFloat(0.0),
                                                     alpha: CGFloat(1.0))
    @IBInspectable var bornColor: UIColor = UIColor(red: CGFloat(0.9),
                                                    green: CGFloat(1.0),
                                                    blue: CGFloat(0.9),
                                                    alpha: CGFloat(1.0))
    @IBInspectable var diedColor: UIColor = UIColor(red: CGFloat(0.2),
                                                    green: CGFloat(0.1),
                                                    blue: CGFloat(0.1),
                                                    alpha: CGFloat(0.0))
    
    @IBInspectable var gridWidth: CGFloat = 1.0
    
    var grid : Array<Array<CellState>>
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
