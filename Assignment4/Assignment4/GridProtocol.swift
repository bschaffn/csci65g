//
//  GridProtocol.swift
//  Assignment4
//
//  Created by tinaun on 7/18/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import Foundation

typealias GridCoordinate = (row: Int, col: Int)

protocol GridProtocol {
    init( rows: Int, cols: Int )
    var rows: Int { get }
    var cols: Int { get }
    
    func neighbors( point: GridCoordinate ) -> Array<GridCoordinate>
    
    subscript(x: Int, y: Int) -> CellState { get set }

}