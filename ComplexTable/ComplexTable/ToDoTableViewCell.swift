//
//  ToDoTableViewCell.swift
//  ComplexTable
//
//  Created by Matthew Tso on 4/21/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var cellItemName: UILabel!
    @IBOutlet var cellItemType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
