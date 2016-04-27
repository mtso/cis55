//
//  ViewControllerExtension.swift
//  CIS55Lab1C_MatthewTso
//
//  Created by Matthew Tso on 4/23/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

extension DisplayViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // Set the presenting property to true on presentation of the form view.
        transition.presenting = true
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // Set the presenting property to false on dismissal of the form view .
        transition.presenting = false
        return transition
    }
    
}

extension DisplayViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfSectionsInTableView section: Int) -> Int {
        // There's only one section.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "DisplayCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DisplayTableViewCell
        
        // Set the attributed text of the day label using the day integer from the data array.
        cell.dayLabel?.attributedText = NSMutableAttributedString(
            string: "Day " + String(dataArray[indexPath.row].day),
            attributes: [ NSFontAttributeName: UIFont.systemFontOfSize(17.0, weight: UIFontWeightRegular)])
        
        // Set the attributed text of the pay label using custom function.
        cell.payLabel?.attributedText = formatCurrencyStringFromDouble((dataArray[indexPath.row].pay), pointSize: 40.0)

        
        // Create the total pay text in two parts.
        // - First, create a mutable attributed string with the title.
        let totalString = NSMutableAttributedString(
            string: "Total: ",
            attributes: [ NSFontAttributeName: UIFont.systemFontOfSize(17.0, weight: UIFontWeightRegular)])
        
        // - Second, append the attributed string returned from the custom function.
        totalString.appendAttributedString(formatCurrencyStringFromDouble((dataArray[indexPath.row].total), pointSize: 17.0))
        
        // Set the attributed text of the total label to the created totalString.
        cell.totalLabel?.attributedText = totalString
        
        // Set alpha of the label to lower visual hierarchy.
        cell.totalLabel.alpha = 0.4
        
        return cell
    }
    
}

extension DisplayViewController {
    
    // setupToolbar and formatCurrencyStringFromDouble are too long of functions to include in the main view controller file.
    
