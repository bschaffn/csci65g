//
//  Engine.swift
//  Assignment2
//
//  Created by tinaun on 7/3/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import Foundation

//CustomStringConvertible makes the new World type play nicely with print()
struct World: CustomStringConvertible {
    var data: Array<Array<Bool>>
    let xSize: Int
    let ySize: Int
    
    init(size: Int){
        self.data = [Array<Bool>](count: size, repeatedValue: [Bool](count: size, repeatedValue: false))
        self.xSize = size
        self.ySize = size
    }
    
    var count: Int {
        get {
            return self.data.reduce(0) {
                (fold: Int, elem: Array<Bool>) -> Int in
                return fold + elem.map({
                    $0 ? 1 : 0
                }).reduce(0, combine: +)
            }
        }
    }
    
    var description: String {
        get {
            var desc = ""
            for line in data {
                desc += line.map({
                    $0 ? "X" : "."
                }).reduce("", combine: +) + "\n"
            }
            
            return desc
        }
    }
    
    subscript(x: Int, y: Int) -> Bool {
        get {
            return data[y][x]
        }
        
        set(cellValue) {
            data[y][x] = cellValue
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
        let maxInt = UInt32(100 / percent);
        
        for i in 0..<ySize {
            for j in 0..<xSize {
                if arc4random_uniform(maxInt) == 1 {
                    data[i][j] = true
                }
            }
        }
        
    }
    
    static func step(prev prev: World) -> World {
        var next = World(size: prev.xSize)
        
        func neighbors(world: World, cell: (Int, Int)) -> Int {
            let neighborList = [
                (cell.0 + 1, cell.1 + 1),
                (cell.0 + 1, cell.1),
                (cell.0 + 1, cell.1 - 1),
                
                (cell.0, cell.1 + 1),
                (cell.0, cell.1 - 1),
                
                (cell.0 - 1, cell.1 + 1),
                (cell.0 - 1, cell.1),
                (cell.0 - 1, cell.1 - 1)
            ]
            
            var neighbors = 0
            for (y, x) in neighborList {
                let clampedY = (y + world.ySize) % world.ySize
                let clampedX = (x + world.xSize) % world.xSize
                
                neighbors += world[clampedX, clampedY] ? 1 : 0
            }
            
            return neighbors
        }
        
        for y in 0..<prev.ySize {
            for x in 0..<prev.xSize {
                switch (prev[x, y], neighbors(prev, cell: (y, x))) {
                case (true, 2), (_, 3):
                    next[x, y] = true
                default:
                    ()
                }
            }
        }
        
        return next
    }
    
    static func step2(prev prev: World) -> World {
        var next = World(size: prev.xSize)
        
        for y in 0..<prev.ySize {
            for x in 0..<prev.xSize {
                let neighborCount = prev.neighbors(y, x).map({
                    (y, x) in prev[x, y] ? 1 : 0
                }).reduce(0, combine: +)
                
                switch (prev[x, y], neighborCount) {
                case (true, 2), (_, 3):
                    next[x, y] = true
                default:
                    ()
                }
            }
        }
        
        return next
    }
    
}