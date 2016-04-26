//
//  ViewControllerExtensions.swift
//  StructTest
//
//  Created by Matthew Tso on 4/22/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return payDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MyTableViewCell
        
        cell.dayNumber?.text = "Day " + String(payDataArray[indexPath.row].day)
        
        cell.dailyPay?.attributedText = formatStringFromDouble((payDataArray[indexPath.row].pay), pointSize: 17.0)
        cell.totalPay?.attributedText = formatStringFromDouble((payDataArray[indexPath.row].total), pointSize: 12.0)
        
        return cell
    }
    
    func formatStringFromDouble(double: Double, pointSize: CGFloat) -> NSAttributedString {
        let exponentSize = pointSize * 0.6
        let exponentBaseline = pointSize * 0.5
        let symbolSize = pointSize * 0.8
        let symbolBaseline = (pointSize - symbolSize) * 0.5
        
        let attributedResult = NSMutableAttributedString(string: "$", attributes: [
            NSFontAttributeName: UIFont.systemFontOfSize(symbolSize, weight: UIFontWeightUltraLight),
            NSBaselineOffsetAttributeName: symbolBaseline])
        
        if (double < 100_000_000_000_000_000.0) {
            let numFormatter = NSNumberFormatter()
            
            typealias Suffix = (threshold: Double, divisor: Double, abbreviation: String)
            
            var suffixList : [Suffix] =
                [(0.0, 1.0, ""),
                (1000.0, 1000.0, "K"),
                (100_000.0, 1_000_000.0, "M"),
                (100_000_000.0, 1_000_000_000.0, "B"),
                (100_000_000_000.0, 1_000_000_000_000.0, "T"),
                (100_000_000_000_000.0, 1_000_000_000_000_000.0, "Q")]
            
            var correctSuffix:Suffix = suffixList[0]
            for testSuffix in suffixList {
                if (double < testSuffix.threshold) {
                    break
                }
                correctSuffix = testSuffix
            }
            let suffix = correctSuffix
            
            let value = double / suffix.divisor
            numFormatter.positiveSuffix = suffix.abbreviation
            numFormatter.negativeSuffix = suffix.abbreviation
            numFormatter.allowsFloats = true
            numFormatter.minimumIntegerDigits = 1
            numFormatter.minimumFractionDigits = 1
            numFormatter.maximumFractionDigits = 1
            
            if double < 1000.0 {
                numFormatter.minimumFractionDigits = 2
                numFormatter.minimumSignificantDigits = 1
            }
            
            let formattedNumberWithSuffix = numFormatter.stringFromNumber(value)
            let attributedNumberWithSuffix = NSMutableAttributedString(string: formattedNumberWithSuffix!, attributes: [
                NSFontAttributeName: UIFont.systemFontOfSize(pointSize, weight: UIFontWeightUltraLight),
                ])
            attributedResult.appendAttributedString(attributedNumberWithSuffix)
        } else {
            let snFormat = NSNumberFormatter()
            snFormat.minimumFractionDigits = 1
            snFormat.exponentSymbol = "×"
            snFormat.positiveFormat = "0.0E0" //¤
            
            let exponent = Int(floor(log10(double)))
            let exponentDigitCount = String(exponent).characters.count
            
            let formattedNumber = snFormat.stringFromNumber(double)
            let formattedNumberWithoutExp = formattedNumber?.substringToIndex((formattedNumber?.endIndex.advancedBy(-exponentDigitCount))!)
            
            let attributedNumberSN = NSMutableAttributedString(string: formattedNumberWithoutExp! + "10",
                attributes: [NSFontAttributeName: UIFont.systemFontOfSize(pointSize, weight: UIFontWeightUltraLight)])
            let attributedExponent = NSAttributedString(string: String(exponent), attributes: [
                NSFontAttributeName: UIFont.systemFontOfSize(exponentSize, weight: UIFontWeightUltraLight),
                NSBaselineOffsetAttributeName: exponentBaseline
                ])

            attributedResult.appendAttributedString(attributedNumberSN)
            attributedResult.appendAttributedString(attributedExponent)
        }
        
        return attributedResult
    }
    
}