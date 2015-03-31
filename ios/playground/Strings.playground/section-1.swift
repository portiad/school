// Playground - noun: a place where people can play

import UIKit

var string1 = "Hello, playground"
string1 = "Hello"
let string2 = "World"
var helloWorld = string1 + " " + string2



helloWorld = helloWorld.uppercaseString
helloWorld = helloWorld.lowercaseString

var firstCharacter = "!"

firstCharacter = helloWorld + firstCharacter

let x = 5
let newString =  "\(x)"

let floatValue = 3.5
let newFloatString = "\(floatValue)"

let numberString = "9"
let numberStringtoInt = numberString.toInt()
var optionalToInt = numberStringtoInt!
optionalToInt += 3


var doubleString = "3.9585"
var doubleValueFromString = Double((doubleString as NSString).doubleValue)
doubleValueFromString = doubleValueFromString + 3.85






