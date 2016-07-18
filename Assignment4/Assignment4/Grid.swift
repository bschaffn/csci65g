//
//  File.swift
//  Assignment4
//
//  Created by tinaun on 7/18/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import Foundation

// utility for bounding arrays
func clamp(value: Int, min: Int? = nil, max: Int? = nil) -> Int {
    if let minValue = min {
        if minValue > value {
            return minValue
        }
    }
    
    if let maxValue = max {
        if value >= max {
            return maxValue - 1
        }
    }
    
    return value
}

class Grid: GridProtocol, CustomStringConvertible {
    
    //required for GridProtocol compliance
    var rows: Int
    var cols: Int
    
    var data: Array<Array<CellState>>
    
    required init(rows: Int, cols: Int) {
        self.rows = clamp(rows, min: 1)
        self.cols = clamp(cols, min: 1)
        
        data = [Array<CellState>](count: rows, repeatedValue: [CellState](count: cols, repeatedValue: .Empty))
    }
    
    subscript(x: Int, y: Int) -> CellState {
        get {
            return data[clamp(y, min: 0, max: rows)][clamp(x, min:0, max: cols)]
        }
        
        set(cellValue) {
            data[clamp(y, min: 0, max: rows)][clamp(x, min:0, max: cols)] = cellValue
        }
    }
    
    func neighbors(point: GridCoordinate) -> Array<GridCoordinate> {
        let (row, column) = point
        
        let neighborList = [
            (row + 1, column + 1),
            (row + 1, column),
            (row + 1, column - 1),
            
            (row, column + 1),
            (row, column - 1),
            
            (row - 1, column + 1),
            (row - 1, column),
            (row - 1, column - 1)
        ]
        
        return neighborList.map { (row, column) in
            ((row + rows) % rows, (column + cols) % cols)
        }
    }
    
    //utility functions to make life easier
    var count: Int {
        get {
            return self.data.reduce(0) {
                (fold: Int, elem: Array<CellState>) -> Int in
                return fold + elem.map({
                    $0.isAlive() ? 1 : 0
                }).reduce(0, combine: +)
            }
        }
    }
    
    var description: String {
        get {
            var desc = ""
            for line in data {
                desc += line.map({
                    switch $0 {
                    case .Empty:
                        return "."
                    case .Died:
                        return ","
                    case .Living:
                        return "#"
                    case .Born:
                        return "X"
                    }
                }).reduce("", combine: +) + "\n"
            }
            
            return desc
        }
    }
    
}