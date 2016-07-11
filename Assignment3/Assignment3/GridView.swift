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
    
    // both are required for interface builder to not crash
    // i could have set a default value for grid to not have to implement these
    // but then i couldn't have used the rows and cols values instead of redefining constants
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
    
    
    override func drawRect(rect: CGRect) {
        let gridPath = UIBezierPath()
        gridPath.lineWidth = gridWidth
        
        let gridSpacing = min(bounds.width / CGFloat(cols), bounds.height / CGFloat(rows))
        
        // prevents odd line widths from being blurry
        let strokeCorrect: CGFloat = gridWidth % 2 == 0 ? 0 : 0.5
        
        // construct bounds for best fit for grid
        let gridBounds = (height: CGFloat(rows) * gridSpacing, width: CGFloat(cols) * gridSpacing)
        
        let top = (bounds.height - gridBounds.height) / 2
        
        let left = (bounds.width - gridBounds.width) / 2
        
        //vertical grid lines
        for column in 1..<cols {
            let col = CGFloat(column)

            gridPath.moveToPoint(CGPoint(
                x: round(left + col * gridSpacing) + strokeCorrect, y: top
            ))
            
            gridPath.addLineToPoint(CGPoint(
                x: round(left + col * gridSpacing) + strokeCorrect, y: top + gridBounds.height
            ))
        }
        
        //horizontal grid lines
        for r in 1..<rows {
            let row = CGFloat(r)
            
            gridPath.moveToPoint(CGPoint(
                x: left, y: round(top + row * gridSpacing) + strokeCorrect
            ))
            
            gridPath.addLineToPoint(CGPoint(
                x: left + gridBounds.width, y: round(top + row * gridSpacing) + strokeCorrect
            ))
        }
        
        gridColor.setStroke()
        gridPath.stroke()
        
        for y in 0..<rows {
            for x in 0..<cols {
                let cellOrigin = CGPoint(x: gridWidth/2 + left + CGFloat(x) * gridSpacing,
                                         y: gridWidth/2 + top + CGFloat(y) * gridSpacing)
                
                let cellSize = CGSize(width: gridSpacing - gridWidth, height: gridSpacing - gridWidth)
                
                let cellRect = CGRect(origin: cellOrigin, size: cellSize)
                
                let cellPath = UIBezierPath(ovalInRect: cellRect)
                
                switch grid[y][x] {
                case .Empty:
                    emptyColor.setFill()
                case .Born:
                    emptyColor.setFill()
                case .Died:
                    bornColor.setFill()
                case .Living:
                    livingColor.setFill()
                }
                
                cellPath.fill()
            }
        }
        
    }
    

}
