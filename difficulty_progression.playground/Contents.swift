//: Playground - noun: a place where people can play

import UIKit


let distances = [1.0, 2000.0, 10000.0, 1000000.0, 1000000000.0]

for distance in distances {
    let difficulty = -1.0 * pow(0.9997, distance) + 1.0
    print(difficulty)
}

















