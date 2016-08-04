//
//  LifeGridNotifications.swift
//  FinalProject
//
//  Created by tinaun on 8/4/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import Foundation

class LifeGridNotification {
    private static var center_: NSNotificationCenter?
    
    static var center: NSNotificationCenter {
        get {
            if let c = center_ {
                return c;
            } else {
                center_ = NSNotificationCenter.defaultCenter()
                return center_!
            }
        }
    }
    
    static func addObserver(observer: AnyObject, selector: Selector) {
        self.center.addObserver(observer, selector: selector, name: "GridChanged", object: nil)
    }
    
    static func gridChanged(withGrid: GridProtocol) {
        let n = NSNotification(name: "GridChanged", object: nil, userInfo: ["grid": withGrid])
        
        self.center.postNotification(n)
    }
    
    static func speedChanged(withSpeed: Double) {
        let n = NSNotification(name: "GridChanged", object: nil, userInfo: ["speed": withSpeed])
        
        self.center.postNotification(n)
    }
    
    static func ruleChanged(withRule: String) {
        let n = NSNotification(name: "GridChanged", object: nil, userInfo: ["rule": withRule])
        
        self.center.postNotification(n)
    }
    
    static func resized(rows rows: Int? = nil, cols: Int? = nil) {
        if let rows = rows {
            let n = NSNotification(name: "GridChanged", object: nil, userInfo: ["rows": rows])
            
            self.center.postNotification(n)
        }
        
        if let cols = cols {
            let n = NSNotification(name: "GridChanged", object: nil, userInfo: ["cols": cols])
            
            self.center.postNotification(n)
        }
    }
    
}