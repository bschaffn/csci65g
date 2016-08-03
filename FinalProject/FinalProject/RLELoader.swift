//
//  RLELoader.swift
//  FinalProject
//
//  Created by tinaun on 8/2/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import Foundation

struct PatternMetadata {
    var ruleString: String?
    var name: String?
    var owner: String?
    var comments: Array<String>
    
    init(){
        ruleString = nil
        name = nil;
        owner = nil;
        comments = []
    }
}

struct Pattern {

    let startPos: (Int, Int)
    let data: Grid
    
    let metadata: PatternMetadata
    
    init(grid: Grid, start: (Int, Int)? = nil, metadata: PatternMetadata? = nil){
        data = grid
        if let s = start {
            startPos = s
        } else {
            startPos = (0 - grid.cols / 2, 0 - grid.rows / 2)
        }
        
        if let m = metadata {
            self.metadata = m
        } else {
            self.metadata = PatternMetadata()
        }
    }
    
}

protocol PatternLoader {
    func load(fromString string: String) -> Pattern?
}

class RLELoader: PatternLoader {
    let deadCell: Character
    let liveCell: Character
    let endOfLine: Character
    let endOfPattern: Character
    
    init(live: Character = "o", dead: Character = "b", eol: Character = "$", eof: Character = "!"){
        deadCell = dead
        liveCell = live
        endOfLine = eol
        endOfPattern = eof
    }
    
    func load(fromString string: String) -> Pattern? {
        let lines = string.componentsSeparatedByString("\n").map({
            $0.stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
        }).filter {
            !$0.isEmpty
        }
        
        func parseStartArgs(argList: String) -> (Int, Int)? {
            let list = argList.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ", ")).map { Int($0) }
            
            if let x = list[0], y = list[1] {
                return (x, y)
            } else {
                return nil
            }
        }
        
        var width: Int?
        var height: Int?
        var metadata = PatternMetadata()
        var start: (Int, Int)?
        
        for line in lines {
            if line[line.startIndex] == "#" {
                let secondIndex = line.startIndex.successor()
                let remainder = line.substringFromIndex(secondIndex.successor()).stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
                switch line[secondIndex] {
                case "C", "c" :
                    metadata.comments.append(remainder)
                case "N":
                    metadata.name = remainder
                case "O":
                    metadata.owner = remainder
                case "r":
                    metadata.ruleString = remainder
                case "P", "R":
                    start = parseStartArgs(remainder)
                case let x:
                    print("warning! #line identifier \(x) not recognized.")
                    
                }
            } else if line.containsString("=") {
                let values: [String: String] = line.componentsSeparatedByString(",").map({
                    let dfn = $0.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: "= ")).filter { !$0.isEmpty }
                    //print(dfn)
                    if dfn.count == 2 {
                        return [dfn[0]: dfn[1]]
                    } else {
                        return nil
                    }
                }).reduce([String: String]()){ (dict: [String: String], value: [String: String]?) -> [String: String] in
                    var newDict = dict
                    if let v = value {
                        newDict.updateValue(v.values.first!, forKey: v.keys.first!)
                    }
                    return newDict
                }
                
                print("values: \(values)")
                
                for (key, value) in values {
                    switch key {
                    case "x", "X":
                        width = Int(value)
                    case "y", "Y":
                        height = Int(value)
                    case "r", "R":
                        metadata.ruleString = value // its odd that i can't put these on the same line
                    case let x where x.lowercaseString == "rule":
                        metadata.ruleString = value
                    default:
                        print("warning! header line identifier \(key) not recognized.")
                    }
                }
            }
        }
        
        if let w = width, h = height {
            let grid = Grid(rows: h, cols: w)
            
            let runLengthEncoded = lines.filter({
                !($0.containsString("#") || $0.containsString("="))
            }).reduce("") { $0 + $1 }
            
            var x = 0
            var y = 0
            var run = 0
            
            for chr in runLengthEncoded.characters {
                switch chr {
                case "0"..."9":
                    run = run * 10 + Int(String(chr))!
                case liveCell:
                    run = run > 0 ? run : 1
                    for n in 0..<run {
                        grid[x + n, y] = .Living;
                    }
                    x += run
                    run = 0
                case deadCell:
                    run = run > 0 ? run : 1
                    x += run
                    run = 0
                case endOfLine:
                    x = 0;
                    y += run > 0 ? run : 1;
                    run = 0
                case endOfPattern:
                    break;
                default:
                    ()
                }
            }
            
            
            return Pattern(grid: grid, start: start, metadata: metadata)
        } else {
            print("ERROR: width and/or height not defined!")
            return nil
        }
    }
    
}

