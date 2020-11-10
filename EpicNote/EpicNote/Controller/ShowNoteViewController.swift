//
//  ShowNoteViewController.swift
//  EpicNote
//
//  Created by Jay Panchal on 6/12/20.
//  Copyright © 2020 Jay Panchal. All rights reserved.
//

import UIKit

class ShowNoteViewController: UIViewController {

    var noteToUpdate : Notes?
    var indexPath : IndexPath?
    var folder : Folders?
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtTextInput: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setup()
        
    }
    @IBAction func btnSave(_ sender: UIButton) {
        
//        guard let title = txtTitle.text, let text = txtTextInput.text else{return}
//            noteToUpdate?.title = title
//            noteToUpdate?.note = text
        updateCoreData()
        
    }
    
    func setup(){
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.barTintColor = Colors.lime
        self.view.setGradientBackground(colorOne: Colors.lightLime, colorTwo: Colors.lightLimePlus)
        self.navigationItem.titleView?.tintColor = .black
        
        txtTitle.text = noteToUpdate?.title
        txtTextInput.text = noteToUpdate?.note
        
        txtTitle.backgroundColor = Colors.lightLimePlus
        txtTextInput.backgroundColor = Colors.lightLimePlus
        txtTitle.textColor = Colors.black
        txtTextInput.textColor = Colors.black
        
        txtTitle.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [NSAttributedString.Key.foregroundColor: Colors.lightDarkGrey])
        
        
        txtTitle.customRadius(a: 0.2)
        txtTextInput.customRadius(a: 0.2)
    }
    func updateCoreData(){
        
        let updateNote = folder?.notes![indexPath!.item]

        guard let managedContext = updateNote?.managedObjectContext else{
            return
        }


        updateNote?.title = txtTitle.text
        updateNote?.note = txtTextInput.text
        print("ShowNoteController : \(updateNote?.title) :\n \(updateNote?.note)")
        folder?.addToContainNotes(updateNote!)
    
        do{
            try updateNote?.managedObjectContext?.save()
            
            self.navigationController?.popViewController(animated: true)
        }catch{
            print("could not save New Note")
        }
        
    }
    
    

}
