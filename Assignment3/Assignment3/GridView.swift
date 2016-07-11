//
//  GridView.swift
//  Assignment3
//
//  Created by tinaun on 7/10/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {
    
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
    
    @IBInspectable var livingColor: UIColor = UIColor.whiteColor()
    
    @IBInspectable var emptyColor: UIColor = UIColor.blackColor()
    
    @IBInspectable var bornColor: UIColor = UIColor(red: CGFloat(0.9),
                                                    green: CGFloat(1.0),
                                                    blue: CGFloat(0.9),
                                                    alpha: CGFloat(1.0))
    @IBInspectable var diedColor: UIColor = UIColor(red: CGFloat(0.2),
                                                    green: CGFloat(0.1),
                                                    blue: CGFloat(0.1),
                                                    alpha: CGFloat(1.0))
    
    @IBInspectable var gridColor: UIColor = UIColor.lightGrayColor()
    
    @IBInspectable var gridWidth: CGFloat = 1.0
    
    var grid : Array<Array<CellState>>
    
    required init?(coder aDecoder: NSCoder) {
        grid = [Array<CellState>](count: rows, repeatedValue:
            [CellState](count: cols, repeatedValue: .Empty))
        
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        grid = [Array<CellState>](count: rows, repeatedValue:
            [CellState](count: cols, repeatedValue: .Empty))
        
        super.init(frame: frame)
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    // override func drawRect(rect: CGRect) {
    
    // }
    

}
