//
//  Engine.swift
//  Assignment3
//
//  Created by tinaun on 7/10/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import Foundation

enum CellState: String {
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
    
    func isAlive() -> Bool {
        switch self {
        case .Living, .Born:
            return true
        case .Empty, .Died:
            return false
        }
    }
    
    static func description(state: CellState) -> String {
        return state.rawValue
    }
    
    static func allValues() -> Array<CellState> {
        return [
            .Living,
            .Empty,
            .Born,
            .Died
        ]
    }
    
    static func toggle(value: CellState) -> CellState {
        switch value {
        case .Empty, .Died:
            return .Living
        case .Living, .Born:
            return .Empty
        }
    }
    
}

//CustomStringConvertible makes the new World type play nicely with print()
struct World: CustomStringConvertible {
    var data: Array<Array<CellState>>
    let xSize: Int
    let ySize: Int
    
    init(rows: Int, cols: Int){
        self.data = [Array<CellState>](count: rows, repeatedValue: [CellState](count: cols, repeatedValue: .Empty))
        self.xSize = cols
        self.ySize = rows
    }
    
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
    
    // utility for bounding arrays
    func clamp(value: Int, min: Int, max: Int) -> Int {
        if value < min {
            return min
        }
        
        if value >= max {
            return max - 1
        }
        
        return value
    }
    
    subscript(x: Int, y: Int) -> CellState {
        get {
            return data[clamp(y, min: 0, max: ySize)][clamp(x, min:0, max: xSize)]
        }
        
        set(cellValue) {
            data[clamp(y, min: 0, max: ySize)][clamp(x, min:0, max: xSize)] = cellValue
        }
    }
    
    func neighbors(row: Int, _ column: Int) -> Array<(Int, Int)> {
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
            ((row + ySize) % ySize, (column + xSize) % xSize)
        }
    }
    
    mutating func randomFill(percentTrue percent: Int) {
        for i in 0..<ySize {
            for j in 0..<xSize {
                if arc4random_uniform(100) < UInt32(percent) {
                    data[i][j] = .Living
                }
            }
        }
        
    }
    
    static func step(prev prev: World) -> World {
        var next = World(rows: prev.ySize, cols: prev.xSize)
        
        for y in 0..<prev.ySize {
            for x in 0..<prev.xSize {
                let neighborCount = prev.neighbors(y, x).map({
                    (y, x) in prev[x, y].isAlive() ? 1 : 0
                }).reduce(0, combine: +)
                
                switch (prev[x, y].isAlive(), neighborCount) {
                case (true, 2), (true, 3):
                    next[x, y] = .Living
                case (false, 3):
                    next[x, y] = .Born
                case (true, _):
                    next[x, y] = .Died
                default:
                    ()
                }
            }
        }
        
        return next
    }
    
}