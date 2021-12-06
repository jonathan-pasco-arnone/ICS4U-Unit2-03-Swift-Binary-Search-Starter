//
//  Created by Jonathan Pasco-Arnone
//  Created on 2021-11-30
//  Version 1.0
//  Copyright (c) 2021 MTHS. All rights reserved.
//
//  This program calculates the amount of time to reheat a
//  specific quantity of a specific type of food.

import Foundation

// Making an error case.
enum MyError: Error {
    case invalidInteger(String)
}

func binarySearch(userArray: [Int], userNumber: Int, lowIndex: Int, highIndex: Int) -> Int {
    // Variables
    var newLowIndex: Int = lowIndex
    var newHighIndex: Int = highIndex
    // Constants
    let returnValue: Int
    let meanCeil: Int = Int(ceil(Double(newLowIndex + newHighIndex) / 2))
    let meanFloor: Int = Int(floor(Double(newLowIndex + newHighIndex) / 2))

    if userNumber == userArray[meanCeil] {
        returnValue = meanCeil
    } else if newLowIndex == newHighIndex {
        returnValue = -1
    } else if userNumber > userArray[meanCeil] {
        newLowIndex = meanCeil
        returnValue = binarySearch(userArray: userArray, userNumber: userNumber,
            lowIndex: newLowIndex, highIndex: newHighIndex)
    } else {
        newHighIndex = meanFloor
        returnValue = binarySearch(userArray: userArray, userNumber: userNumber,
            lowIndex: newLowIndex, highIndex: newHighIndex)
    }
    return returnValue
}

// Variables/Constants
let min: Int = 0
let max: Int = 999
let arraySize: Int = 100
var searchNumber: Int = 0

print("Binary Search Program")
do {

    // Make the array and sort it
    var randomNumberArray: [Int] = []
    for _ in 0..<arraySize {
        let randomNumber = Int.random(in: 1...100)
        randomNumberArray.append(randomNumber)
    }
    randomNumberArray.sort()
    print("\nSorted list of numbers:\n")
    for counter in 0..<arraySize {
        print(randomNumberArray[counter])
    }

    // Ask for number to be checked
    print("What number are you searching for in",
        " the array")
    if let numberInput: Int = Int(readLine()!) {
        searchNumber = numberInput
    } else {
        throw MyError.invalidInteger("Error")
    }

    if searchNumber > max || searchNumber < min {
        throw MyError.invalidInteger("Error")
    } else {
        /*
        * Using binary search to find the user's chosen number
        * in the array
        */
        let searchResult = binarySearch(userArray: randomNumberArray,
            userNumber: searchNumber, lowIndex: min, highIndex: randomNumberArray.count - 1)
        if searchResult == -1 {
           throw MyError.invalidInteger("Error")
        } else {
           print("\n", "Your number is in index: ", searchResult)
        }
    }

} catch {
    print("That was an invalid input")
}
