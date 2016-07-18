//
//  EngineProtocol.swift
//  Assignment4
//
//  Created by tinaun on 7/18/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import Foundation

protocol EngineProtocol {
    init(rows: Int, cols: Int)
    
    var delegate: EngineDelegate? { get set }
    var grid: GridProtocol { get }
    
    var refreshRate: Double { get set }
    var refreshTimer: NSTimer? { get set }
    
    var rows: Int { get set }
    var cols: Int { get set }
    
    func step() -> GridProtocol
}

// create an extension to provide a default value for the protocol
extension EngineProtocol {
    var refreshRate: Double {
        return 0.0
    }
}

