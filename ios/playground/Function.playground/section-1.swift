// Playground - noun: a place where people can play

import UIKit

func printHelloWord() {
    println("Hello World")
    println("Hello Class")
}

printHelloWord()
printHelloWord()

func printNumberSupplied(num:Int) {
    println("\(num)")
}
printNumberSupplied(3)
printNumberSupplied(4)


func turnOffAppliance(applianceName:String, isOn:Bool) {
    if isOn {
        println("please turn off \(applianceName)")
    }
    else {
        println("\(applianceName) is already off")
    }
}

turnOffAppliance("Fridge", false)

func additionFunction(x:Int, y:Int) -> Int {
    return x + y
}

additionFunction(2, 3)
let finalAnswer = additionFunction(3, 6)


func helloWorldString() -> String {
    printHelloWord()
    return "Hello World"
}

var helloWorld = helloWorldString()
helloWorld += "!"


