//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let PI = 3.1415
let radius = 4

var area = PI * Double ( radius * radius )
print(area)

print(area.description)
print("\(area)")

var int1 : Int
var dbl1 : Double
var strX : String
var bool1 : Bool
var char1 : Character


int1 = 1000
int1 = 1_000_000
dbl1 = 1000
dbl1 = 1000.0

strX = "A"
char1 = "A" // <- still a single byte character, but must use double quotes
bool1 = true
bool1 = Bool(1)
bool1 = Bool(-100)

// Tuples -> collection of different types of data
var address = (21250, "Stevens Creek Blvd", "Cupertino", "CA", 95014)


print(address)
print(address.0)

var address2 : (Int, String, String, String, Int)

address2 = address

var address3 = (housenum: 21250, street: "Stevens Creek Blvd", city: "Cupertino", state: "CA", zip: 95014)
print(address3.zip)



var num = 12


if num < 10 {
    print ("number is less than 10")
}


if (num < 10) {
    print ("number is less than 10")
}
else {
    print ("Number is greater than 10")
}


var direction = "up"

switch direction {
    case "up":
    print ("Going up")
    
    case "down":
    print ("Going down")
    
    default:
    print("Going nowhere")
}

// Implicit optional: Check for the type, and for nil

// Explicit optional: I know the type, just check for nil

var j = 0
repeat {
    print(j)
    j++
} while (j < 5)




var n = 0
for n in 1...5 {
    
}
n = 0
for n in -5..<5 {
    print(n)
}

var range = -10..<0
for var k in range {
    
}






















