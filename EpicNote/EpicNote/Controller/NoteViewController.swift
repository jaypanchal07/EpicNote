//
//  NoteViewController.swift
//  EpicNote
//
//  Created by Jay Panchal on 6/8/20.
//  Copyright © 2020 Jay Panchal. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak var txtNoteField: UITextView!
    @IBOutlet weak var txtNoteTitle: UITextField!
    
    var folder : Folders?
    
    //public var completion: ((String,String)-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    func setup(){
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.barTintColor = Colors.lime
        self.view.setGradientBackground(colorOne: Colors.lightLime, colorTwo: Colors.lightLimePlus)
        self.navigationItem.titleView?.tintColor = .black
        
        txtNoteField.customRadius(a: 0.2)
        txtNoteTitle.customRadius(a: 0.2)
        
        txtNoteTitle.backgroundColor = Colors.lightLimePlus
        txtNoteField.backgroundColor = Colors.lightLimePlus
        txtNoteTitle.textColor = Colors.black
        txtNoteField.textColor = Colors.black
        
        txtNoteTitle.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [NSAttributedString.Key.foregroundColor: Colors.lightDarkGrey])
        
        print(folder?.name)
        navigationItem.largeTitleDisplayMode = .never
        txtNoteTitle.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
    
    @objc func didTapSave(){
        guard let textTitle = txtNoteTitle.text, let textNote = txtNoteField.text else{
            return
        }
        
        
        if let newNote = Notes(title: textTitle, note: textNote){
            print("note controller!: \(newNote.title ?? "no value found!")")
            folder?.addToContainNotes(newNote)
        
            do{
                try newNote.managedObjectContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            }catch{
                print("could not save New Note")
            }
        }
//        if let text = txtNoteTitle.text, !text.isEmpty,  !txtNoteField.text.isEmpty{
//            completion?(text, txtNoteField.text)
//        }
    }

}
