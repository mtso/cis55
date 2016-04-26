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
        transition.presenting = true
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
    
}

extension DisplayViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfSectionsInTableView section: Int) -> Int {
        return 1
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "DisplayCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DisplayTableViewCell
        
        cell.dayLabel?.attributedText = NSMutableAttributedString(
            string: "Day " + String(dataArray[indexPath.row].day),
            attributes: [ NSFontAttributeName: UIFont.systemFontOfSize(17.0, weight: UIFontWeightRegular)])
        
        let totalString = NSMutableAttributedString(
            string: "Total: ",
            attributes: [ NSFontAttributeName: UIFont.systemFontOfSize(17.0, weight: UIFontWeightRegular),
            ])
        totalString.appendAttributedString(formatCurrencyStringFromDouble((dataArray[indexPath.row].total), pointSize: 17.0))

        cell.totalLabel?.attributedText = totalString
        cell.totalLabel.alpha = 0.4
        
        cell.payLabel?.attributedText = formatCurrencyStringFromDouble((dataArray[indexPath.row].pay), pointSize: 40.0)
        
        return cell
    }
    
    func generateDataArray() {
        
//        startingPay = Double(form!.startingPayField.text!)!
//        numberOfDays = Int(form!.numberOfDaysField.text!)!
        
        dataArray.removeAll()
        dataArray.append(PayDataModel(day: 1, pay: startingPay, total: startingPay))
        
        for index in 2...numberOfDays {
            let today = index
            let indexOfYesterday = today - 2
            let payForToday = dataArray[indexOfYesterday].pay * 2
            let totalPay = dataArray[indexOfYesterday].total + payForToday
            
            dataArray.append(PayDataModel(day: today, pay: payForToday, total: totalPay))
        }
        
        displayTable.reloadData()
        displayTable.setContentOffset(CGPointZero, animated:true)
        
        setupToolbar()
    }

}

var newToolbar = true

extension DisplayViewController {
    
    func setupToolbar() {
        
//        let originalFrame = infoToolbar.frame
//        let tallerFrame = CGRectMake(originalFrame.origin.x, originalFrame.origin.y, originalFrame.width, originalFrame.height + 40.0)
//        infoToolbar.frame = tallerFrame
//        
        let titleSize : CGFloat = 17
        let valueSize : CGFloat = 13
        
        var toolbarItems = infoToolbar.items
        
        let startingPayToolbarView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        startingPayToolbarView.backgroundColor = UIColor.clearColor()
        startingPayToolbarView.clipsToBounds = false
        
        let startingPayTitleToolbarLabel = UILabel(frame: CGRect(x: 0, y: -4, width: 100, height: 30))
        startingPayTitleToolbarLabel.font = UIFont.systemFontOfSize(titleSize)
        startingPayTitleToolbarLabel.backgroundColor = UIColor.clearColor()
        startingPayTitleToolbarLabel.textColor = UIColor.blackColor()
        startingPayTitleToolbarLabel.text = "Starting Pay"
        startingPayTitleToolbarLabel.textAlignment = NSTextAlignment.Center
        
        let startingPayValueToolbarLabel = UILabel(frame: CGRect(x: 0, y: 20, width: 100, height: 20))
        startingPayValueToolbarLabel.font = UIFont.systemFontOfSize(valueSize, weight: UIFontWeightMedium)
        startingPayValueToolbarLabel.backgroundColor = UIColor.clearColor()
        startingPayValueToolbarLabel.alpha = 0.4
        
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        let formattedStartingPay = currencyFormatter.stringFromNumber(startingPay)
        
        startingPayValueToolbarLabel.text = formattedStartingPay
        startingPayValueToolbarLabel.textAlignment = NSTextAlignment.Center
        
        startingPayToolbarView.addSubview(startingPayTitleToolbarLabel)
        startingPayToolbarView.addSubview(startingPayValueToolbarLabel)
        
        
        let dayNumberToolbarView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        dayNumberToolbarView.backgroundColor = UIColor.clearColor()
        dayNumberToolbarView.clipsToBounds = false

        let dayNumberTitleToolbarLabel = UILabel(frame: CGRect(x: 0, y: -4, width: 100, height: 30))
        dayNumberTitleToolbarLabel.font = UIFont.systemFontOfSize(titleSize)
        dayNumberTitleToolbarLabel.backgroundColor = UIColor.clearColor()
        dayNumberTitleToolbarLabel.text = "Days"
        dayNumberTitleToolbarLabel.textColor = UIColor.blackColor()
        dayNumberTitleToolbarLabel.textAlignment = NSTextAlignment.Left
        
        let dayNumberValueToolbarLabel = UILabel(frame: CGRect(x: 0, y: 20, width: 100, height: 20))
        dayNumberValueToolbarLabel.font = UIFont.systemFontOfSize(valueSize, weight: UIFontWeightMedium)
        dayNumberValueToolbarLabel.backgroundColor = UIColor.clearColor()
        dayNumberValueToolbarLabel.alpha = 0.4
        dayNumberValueToolbarLabel.text = String(numberOfDays)
        dayNumberValueToolbarLabel.textAlignment = NSTextAlignment.Left
        
        dayNumberToolbarView.addSubview(dayNumberTitleToolbarLabel)
        dayNumberToolbarView.addSubview(dayNumberValueToolbarLabel)
        
        let startingPayToolbarItem = UIBarButtonItem(customView: startingPayToolbarView)
        let dayNumberToolbarItem = UIBarButtonItem(customView: dayNumberToolbarView)
        
        if newToolbar {
            toolbarItems?.insert(dayNumberToolbarItem, atIndex: 0)
            toolbarItems?.insert(startingPayToolbarItem, atIndex: 2)
            
            let negativeSeparator = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
            negativeSeparator.width = -4
            
            toolbarItems?.insert(negativeSeparator, atIndex: 0)
            toolbarItems?.insert(negativeSeparator, atIndex: toolbarItems!.endIndex)
            newToolbar = false

        } else {
            
            toolbarItems?.removeAtIndex(3)
            toolbarItems?.removeAtIndex(1)
            toolbarItems?.insert(dayNumberToolbarItem, atIndex: 1)
            toolbarItems?.insert(startingPayToolbarItem, atIndex: 3)
            
        }
        
        
        infoToolbar.setItems(toolbarItems, animated: false)
        infoToolbar.clipsToBounds = true
                
        infoToolbar.setNeedsLayout()
    }
    
