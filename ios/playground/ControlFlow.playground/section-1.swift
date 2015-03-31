// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let truckSpeed = 45
let lamboSpeed = 120

var mySpeed:Int
var myFriendsSpeed = 99

mySpeed = 100

if mySpeed < 70 || myFriendsSpeed <= 90 {
    println("Keep Cruising")
}
else if mySpeed > 90 {
    println("No friend but I am going!")
}
else {
    println("Slow down police ahead")
}


let isTelevisionOn = false


if isTelevisionOn == true {
    println("Make sure to turn the tv off when you are done.")
}
else {
    println("Do you want to turn it on?")
}

var intValue = 5
var doubleValue = 0.5

var sumOfValues = Double(intValue) + doubleValue

var secondDoubleValue = 1.5
var secondIntValue = 8

var secondValues = Int(secondDoubleValue) + secondIntValue
