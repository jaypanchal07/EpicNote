//
//  Notes+CoreDataClass.swift
//  EpicNote
//
//  Created by Jay Panchal on 6/17/20.
//  Copyright © 2020 Jay Panchal. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Notes)
public class Notes: NSManagedObject {
    convenience init?(title: String, note: String){
        let appdelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appdelegate?.persistentContainer.viewContext
            else{
                return nil
        }
        self.init(entity: Notes.entity(),insertInto: context)
        
        self.title = title
        self.note = note
    }
}
