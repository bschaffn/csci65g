//
//  GridView.swift
//  Assignment3
//
//  Created by tinaun on 7/10/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {
    typealias GridBounds = (left: CGFloat, top: CGFloat, width: CGFloat, height: CGFloat)
    
    @IBInspectable var rows: Int = 20 {
        didSet {
            grid = World(rows: rows, cols: cols)
        }
    }
    
    @IBInspectable var cols: Int = 20 {
        didSet {
            grid = World(rows: rows, cols: cols)
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
    
    // computed properties for grid layout
    
    var gridSpacing: CGFloat {
        get {
            return min(bounds.width / CGFloat(cols), bounds.height / CGFloat(rows))
        }
    }
    
    var gridBounds: GridBounds {
        get {
            let height = CGFloat(rows) * gridSpacing
            let width =  CGFloat(cols) * gridSpacing
            let top = (bounds.height - height) / 2
            let left = (bounds.width - width) / 2
            
            return (left, top, width, height)
        }
    }
    
    // helper functions for grid layout
    func getCellBoundsForIndex(x: Int, _ y: Int) -> CGRect {
        let xPos = gridBounds.left + CGFloat(x) * gridSpacing
        let yPos = gridBounds.top + CGFloat(y) * gridSpacing
        
        return CGRect(x: xPos, y: yPos, width: gridSpacing, height: gridSpacing)
    }
    
    var grid : World
    
    // both are required for interface builder to not crash
    // i could have set a default value for grid to not have to implement these
    // but then i couldn't have used the rows and cols values instead of redefining constants
    
    // contentMode.Redraw tells ios to redraw everything on resize
    required init?(coder aDecoder: NSCoder) {
        grid = World(rows: rows, cols: cols)
        
        super.init(coder: aDecoder)
        contentMode = .Redraw
    }
    
    override init(frame: CGRect) {
        grid = World(rows: rows, cols: cols)
        
        super.init(frame: frame)
        contentMode = .Redraw
    }
    
    @IBAction func gridViewTap(gesture: UITapGestureRecognizer?) {
        let touchPoint = gesture?.locationInView(self)
        
        print(touchPoint!)
        
        let x = Int( floor((touchPoint!.x - gridBounds.left) / gridSpacing) )
        let y = Int( floor((touchPoint!.y - gridBounds.top) / gridSpacing) )
        
        grid[x,y] = CellState.toggle(grid[x,y])
        
        self.setNeedsDisplayInRect(self.getCellBoundsForIndex(x,y))
    }
    
    
    override func drawRect(rect: CGRect) {
        let gridPath = UIBezierPath()
        gridPath.lineWidth = gridWidth
        
        // prevents odd line widths from being blurry
        let strokeCorrect: CGFloat = gridWidth % 2 == 0 ? 0 : 0.5
        
        // grid layout padding
        let top = gridBounds.top
        let left = gridBounds.left

        
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
        
        //cells
        for y in 0..<rows {
            for x in 0..<cols {
                let xPos = round(left + CGFloat(x) * gridSpacing)
                let yPos = round(left + CGFloat(y) * gridSpacing)
            
                let width = round(left + CGFloat(x+1) * gridSpacing) - xPos
                let height = round(top + CGFloat(y+1) * gridSpacing) - yPos
                
                let cellRect = CGRect(x: xPos + gridWidth / 2, y: yPos + gridWidth / 2,
                                      width: width - gridWidth, height: height - gridWidth)
                
                let cellPath = UIBezierPath(ovalInRect: cellRect)
                
                switch grid[x, y] {
                case .Empty:
                    emptyColor.setFill()
                case .Born:
                    bornColor.setFill()
                case .Died:
                    diedColor.setFill()
                case .Living:
                    livingColor.setFill()
                }
                
                cellPath.fill()
            }
        }
        
    }
    

}
