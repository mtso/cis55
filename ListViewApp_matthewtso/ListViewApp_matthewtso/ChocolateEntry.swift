//
//  ChocolateEntry.swift
//  ListViewApp_matthewtso
//
//  Created by Matthew Tso on 5/6/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit

class ChocolateEntry: NSObject {
    var name = ""
    var taste = ""
    var imageName = ""
    var origin = ""
//    var percentCacao: Int?
//    var chocolatier: String?
//    var type: Int?
    
    init(name: String, imageName: String, taste: String, origin: String)
    {
        self.name = name
        self.taste = taste
        self.imageName = imageName
        self.origin = origin
    }
}
