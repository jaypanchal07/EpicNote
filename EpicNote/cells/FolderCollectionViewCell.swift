//
//  FolderCollectionViewCell.swift
//  EpicNote
//
//  Created by Jay Panchal on 6/24/20.
//  Copyright © 2020 Jay Panchal. All rights reserved.
//

import UIKit

protocol deleteFolderCellDelegate: class {
    func delete(cell: FolderCollectionViewCell)
}

class FolderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblFolderName : UILabel!
    @IBOutlet weak var viewImage : UIImageView!
    @IBOutlet weak var lblCount : UILabel!
    @IBOutlet weak var btnDelete : UIButton!

    weak var delegate: deleteFolderCellDelegate?
    
    var isEditing: Bool = false{
        didSet{
            btnDelete.isHidden = !isEditing
        }
    }
    
    @IBAction func didTapDelete(_ sender: UIButton){
        delegate?.delete(cell: self)
    }
    
}
