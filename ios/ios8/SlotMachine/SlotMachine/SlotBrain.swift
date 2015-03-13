//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by Portia Dean on 3/12/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import Foundation

class SlotBrain {
    class func unpackSlotsIntoSlotRows (slots: [[Slot]]) -> [[Slot]] {
        var slotRow: [Slot] = []
        var slotRow2: [Slot] = []
        var slotRow3: [Slot] = []
        for slotArray in slots {
            for var index = 0; index < slotArray.count; index++ {
                let slot = slotArray[index]
                if index == 0 {
                    slotRow.append(slot)
                }
                else if index == 1 {
                    slotRow2.append(slot)
                }
                else if index == 2 {
                    slotRow3.append(slot)
                }
                else {
                    println("Error")
                }
            }
        }
        var slotInRows: [[Slot]] = [slotRow, slotRow2, slotRow3]
        return slotInRows
    }
    
    class func computeWinnings (slots: [[Slot]]) -> Int {
        
        var slotsInRows = unpackSlotsIntoSlotRows(slots)
        var winnings = 0
        var flushWinCount = 0
        var threeOfAKind = 0
        var straightWinCount = 0
        
        for slotRow in slotsInRows {
            if checkFlush(slotRow) == true {
                println("Flush")
                winnings += 1
                flushWinCount += 1
            }
            if checkThreeInARow(slotRow) == true {
                println("Straight")
                winnings += 1
                straightWinCount += 1
            }
            if checkThreeOfAKind(slotRow) == true {
                println("Three of a Kind")
                winnings += 3
                threeOfAKind += 1
            }
            
        }
        
        if flushWinCount == 3 {
            println("Royal Flush")
            winnings += 15
        }
        if straightWinCount == 3 {
            println("Epic Straigh")
            winnings += 1000
        }
        if threeOfAKind == 3 {
            println("3's All Around")
            winnings += 50
        }
        
        return winnings
        
    }
    
    class func checkFlush(slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.isRed == slot2.isRed && slot2.isRed == slot3.isRed {
            return true
        }
        else {
            return false
        }
    }
    
    class func checkThreeOfAKind(slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.value == slot2.value && slot2.value == slot3.value {
            return true
        }
        else {
            return false
        }
    }
    
    class func checkThreeInARow (slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        let value1 = abs(slot1.value - slot2.value)
        let value2 = abs(slot1.value - slot3.value)
        
        if (value1 == 1 && value2 == 2) || (value1 == 2 && value2 == 1) {
            return true
        }
        else if slot1.value == slot2.value + 1 && slot1.value == slot3.value + 2{
            return true
        }
        else {
            return false
        }
    }
}
