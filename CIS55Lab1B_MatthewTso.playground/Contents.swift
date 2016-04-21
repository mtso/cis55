// CIS 55
// Lab 1B: Pay Calculator
// Name: Matthew Tso

import UIKit

let numberOfDays = 30
var dailyPay = [142.01],
    totalPay = [0.01]
var formattedDailyPay : [String] = [],
    formattedTotalPay : [String] = []

// Add daily pay and total pay values to arrays.
for day in 0..<numberOfDays {
    dailyPay.append(dailyPay[day]*2)
    totalPay.append(totalPay[day] + dailyPay[day+1])
}

// Use array values to create strings in currency format.
var format = NSNumberFormatter()
format.numberStyle = NSNumberFormatterStyle.CurrencyStyle
for day in 0..<numberOfDays {
    formattedDailyPay.append(format.stringFromNumber(dailyPay[day])!)
    formattedTotalPay.append(format.stringFromNumber(totalPay[day])!)
}

// Left-align strings by adding periods.
let totalMaxCharCount = formattedTotalPay[numberOfDays-1].characters.count
for day in 0..<numberOfDays {
    let dailyTabbing = totalMaxCharCount - formattedDailyPay[day].characters.count
    for tab in 0..<dailyTabbing {
        formattedDailyPay[day] = "." + formattedDailyPay[day]
    }
    let totalTabbing = totalMaxCharCount - formattedTotalPay[day].characters.count
    for tab in 0..<totalTabbing {
        formattedTotalPay[day] = "." + formattedTotalPay[day]
    }
}

// Print formatted output.
for day in 0..<numberOfDays {
    print("––––––––––––––––––––––\n\nPay Day \(day+1):\n")
    print("Daily...\(formattedDailyPay[day])")
    print("Total...\(formattedTotalPay[day])\n")
}
print("––––––––––––––––––––––")
