//: Playground - noun: a place where people can play

import Foundation

let immutableString = "hello, immutable string!"
var str = "Hello, playground"

str = "another string"

var myInt = 42

let implicitDouble = 70.0
let explicitDouble: Double = 70

let width = 94
let widthLabel = "the width is " + String(width)

let apples = 5
let oranges = 7

let fruitSummary = "I have \(apples) apples and \(oranges) oranges in my \(width)ft wide bowl of fruit!"

var shList = ["catfish",
              "water",
              "tulips",
              "blue paint"]
var copyList = shList

shList.append("toothpaste")
shList.appendContentsOf(shList)

copyList

var occupation: Dictionary<String,String> = [
    "malcolm": "captain",
    "kalyee":  "mechanic"
]

occupation["jayne"] = "Public Relations"

var occNames = occupation.map { (k: String, v: String) -> String in
    return k
}
occNames

var r = 50...100
var g = r.generate()
g.next()
g.next()

var g1 = [11,21,31,41,51].generate()

var tuple1 = (1,2)
tuple1.0
tuple1.1

var tuple2 = (first:"van", last:"Simmons")
tuple2.0 == tuple2.first
tuple2.last

for (k,v) in occupation {
    print("\(k), \(v)")
}

func doubler(x: Int) -> Int {
    return x*2
}

func addThree(a: Int, b: Int, c: Int) -> Int {
    return a + b + (2*c)
}

func doubleDoubler(x: Double) -> Double {
    return x*2
}

doubler(4)
doubleDoubler(3.14)

addThree(1,b: 2,c: 4)

func progression(v:Int, f:Int->Int) -> Int {
    return f(v)
}

progression(4, f: doubler)
//progression(7, f: doubleDoubler)

var arrArr: Array<Dictionary<Int,Bool>> = [[1: true], [2: false]]

var closure = { (x: Int) -> Int in
    return x*2
}

closure(5)

var n: String? = nil