    func formatCurrencyStringFromDouble(double: Double, pointSize: CGFloat) -> NSAttributedString {
        let exponentSize = pow(pointSize, 0.8)
        let exponentBaseline = pointSize * 0.5
        
        let symbolSize = (1.0 / 23.0) * pointSize + (374.0 / 23.0)
        let symbolBaseline = (pointSize > 30.0) ? (pointSize - (symbolSize * 0.6)) * 0.5 : (pointSize - (symbolSize)) * 0.5
        
        let fontWeight = pointSize > 30.0 ? UIFontWeightThin : UIFontWeightRegular
        var smallFontWeight = pointSize > 30.0 ? UIFontWeightLight : UIFontWeightRegular
        
        let attributedResult = NSMutableAttributedString(string: "$", attributes: [
            NSFontAttributeName: UIFont.systemFontOfSize(symbolSize, weight: smallFontWeight),
            NSBaselineOffsetAttributeName: symbolBaseline])
        
        if (double < 100_000_000_000_000_000.0) {
            let numFormatter = NSNumberFormatter()
            
            typealias Suffix = (threshold: Double, divisor: Double, abbreviation: String)
            
            var suffixList : [Suffix] =
                [(0.0, 1.0, ""),
                (1000.0, 1000.0, "K"),
                (1000_000.0, 1_000_000.0, "M"),
                (1000_000_000.0, 1_000_000_000.0, "B"),
                (1000_000_000_000.0, 1_000_000_000_000.0, "T"),
                (1000_000_000_000_000.0, 1_000_000_000_000_000.0, "Q")]
            
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
            numFormatter.minimumSignificantDigits = 3
            numFormatter.maximumSignificantDigits = 3
            
            if double < 1000.0 {
                numFormatter.minimumFractionDigits = 2
                numFormatter.minimumSignificantDigits = 5
                numFormatter.maximumSignificantDigits = 5
            }
            if double < 100.0 {
                numFormatter.minimumSignificantDigits = 4
                numFormatter.maximumSignificantDigits = 4
            }
            if double < 10.0 {
                numFormatter.maximumSignificantDigits = 3
            }
            if double < 1.0 {
                numFormatter.maximumSignificantDigits = 2
            }
            if double < 0.1 {
                numFormatter.maximumSignificantDigits = 1
            }
            
            let formattedNumberWithSuffix = numFormatter.stringFromNumber(value)
//            formattedNumberWithSuffix = formattedNumberWithSuffix?.stringByReplacingOccurrencesOfString("$", withString: "")
            
            let attributedNumberWithSuffix = NSMutableAttributedString(string: formattedNumberWithSuffix!, attributes: [
                NSFontAttributeName: UIFont.systemFontOfSize(pointSize, weight: fontWeight),
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
                attributes: [NSFontAttributeName: UIFont.systemFontOfSize(pointSize, weight: fontWeight)])
            
            smallFontWeight = (pointSize > 30) ? smallFontWeight : smallFontWeight.advancedBy(0.3)
            
            let attributedExponent = NSAttributedString(string: String(exponent), attributes: [
                NSFontAttributeName: UIFont.systemFontOfSize(exponentSize, weight: smallFontWeight),
                NSBaselineOffsetAttributeName: exponentBaseline
                ])
            
            attributedResult.appendAttributedString(attributedNumberSN)
            attributedResult.appendAttributedString(attributedExponent)
        }
        
        return attributedResult
    }
}

