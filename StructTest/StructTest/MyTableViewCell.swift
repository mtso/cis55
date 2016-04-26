//
//  MyTableViewCell.swift
//  StructTest
//
//  Created by Matthew Tso on 4/22/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet var dayNumber: UILabel!
    @IBOutlet var dailyPay: UILabel!
    @IBOutlet var totalPay: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        var fontData = FontData()
//        
//        if (fontData.dailyPayFontSize == nil) {
//            fontData.dailyPayFontSize = dailyPay.font.pointSize
//        }
//        if (fontData.dailyPayFontSize == nil) {
//            fontData.dailyPayFontSize = dailyPay.font.pointSize
//        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
