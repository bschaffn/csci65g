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