//
//  Folders+CoreDataClass.swift
//  EpicNote
//
//  Created by Jay Panchal on 6/17/20.
//  Copyright © 2020 Jay Panchal. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Folders)
public class Folders: NSManagedObject {
    var notes: [Notes]?{
        return self.containNotes?.array as? [Notes]
    }
    convenience init?(name: String){
        let appdelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appdelegate?.persistentContainer.viewContext else {
            return nil
        }
        self.init(entity: Folders.entity(),insertInto: context)
        
        self.name = name
    }
}
