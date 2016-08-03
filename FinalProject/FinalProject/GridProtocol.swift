//
//  GridProtocol.swift
//  Assignment4
//
//  Created by tinaun on 7/18/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import Foundation

typealias GridCoordinate = (row: Int, col: Int)

protocol GridProtocol: AnyObject {
    init( rows: Int, cols: Int )
    var rows: Int { get }
    var cols: Int { get }
    var count: Int { get }
    var points: [GridCoordinate] { get set }
    
    func clear()
    
    func neighbors( point: GridCoordinate ) -> Array<GridCoordinate>
    
    subscript(x: Int, y: Int) -> CellState { get set }

}