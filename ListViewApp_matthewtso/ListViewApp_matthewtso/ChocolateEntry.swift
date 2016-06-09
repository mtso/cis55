//
//  ChocolateEntry.swift
//  ListViewApp_matthewtso
//
//  Created by Matthew Tso on 5/6/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit
import CoreData

class ChocolateEntry: NSManagedObject {
    @NSManaged var name: String!
    @NSManaged var imageName: String!
    @NSManaged var taste: String!
    @NSManaged var origin: String!
    @NSManaged var percentCacao: NSNumber!
}