    func setupToolbar() {
        // Set the title and value size that will be used for the Starting Pay and Day count bar button items.
        let titleSize : CGFloat = 17.0
        let valueSize : CGFloat = 13.0
        
        // Create an array of the current UIToolbar items.
        var toolbarItems = infoToolbar.items
        
        // Create a UIView that will hold the title and value label for the starting pay information.
        let startingPayToolbarView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        startingPayToolbarView.backgroundColor = UIColor.clearColor()
        startingPayToolbarView.clipsToBounds = false

        // Create and format the Starting Pay title label.
        let startingPayTitleToolbarLabel = UILabel(frame: CGRect(x: 0, y: -4, width: 100, height: 30))
        startingPayTitleToolbarLabel.font = UIFont.systemFontOfSize(titleSize)
        startingPayTitleToolbarLabel.backgroundColor = UIColor.clearColor()
        startingPayTitleToolbarLabel.textColor = UIColor.blackColor()
        startingPayTitleToolbarLabel.text = "Starting Pay"
        startingPayTitleToolbarLabel.textAlignment = NSTextAlignment.Center
        
        // Create and format the Starting Pay value label based on the current startingPay value.
        let startingPayValueToolbarLabel = UILabel(frame: CGRect(x: 0, y: 20, width: 100, height: 20))
        startingPayValueToolbarLabel.font = UIFont.systemFontOfSize(valueSize, weight: UIFontWeightMedium)
        startingPayValueToolbarLabel.backgroundColor = UIColor.clearColor()
        startingPayValueToolbarLabel.alpha = 0.4
        // Use the currency style of the number formatter.
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        let formattedStartingPay = currencyFormatter.stringFromNumber(startingPay)
        startingPayValueToolbarLabel.text = formattedStartingPay
        startingPayValueToolbarLabel.textAlignment = NSTextAlignment.Center
        
        // Add the Starting Pay title and value labels to the UIView.
        startingPayToolbarView.addSubview(startingPayTitleToolbarLabel)
        startingPayToolbarView.addSubview(startingPayValueToolbarLabel)
        
        // Create a UIView that will hold the title and value label for the Day Count.
        let dayNumberToolbarView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        dayNumberToolbarView.backgroundColor = UIColor.clearColor()
        dayNumberToolbarView.clipsToBounds = false
        
        // Create and format the Day count title label.
        let dayNumberTitleToolbarLabel = UILabel(frame: CGRect(x: 0, y: -4, width: 100, height: 30))
        dayNumberTitleToolbarLabel.font = UIFont.systemFontOfSize(titleSize)
        dayNumberTitleToolbarLabel.backgroundColor = UIColor.clearColor()
        dayNumberTitleToolbarLabel.text = "Days"
        dayNumberTitleToolbarLabel.textColor = UIColor.blackColor()
        dayNumberTitleToolbarLabel.textAlignment = NSTextAlignment.Left
        
        // Create and format the number of days value label based on the current day count.
        let dayNumberValueToolbarLabel = UILabel(frame: CGRect(x: 0, y: 20, width: 100, height: 20))
        dayNumberValueToolbarLabel.font = UIFont.systemFontOfSize(valueSize, weight: UIFontWeightMedium)
        dayNumberValueToolbarLabel.backgroundColor = UIColor.clearColor()
        dayNumberValueToolbarLabel.alpha = 0.4
        dayNumberValueToolbarLabel.text = String(numberOfDays)
        dayNumberValueToolbarLabel.textAlignment = NSTextAlignment.Left
        
        // Add the Day count title and value label to the UIView.
        dayNumberToolbarView.addSubview(dayNumberTitleToolbarLabel)
        dayNumberToolbarView.addSubview(dayNumberValueToolbarLabel)
        
        // Create UIToolbar items to display Starting Pay and Day count info using the custom views.
        let startingPayToolbarItem = UIBarButtonItem(customView: startingPayToolbarView)
        let dayNumberToolbarItem = UIBarButtonItem(customView: dayNumberToolbarView)
        
        if newToolbar {
            // Insert the Day count bar button item in front of the first flexible space bar button item.
            toolbarItems?.insert(dayNumberToolbarItem, atIndex: 0)
            
            // Insert the Starting Pay bar button item in between the two flexible space bar button items.
            toolbarItems?.insert(startingPayToolbarItem, atIndex: 2)
            
            // Correct the padding spacing by inserting negative-width fixed space bar button items at the beginning and end.
            let negativeSeparator = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
            negativeSeparator.width = -4
            toolbarItems?.insert(negativeSeparator, atIndex: 0)
            toolbarItems?.insert(negativeSeparator, atIndex: toolbarItems!.endIndex)
            
            // Clip the toolbar view to its bounds to hide the ugly line between the toolbar and status bar.
            infoToolbar.clipsToBounds = true

            // Set bool to false to skip the initial toolbar setup on the next toolbar update.
            newToolbar = false
        } else {
            // Remove the previous Starting Pay and Day count bar button items.
            toolbarItems?.removeAtIndex(3)
            toolbarItems?.removeAtIndex(1)
            
            // Insert the new Starting Pay and Day count bar button items.
            toolbarItems?.insert(dayNumberToolbarItem, atIndex: 1)
            toolbarItems?.insert(startingPayToolbarItem, atIndex: 3)
        }
        
        // Give the UIToolbar the new array of created toolbar items.
        infoToolbar.setItems(toolbarItems, animated: false)
        
        // Update the UIToolbar.
        infoToolbar.setNeedsLayout()
    }
    
