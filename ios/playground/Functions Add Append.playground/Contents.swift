//: Playground - noun: a place where people can play

import UIKit

/*
//  Even Test
*/

var evens = [Int]()
for i in 1...10 {
    if i % 2 == 0 {
        evens.append(i)
    }
}
println(evens)

func isEven(number: Int) -> Bool {
    return number % 2 == 0
}

evens = Array(1...10).filter(isEven)
println(evens)

evens = Array(1...10).filter{ $0 % 2 == 0}
println(evens)

func myFilter<T>(source: [T], predicate:(T) -> Bool) -> [T] {
    var result = [T]()
    for i in source {
        if predicate(i) {
            result.append(i)
        }
    }
    return result
}

evens = myFilter(Array(1...10)) { $0 % 2 == 0 }
println(evens)

func evenPortia(num: Int) -> [Int] {
    if num == 1 {
        return []
    }
    return num % 2 != 0 ? evenPortia(num - 1) : ([num] + evenPortia(num - 1))
}

evenPortia(10)
var test = Array(1...10)
//test.myFilter{ $0 % 2 == 0 }

extension Array {
    func myFilter(predicate:(T) -> Bool) -> [T] {
        var result = [T]()
        for i in self {
            if predicate(i) {
                result.append(i)
            }
        }
        return result
    }
}

/*
//  Add Test
*/

evens = [Int] ()
for i in 1...10 {
    if i % 2 == 0 {
        evens.append(i)
    }
}

var evenSum = 0
for i in evens {
    evenSum += i
}
println(evenSum)

evenSum = Array(0...10).filter { (number) in number % 2 == 0 }.reduce(0) { (total, number) in total + number }
println(evenSum)

//func reduce<U>(initial: U, combine2: (U, T) -> U) -> U { }
//    The first parameter is the initial value, which is of type U. In your current code, the initial value is 0 and is of type Int (hence U is Int in this case). The second argument is the combine function that is executed once for each element of the array. Combine takes two arguments: the first, of type U, is the result of the previous invocation of combine; the second is the value of the array element that is being combined. The result returned by reduce is the value returned by the last combine invocation. There’s a lot going on here, so let’s break it down step by step. In your code, the first reduce iteration results in the following

let maxNumber = Array(1...10).reduce(0){ (total, number) in max(total, number) }
println(maxNumber)

let numbers = Array(1...10).reduce("numbers: ") { (total, number) in total + "\(number) " }
println(numbers)

let digits = ["3", "1", "4", "1"]

let arrayNumbers = digits.reduce(0){ (Int(total), number) in number }
println(arrayNumbers)



