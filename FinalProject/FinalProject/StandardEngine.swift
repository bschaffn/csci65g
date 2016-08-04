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
    
    private static var _instance: StandardEngine?
    static var singletonInstance: StandardEngine {
        get {
            if let i = _instance {
                return i;
            } else {
                _instance = StandardEngine()
                return _instance!
            }
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
    
    var rule: LifeRule
    var grid: GridProtocol
    
    required init(rows: Int = 10, cols: Int = 10) {
        grid = Grid(rows: rows, cols: cols)
        rule = LifeRule.StandardLife()
        
        self.rows = grid.rows
        self.cols = grid.cols
        
        delegate = nil
        refreshTimer = nil
    }
    
    var refreshTimer: NSTimer?
    var refreshRate: Double = 0.0 {
        didSet {
            if refreshRate != 0 {
                if let timer = refreshTimer {
                    timer.invalidate()
                }
                let sel = #selector(StandardEngine.timerDidFire(_:))
                
                refreshTimer = NSTimer.scheduledTimerWithTimeInterval( 1 / refreshRate, target: self, selector: sel,
                userInfo: nil,
                repeats: true)
            }
            else if let timer = refreshTimer {
                timer.invalidate()
                self.refreshTimer = nil
            }
        }
    }
    
    func step() -> GridProtocol {
        let next: GridProtocol = Grid(rows: rows, cols: cols)
        
        for y in 0..<grid.rows {
            for x in 0..<grid.cols {
                let neighborCount = grid.neighbors((x, y)).map({
                    (y, x) in grid[x, y].isAlive() ? 1 : 0
                }).reduce(0, combine: +)
                
                switch (grid[x, y].isAlive(), neighborCount) {
                case (true, let t) where rule.stay[t] == true:
                    next[x, y] = .Living
                case (false, let t) where rule.born[t] == true:
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
    
    @objc func timerDidFire(timer:NSTimer) {
        let next = step()
        delegate!.engineDidUpdate(next)
        
        let center = NSNotificationCenter.defaultCenter()
        let n = NSNotification(name: "GridChanged",
                               object: nil,
                               userInfo: ["grid": next])
        center.postNotification(n)
    }
    
}