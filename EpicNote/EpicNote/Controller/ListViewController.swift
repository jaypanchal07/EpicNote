//
//  ViewController.swift
//  EpicNote
//
//  Created by Jay Panchal on 6/8/20.
//  Copyright © 2020 Jay Panchal. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var lblDefault : UILabel!
    @IBOutlet weak var lblCountBottom : UILabel!
    
    @IBOutlet weak var btnNewNote : UIButton!
    
    var folder : Folders?
    var note : [Notes]?
    var noteToUpdate : Notes?
    
   // var models : [(title: String, note: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if (folder?.notes?.isEmpty == false){
            tableView.isHidden = false
        }
        tableView.reloadData()
    }
    
    func setup(){
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.view.backgroundColor = Colors.lightGrey
        self.navigationItem.titleView?.tintColor = .black
        
        
        print(folder?.name)
        title = "Notes"
        
        btnFolderSetup()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Colors.white
        
        
        decideTableBeHiddenOrNot()
    }
    
    func btnFolderSetup(){
        btnNewNote.circleButton()
        
        btnNewNote.backgroundColor = Colors.lightBlue
        btnNewNote.setImage(UIImage(named: "plus"), for: .normal)
        btnNewNote.dropShadow(color: .black, opacity: 0.8, offSet: CGSize(width: 0, height: 3), radius: 3.0, scale: true, cornerRadius: 20.0, corners: [.topRight, .topLeft, .bottomLeft, .bottomRight])
        //btnNewNote.setGradientBackground(colorOne: Colors.blue, colorTwo: Colors.lightBlue)
    }
    
    
    
    @IBAction func btnNewNote(_ sender: UIButton){
        
        sender.pulsate()
        performSegue(withIdentifier: "NewNote", sender: self)

        
//        guard let vc = storyboard?.instantiateViewController(identifier: "NewNote") as? NoteViewController else {return}
//        vc.title = "New Note"
//        vc.navigationItem.largeTitleDisplayMode = .never
//        vc.completion = {noteTitle, note in
//            self.navigationController?.popToRootViewController(animated: true)
//            self.models.append((noteTitle, note))
//            self.lblDefault.isHidden = true
//            self.tableView.isHidden = false
//            self.tableView.reloadData()
//        }
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupTitle(){
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func decideTableBeHiddenOrNot(){
        if (folder?.notes?.isEmpty == false){
            tableView.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowNote"{
            
            guard let destination = segue.destination as? ShowNoteViewController else{
                return
            }
            destination.noteToUpdate = self.noteToUpdate
            destination.indexPath = self.tableView.indexPathForSelectedRow
            destination.folder = folder
            
        }else if segue.identifier == "NewNote"{
            
            guard let destination = segue.destination as? NoteViewController else {
                return
            }
            destination.folder = folder
        
        }
        
    }
}
    
//Mark:- Tableview control

extension ListViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return folder?.notes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteListTableViewCell
        cell.backgroundColor = Colors.lightGrey
        
        if let note = folder?.notes?[indexPath.row]{
            cell.lblNoteTitle?.text = note.title
            cell.lblNoteTitle.textColor = Colors.black
            
            cell.lblNoteBody?.text = note.note
            cell.lblNoteBody.textColor = Colors.darkGrey
            
            lblCountBottom.text = "\(folder?.notes?.count ?? 0) Notes"
            
        }
        cell.noteView.setGradientBackground(colorOne: Colors.lightLimePlus, colorTwo: Colors.lightDarkGrey)
        
        //cell.noteView.backgroundColor = Colors.white
        //cell.noteView.addBorder()
//        cell.noteView.dropShadow2(color: Colors.black, opacity: 1, offSet: CGSize(width: 1, height: 2), radius: 1, scale: false, size: 5, distance: -3, shadowRadius: 2, shadowOpacity: 0.5)
        cell.shadowView.dropShadow2(color: Colors.black, opacity: 1, offSet: CGSize(width: 1, height: 2), radius: 1, scale: false, size: 5, distance: -3, shadowRadius: 2, shadowOpacity: 0.5)
        
        cell.noteView.layer.cornerRadius = 10
        cell.noteView.clipsToBounds = true
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = Colors.lightLime
                cell.selectedBackgroundView = backgroundView
        //cell.selectionStyle = .none

        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let deleteNote = folder?.notes![indexPath.item]{
                
                deleteFromNotesCoreData(deleteNote: deleteNote)
                
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            lblCountBottom.text = "\(String(describing: folder?.notes?.count)) Notes"
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        noteToUpdate = folder?.notes![indexPath.row]
        performSegue(withIdentifier: "ShowNote", sender: self)
    //        tableView.deselectRow(at: indexPath, animated: true)
    //
    //        //Show NoteViewController
    //        guard let vc = storyboard?.instantiateViewController(identifier: "Note") as? NoteViewController else {
    //            return
    //        }
    //        vc.navigationItem.largeTitleDisplayMode = .never
    //        vc.title = "Note"
    //        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row >= 0{
            return 80
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            //animation
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -100, 0, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.0
        
        UIView.animate(withDuration: 0.7, delay: 0.2,options: .curveEaseOut, animations: {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        })
        
    }
    
    func deleteFromNotesCoreData(deleteNote: Notes){
        
        guard let managedContext = deleteNote.managedObjectContext else{
            return
        }
        managedContext.delete(deleteNote)
        do{
            try managedContext.save()
        }catch{
            print("could not DELETE!")
        }
        //fetchFolderData()
        
        //collectionView?.deleteItems(at: [indexPath])
        
        //tableView.reloadData()
    }
}

