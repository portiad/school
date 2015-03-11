// Playground - noun: a place where people can play

import UIKit

var myTuple = ("tigger", "bengal", 3)

let name = myTuple.0

var secondTigerTuple = (name:"tigress", breed:"indochinese tiger", age:2)

secondTigerTuple.name


switch secondTigerTuple {
case ("tigress", "malayan", 2):
    println("first true")
case (_,"indochinese tiger", _)
    println("second true")
default:
    println("hit default")
}

var t, var i = ("hit", "bit")

