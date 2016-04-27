//: Playground - noun: a place where people can play

import UIKit

func formatStringFromDouble(double: Double) -> String {
    
    let numFormatter = NSNumberFormatter()
    
    typealias Abbreviation = (threshold: Double, divisor: Double, suffix: String)

    var abbreviations : [Abbreviation] = [(0.0, 1.0, ""),
        (1000.0, 1000.0, "K"),
        (100_000.0, 1_000_000.0, "M"),
        (100_000_000.0, 1_000_000_000.0, "B"),
        (100_000_000_000.0, 1_000_000_000_000.0, "T"),
        (100_000_000_000_000.0, 1_000_000_000_000_000.0, "Q")
    ]
    
    let calcValue = Double(abs(double))
    
    var correctAbbreviation:Abbreviation = abbreviations[0]
    for testAbbreviation in abbreviations {
        if (calcValue < testAbbreviation.threshold) {
            break
        }
        correctAbbreviation = testAbbreviation
    }
    let abbreviation = correctAbbreviation
    
    let value = double / abbreviation.divisor
    numFormatter.positiveSuffix = abbreviation.suffix
    numFormatter.negativeSuffix = abbreviation.suffix
    numFormatter.allowsFloats = true
    numFormatter.minimumIntegerDigits = 1
    numFormatter.minimumFractionDigits = 1
    numFormatter.maximumFractionDigits = 1
    
    return numFormatter.stringFromNumber(value)!
}

let test = [0.01, 19.1, 133.4, 1243.43, 19203.1, 1314123, 1321432314, 7432432432432, 74324324324321, 743243243243212, 6432432432432432, 8432432432432432432]

test.forEach() {
    print(String($0) + " -> " + formatStringFromDouble($0))
}