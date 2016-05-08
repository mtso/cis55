//
//  ListTableViewCell.swift
//  ListViewApp_matthewtso
//
//  Created by Matthew Tso on 5/6/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet var cellTitle: UILabel!
    @IBOutlet var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
