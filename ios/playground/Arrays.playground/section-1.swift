// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//var tigerNames:Array<String>

//var tigerNames:[String]

var tigerNames = ["Tigger", "Spar", "Tigress", "Jacob"]
var tigerAges = [3,2,5,4]

var emptyArray:[String] = []

if emptyArray.isEmpty {
    println("No")
}
else {
    println("Yes")
}


println("\(tigerNames.count)")
println("\(emptyArray.count)")


let firstNameFromArray = tigerNames[0]
let secondAgeInTigersAge = tigerAges[1]

for var i = 0; i < tigerNames.count; i++ {
    let instanceFromArray = tigerNames[i]
    println(instanceFromArray)
}

for tigerName in tigerNames {
    println(tigerName)
}

for x in 1...3 {
    println(x)
}

for (index, tigerName) in enumerate(tigerNames) {
    println("index:\(index) name:\(tigerName)")
}


tigerNames.append("Jeff")
println(tigerNames)

tigerNames += ["John"]

tigerNames[1] = "Portia"
println(tigerNames)

tigerNames[0...2] = ["Jason", "Fusun", "Mark"]
println(tigerNames)

tigerNames.insert("Julie", atIndex: 1)
println(tigerNames)

tigerNames.removeLast()
println(tigerNames)

tigerNames.removeAtIndex(1)
println(tigerNames)

tigerNames.removeAll(keepCapacity: false)
println(tigerNames)

let randomNumber = Int(arc4random_uniform(UInt32(5)))



