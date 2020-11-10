//
//  NoteListCollectionViewCell.swift
//  EpicNote
//
//  Created by Jay Panchal on 7/6/20.
//  Copyright © 2020 Jay Panchal. All rights reserved.
//

import UIKit

class NoteListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblNoteTitle: UILabel!
    @IBOutlet weak var lblNoteBody: UILabel!
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
}
