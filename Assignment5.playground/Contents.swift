//: Assignment 5 - isLeap and julianDate
//  2016 Bennett Schaffner

func isLeap(year year: Int) -> Bool {
    return year % 4 == 0 ? year % 100 == 0 ? year % 400 == 0 ? true : false : true : false
}


let monthCounts = [31,28,31,30,31,30,31,31,30,31,30,31]
monthCounts.reduce(0, combine: +)

func julianDate(year year: Int, month: Int, day: Int) -> Int {
    var days = (1900..<year).reduce(0) { $0 + (isLeap(year: $1) ? 366 : 365) }
    
    days += (1..<month).reduce(0) { $0 + monthCounts[$1 - 1] }
    
    return days + day
}

julianDate(year: 1960, month:  9, day: 28)
julianDate(year: 1900, month:  1, day: 1)
julianDate(year: 1900, month: 12, day: 31)
julianDate(year: 1901, month: 1, day: 1)
julianDate(year: 1901, month: 1, day: 1) - julianDate(year: 1900, month: 1, day: 1)
julianDate(year: 2001, month: 1, day: 1) - julianDate(year: 2000, month: 1, day: 1)


isLeap(year: 1937)
isLeap(year: 1960)
isLeap(year: 1900)
isLeap(year: 2000)