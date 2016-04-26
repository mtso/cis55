//: Playground - noun: a place where people can play

import UIKit
import Darwin

var str = "Hello, playground"

var x, y, z : Double

let factor = 0.8

x = pow(17.0, 0.0 + factor)
x = 17.0 * 0.6
y = pow(40.0, 0.0 + factor)
x = 40.0 * 0.6

//print(x, y, z)

//print(UIFontWeightUltraLight)

let fontweights = [UIFontWeightUltraLight, UIFontWeightThin, UIFontWeightLight, UIFontWeightRegular, UIFontWeightMedium, UIFontWeightSemibold, UIFontWeightBold, UIFontWeightHeavy, UIFontWeightBlack]

for weight in fontweights {
    print(weight)
}

let weight = UIFontWeightRegular.advancedBy(-0.2)
print(weight)