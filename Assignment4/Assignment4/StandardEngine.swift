//
//  StandardEngine.swift
//  Assignment3-4
//
//  Created by tinaun on 7/10/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import Foundation

enum CellState: String {
    case Living
    case Empty
    case Born
    case Died
    
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
    
    func toggle() -> CellState {
        switch self {
        case .Empty, .Died:
            return .Living
        case .Living, .Born:
            return .Empty
        }
    }
    
}

struct StandardEngine: EngineProtocol {
    
    var delegate: EngineDelegate
    
    var rows: Int {
        didSet {
            grid = Grid(rows: rows, cols: cols)
        }
    }
    
    var cols: Int {
        didSet {
            grid = Grid(rows: rows, cols: cols)
        }
    }
    
    var grid: GridProtocol
    
    init(rows: Int, cols: Int) {
        grid = Grid(rows, cols)
        
        rows = grid.rows
        cols = grid.cols
    }
    
    var refreshRate: Double
    var refreshTimer: NSTimer
    
    static func step(prev prev: GridProtocol) -> GridProtocol {
        var next = Grid(rows: prev.rows, cols: prev.cols)
        
        for y in 0..<prev.rows {
            for x in 0..<prev.cols {
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