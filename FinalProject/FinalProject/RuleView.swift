//
//  RuleView.swift
//  FinalProject
//
//  Created by tinaun on 8/2/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

struct LifeRule: CustomStringConvertible {
    var born: [Bool]
    var stay: [Bool]
    
    var description: String {
        get {
            let bstr = born.enumerate().reduce("") {
                if $1.1 {
                    return $0 + String($1.0)
                } else {
                    return $0
                }
            }
            
            let sstr = stay.enumerate().reduce("") {
                if $1.1 {
                    return $0 + String($1.0)
                } else {
                    return $0
                }
            }
            
            return "B\(bstr)/S\(sstr)"
        }
    }
    
    init(born: [Int], stay: [Int]) {
        self.born = [Bool](count: 9, repeatedValue: false)
        self.stay = [Bool](count: 9, repeatedValue: false)
        
        for i in born {
            self.born[i] = true
        }
        
        for i in stay {
            self.stay[i] = true
        }
    }
    
    init?(ruleString: String){
        born = [Bool](count: 9, repeatedValue: false)
        stay = [Bool](count: 9, repeatedValue: false)
        
        let rules = ruleString.componentsSeparatedByString("/")
        
        if rules.count < 2 {
            return nil
        }
        
        func intoIntArray(string: String) -> [Int] {
            return string.characters.reduce([Int]()) { (arr, chr) -> [Int] in
                var l = arr
                if let n = Int(String(chr)) {
                    l.append(n)
                }
                return l
            }
        }
        
        var bornList = [Int]()
        var stayList = [Int]()
        if rules[0].capitalizedString.containsString("B"){
            bornList = intoIntArray(rules[0])
        } else {
            stayList = intoIntArray(rules[0])
        }
        
        if rules[1].capitalizedString.containsString("S"){
            stayList = intoIntArray(rules[1])
        } else {
            bornList = intoIntArray(rules[1])
        }
        
        for i in bornList {
            born[i] = true
        }
        
        for i in stayList {
            stay[i] = true
        }
    }
    
    static var namedRule = ["B3/S23": "Life", "B2/S": "Seeds", "B3/S12345": "Maze",
                            "B36/S125": "2x2", "B36/S23": "HighLife", "B3678/S34678": "Day & Night"]
    
    func getName() -> String {
        if let name = LifeRule.namedRule[description] {
            return name
        } else {
            return description
        }
    }
    
    //MARK: Named Rules
    static func StandardLife() -> LifeRule {
        return LifeRule(ruleString: "B3/S23")!
    }
    
    static func Seeds() -> LifeRule {
        return LifeRule(ruleString: "B2/S")!
    }
    
    static func Maze() -> LifeRule {
        return LifeRule(ruleString: "B3/S12345")!
    }
    
    static func TwoByTwo() -> LifeRule {
        return LifeRule(ruleString: "B3/S125")!
    }
    
    static func HighLife() -> LifeRule {
        return LifeRule(ruleString: "B36/S23")!
    }
    
    static func DayAndNight() -> LifeRule {
        return LifeRule(ruleString: "B3678/S34678")!
    }
    
}


@IBDesignable class RuleView: UIView {
    
    @IBInspectable var liveColor: UIColor = UIColor.blackColor()
    @IBInspectable var deadColor: UIColor = UIColor.whiteColor()
    @IBInspectable var liveTextColor: UIColor = UIColor.whiteColor()
    @IBInspectable var deadTextColor: UIColor = UIColor.blackColor()
    
    var rule = LifeRule.StandardLife();
    
    func updateRuleWithPoint(point: CGPoint) -> CGRect {
        let width = bounds.width / 9;
        let height = bounds.height / 2;
        
        let xPos = floor(point.x / width)
        let yPos = floor(point.y / height)
        
        if yPos == 0 {
            rule.born[Int(xPos)] = !(rule.born[Int(xPos)])
        } else {
            rule.stay[Int(xPos)] = !(rule.stay[Int(xPos)])
        }
        
        return CGRect(x: width*xPos, y: height*yPos, width: width, height: height)
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let width = bounds.width / 9;
        let height = bounds.height / 2;
        
        func drawCells(i: Int, _ neighbors: Bool, stay: Bool) -> () {
            var textColor: UIColor
            
            if neighbors {
                liveColor.setFill()
                textColor = liveTextColor
            } else {
                deadColor.setFill()
                textColor = deadTextColor
            }
            
            let yPos = stay ? height : 0.0;
            
            let cellRect = CGRect(x: width*CGFloat(i), y: yPos, width: width, height: height)
            UIBezierPath(rect: cellRect).fill()
            
            let p = NSMutableParagraphStyle()
            p.alignment = NSTextAlignment.Center
            
            let text = NSAttributedString(string: String(i), attributes:[NSForegroundColorAttributeName: textColor,
                NSParagraphStyleAttributeName: p])
            
            let fontHeight = UIFont(name: "Helvetica Neue", size: 12)!.pointSize
            let yOffset = (cellRect.size.height - fontHeight) / 2.0
            let textRect = CGRect(x: width*CGFloat(i), y: yPos + yOffset, width: width, height: fontHeight )
            
            text.drawInRect(textRect)
        }
        
        let _ = rule.born.enumerate().map {
            drawCells($0, $1, stay: false)
        }
        
        let _ = rule.stay.enumerate().map {
            drawCells($0, $1, stay: true)
        }
    }
    

}
