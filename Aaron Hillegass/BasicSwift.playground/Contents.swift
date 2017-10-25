//: Playground - noun: a place where people can play

// reference materials - iOS Programming: The Big Nerd Ranch Guide

import UIKit

var str = "Hello, playground"
str = "Hello, Swift"

let constStr = str
 // constStr = "Hello, world" -> error : 'let' keyword is constant. So you can't change the value.

// type inference : The compiler deduces its type by default. -> option + click

var nextYear : Int
var bodyTemp : Float // 32 bit, Double : 64 bit, Float80 : 80 bit
var hasPet : Bool // true or false

// Collections : Array, Dictionary, Set

// Array : A collection of ordered elements.
var arrayOfInts : Array<Int>
var arrayOfInts2 : [Int]

// Dictionary : A collection of unordered key-value pairs.
var dictionaryOfCapitalsByCountry : Dictionary<String,String>
var dictionaryOfCapitalsByCountry2 : [String:String]

// Set : A collection of unordered elements.
var winningLotteryNumbers : Set<Int>

// Number Literal
let number = 42
let fmStation = 91.1

let countingUp = ["one","two"]
let nameByParkingSpace = [13 : "Alice", 27 : "Bob"]

// Subscripting 
let secondElement = countingUp[1]

// Initializer
let emptyString = String()
let emptyArrayOfInts = [Int]()
let emptySetOfFloats = Set<Float>()

// Has default value.
let defaultNumber = Int() // 0
let defaultBool = Bool() // false
let defaultFloat = Float() //0.0

// some Example.
let meaningOfLife = String(number) //"42"
let availableRooms = Set([205,411,412])    //{411,205,412}
let floatFromLiteral = Float(3.14)  // 3.14
let easyPi = 3.14   // Default type is Double
let floatFromDouble = Float(easyPi) // 3.14 -> type of 'floatFromDouble' is Float
let floatingPi : Float = 3.14   // 3.14 -> type of 'floatFromDouble' is Float

// The example of Properties.
countingUp.count    // 2
emptyString.isEmpty // true

// The example of instance methods.
var countingUp2 = ["one","two"]
countingUp2.append("three") // countingUp2 = ["one","two","three"]

// 'Optional' indicates that the variable may not store any value at all.
var reading1 : Float?    // nil
var reading2 : Float?    // nil
var reading3 : Float?    // nil

reading1 = 9.8
reading2 = 9.2
//reading3 = 9.6

// let avgReading = (reading1 + reading2 + reading2) / 3   ->  error : Optional need unwrapping.
// let avgReading = (reading1! + reading2! + reading3!) / 3 -> error : Because the value of reading3 is nil.
// Optional binding
if let r1 = reading1, let r2 = reading2, let r3 = reading3 {
    let avgReading = (r1 + r2 + r3) / 3
} else {
    let errorString = "Instrument reported a reading that was nil"
}

// Subscripting of Dictionary 
let space13Assignee : String? = nameByParkingSpace[13] // "Alice"
let space27Assignee : String? = nameByParkingSpace[27] // "Bob"
let space22Assignee : String? = nameByParkingSpace[22] // nil
if let space29Assignee = nameByParkingSpace[29] {
    print("Key 29 is assigned in the dictionary!")
} else {
    print("Key 29 is not assigned in the dictionary!")
} // -> "Key 29 is not assigned in the dictionary!"

// loop and insert string
let range = 0..<countingUp.count    // range = (0..<2)
for i in range {
    let string = countingUp[i]  // 2times
}

for string in countingUp {
    let value = string // 2times
}

// Tuple
for (i,string) in countingUp.enumerated() {
    //(0,"one"),(1,"two")
    let value2 = string // 2times
}

for (space,name) in nameByParkingSpace {
    let permit = "Space \(space) : \(name)"
}

//Enum : A set of values
enum PieType {
    case Apple
    case Cherry
    case Pecan
}

let name : String
var favoritePie = PieType.Apple

switch favoritePie {
case .Apple : name = "Apple"
case .Cherry : name = "Cherry"
case .Pecan : name = "Pecan"
}
// name = "Apple"