    func formatCurrencyStringFromDouble(double: Double, pointSize: CGFloat) -> NSAttributedString {
        // Do some hardcore formatting on the received double and return an attributed string with the custom formatting.
        
        // Set the sizes of the exponent and symbol based off the received point size.
        let exponentSize = pow(pointSize, 0.8)
        let exponentBaseline = pointSize * 0.5
        
        let symbolSize = (1.0 / 23.0) * pointSize + (374.0 / 23.0)
        let symbolBaseline = (pointSize > 30.0) ? (pointSize - (symbolSize * 0.6)) * 0.5 : (pointSize - (symbolSize)) * 0.5
        
        // Have smaller sizes display a heavier weight for legibility.
        let fontWeight = pointSize > 30.0 ? UIFontWeightThin : UIFontWeightRegular
        
        // Set the exponent and symbol font weights to be even heavier so that the weights appear equal with the larger characters.
        var smallFontWeight = pointSize > 30.0 ? UIFontWeightLight : UIFontWeightRegular
        
        
        // Create a mutable string with a single dollar sign for other sections of the number to append to.
        let attributedResult = NSMutableAttributedString(string: "$", attributes: [
            NSFontAttributeName: UIFont.systemFontOfSize(symbolSize, weight: smallFontWeight),
            NSBaselineOffsetAttributeName: symbolBaseline])
        
        // If the number is less than one hundred quadrillion, it will have a suffix abbreviation (and no exponent).
        if (double < 100_000_000_000_000_000.0) {
            
            // Create a typealias to hold the suffix properties.
            typealias Suffix = (threshold: Double, divisor: Double, abbreviation: String)
            var suffixList : [Suffix] =
                [(0.0, 1.0, ""),
                (1000.0, 1000.0, "K"),
                (1000_000.0, 1_000_000.0, "M"),
                (1000_000_000.0, 1_000_000_000.0, "B"),
                (1000_000_000_000.0, 1_000_000_000_000.0, "T"),
                (1000_000_000_000_000.0, 1_000_000_000_000_000.0, "Q")]
            
            // Find the correct suffix for the received double.
            var correctSuffix:Suffix = suffixList[0]
            for testSuffix in suffixList {
                if (double < testSuffix.threshold) {
                    break
                }
                correctSuffix = testSuffix
            }
            let suffix = correctSuffix
            
            // Create a number formatter using the suffix.
            let numFormatter = NSNumberFormatter()
            numFormatter.positiveSuffix = suffix.abbreviation
            
            // Set the digit properties for numbers above 1000.
            numFormatter.minimumFractionDigits = 1
            numFormatter.maximumFractionDigits = 1
            numFormatter.minimumSignificantDigits = 3
            numFormatter.maximumSignificantDigits = 3
            
            // Up to 1000, display the number like currency (but without the symbol).
            switch double {
            case 0..<0.1:
                numFormatter.maximumSignificantDigits = 1
            case 0.1..<1.0:
                numFormatter.maximumSignificantDigits = 2
            case 1.0..<10.0:
                numFormatter.maximumSignificantDigits = 3
            case 10.0..<100.0:
                numFormatter.minimumSignificantDigits = 4
                numFormatter.maximumSignificantDigits = 4
            case 100.0..<1000.0:
                numFormatter.minimumSignificantDigits = 5
                numFormatter.maximumSignificantDigits = 5
            default:
                break
            }
            
            // Divide the double by the divisor to get the decimal in the proper place.
            let value = double / suffix.divisor
            let formattedNumberWithSuffix = numFormatter.stringFromNumber(value)
            
            // Create the attributed string from the formatted number.
            let attributedNumberWithSuffix = NSMutableAttributedString(string: formattedNumberWithSuffix!, attributes: [
                NSFontAttributeName: UIFont.systemFontOfSize(pointSize, weight: fontWeight),
                ])
            
            // Append the attributed string number to the result.
            attributedResult.appendAttributedString(attributedNumberWithSuffix)
        } else {
            // Create a scientific notation style number formatter.
            let snFormat = NSNumberFormatter()
            snFormat.minimumFractionDigits = 1
            snFormat.exponentSymbol = "×"
            snFormat.positiveFormat = "0.0E0"
            
            // Format the number in scientific notation.
            let formattedNumber = snFormat.stringFromNumber(double)
            
            // Get the exponent value.
            let exponent = Int(floor(log10(double)))
            
            // Delete the exponent numbers from the formatted string.
            let exponentDigitCount = String(exponent).characters.count
            let formattedNumberWithoutExp = formattedNumber?.substringToIndex((formattedNumber?.endIndex.advancedBy(-exponentDigitCount))!)
            
            // Create an attributed string using the scientific notation format.
            let attributedNumberSN = NSMutableAttributedString(string: formattedNumberWithoutExp! + "10",
                attributes: [NSFontAttributeName: UIFont.systemFontOfSize(pointSize, weight: fontWeight)])
            
            // Increase the small font weight even further to increase legibility.
            smallFontWeight = (pointSize > 30) ? smallFontWeight : smallFontWeight.advancedBy(0.3)
            
            // Create an attributed string using the exponent number.
            let attributedExponent = NSAttributedString(string: String(exponent), attributes: [
                NSFontAttributeName: UIFont.systemFontOfSize(exponentSize, weight: smallFontWeight),
                NSBaselineOffsetAttributeName: exponentBaseline
                ])
            
            // Append the scientific notation section and then the exponent after it.
            attributedResult.appendAttributedString(attributedNumberSN)
            attributedResult.appendAttributedString(attributedExponent)
        }
        
        // Return the completed result.
        return attributedResult
    }
}

