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

class StandardEngine: EngineProtocol {
    
    private static var _instance = StandardEngine()
    static var singletonInstance: StandardEngine {
        get {
            return _instance
        }
    }
    
    var delegate: EngineDelegate?
    
    var rows: Int {
        didSet {
            if let d = delegate {
                d.engineDidUpdate( Grid(rows: rows, cols: cols) )
            }
        }
    }
    
    var cols: Int {
        didSet {
            if let d = delegate {
                d.engineDidUpdate( Grid(rows: rows, cols: cols) )
            }
        }
    }
    
    var grid: GridProtocol
    
    required init(rows: Int = 10, cols: Int = 10) {
        grid = Grid(rows, cols)
        
        self.rows = grid.rows
        self.cols = grid.cols
    }
    
    var refreshRate: Double
    var refreshTimer: NSTimer
    
    static func step(prev prev: GridProtocol) -> GridProtocol {
        var next: GridProtocol = Grid(rows: prev.rows, cols: prev.cols)
        
        for y in 0..<prev.rows {
            for x in 0..<prev.cols {
                let neighborCount = prev.neighbors((y, x)).map({
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
        
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("GridStepped", object: nil, userInfo: ["grid": next])
        
        return next
    }
    
}