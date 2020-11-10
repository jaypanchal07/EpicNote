//
//  FolderViewController.swift
//  EpicNote
//
//  Created by Jay Panchal on 6/12/20.
//  Copyright © 2020 Jay Panchal. All rights reserved.
//

import UIKit
import CoreData

class FolderViewController: UIViewController {
    
    var newFolder: [Folders] = []
    var selectedFolder = Folders()
    
    @IBOutlet weak var lblNoFolder : UILabel!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var lblFolderCount : UILabel!
    @IBOutlet weak var btnNewFolder : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        
    }
    
    @IBAction func btnNewFolder(_ sender: UIButton) {
        sender.pulsate()
        createFolder()
        
    }
    
    func setup(){
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.view.backgroundColor = Colors.lime
        self.navigationItem.titleView?.tintColor = .black
        self.navigationItem.rightBarButtonItem = editButtonItem
        editButtonItem.tintColor = Colors.lightBlue
        
        collectionViewSetup()
        
        btnFolderSetup()
        
        fetchFolderData()
        
        lblFolderCount.text = "\(newFolder.count) Folders"
        lblFolderCount.textColor = .black
        lblFolderCount.addBorder()
    
        navigationController?.navigationBar.prefersLargeTitles = true
        if (newFolder.isEmpty == false){
            collectionView.isHidden = false
            lblNoFolder.isHidden = true
        }
        
    }
    
    func collectionViewSetup(){
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = (view.frame.size.width+20)/3
        layout.itemSize = CGSize(width: width, height: width)
        //collectionView.backgroundView?.setGradientBackground(colorOne: Colors.black, colorTwo: Colors.lightGrey)
        collectionView.backgroundView?.backgroundColor = Colors.lightGrey
    }
    
    func btnFolderSetup(){
        btnNewFolder.circleButton()
        btnNewFolder.backgroundColor = Colors.lightBlue
        btnNewFolder.setImage(UIImage(named: "plus"), for: .normal)
        btnNewFolder.dropShadow(color: Colors.black, opacity: 0.8, offSet: CGSize(width: 0, height: 3), radius: 3.0, scale: true, cornerRadius: 20.0, corners: [.topRight, .topLeft, .bottomLeft, .bottomRight])
    }
    
    //MARK: - Delete Items
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        btnNewFolder.isEnabled = !editing
        if let indexPaths = collectionView?.indexPathsForVisibleItems{
            for indexPath in indexPaths{
                if let cell = collectionView.cellForItem(at: indexPath) as? FolderCollectionViewCell{
                    cell.isEditing = editing
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ListViewController
            else{
                return
        }
        print("SECOND\n\(selectedFolder)")
        destination.folder = selectedFolder
    }


}

// MARK: - Handling TableView

extension FolderViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        newFolder.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "folderCollectCell", for: indexPath) as! FolderCollectionViewCell
        
        cell.lblFolderName.text = newFolder[indexPath.row].name
        cell.lblCount.text = "\(newFolder[indexPath.row].notes!.count) items"
        cell.lblFolderName.textColor = .black
        cell.viewImage.dropShadow2(color: Colors.lime, opacity: 1, offSet: CGSize(width: 1, height: 7), radius: 15.0, scale: false, size: 5, distance: -10, shadowRadius: 3, shadowOpacity: 1)
        //cell.btnDelete.dropShadow(color: Colors.black, opacity: 0.5, offSet: CGSize(width: 1, height: 7), radius: 10, scale: true)
        cell.btnDelete.isHidden = !isEditing
        cell.delegate = self
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFolder = newFolder[indexPath.row]
        
        print(selectedFolder.name)
        performSegue(withIdentifier: "ShowNoteList", sender: self)
    }
    
    
    func createFolder(){
        
        let createFolderAlert = UIAlertController(title: "New Folder", message: "Enter the name for folder", preferredStyle: .alert)
        
        createFolderAlert.addTextField { (textField) in
            textField.placeholder = "Enter folder name"
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .default) { (UIAlertAction) in
            
            self.dismiss(animated: true, completion: nil)
        }
        
        let createFolderAction = UIAlertAction(title: "Create", style: .default) { (action) in
            let textField = createFolderAlert.textFields![0]
            guard let checkText = textField.text, !checkText.isEmpty
                else {
                return
            }
            let newFolder1 = Folders(name: checkText)
            do{
                try newFolder1?.managedObjectContext?.save()
                self.fetchFolderData()
                
                self.collectionView.reloadData()
                if (self.newFolder.isEmpty == false){
                    self.collectionView.isHidden = false
                    self.lblNoFolder.isHidden = true
                }
                self.lblFolderCount.text = "\(self.newFolder.count) Folders"
            }catch{
                print("Could not create/save folder!")
            }
            
        }
        
        
        createFolderAlert.addAction(cancelButton)
        createFolderAlert.addAction(createFolderAction)
        
        self.present(createFolderAlert, animated: true, completion: nil)
        
    }
    
    func fetchFolderData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Folders> = Folders.fetchRequest()
        
        do{
            newFolder = try context.fetch(fetchRequest)
            
        }catch{
            print("No folders were found!")
        }
    }
}

extension FolderViewController: deleteFolderCellDelegate{
    
    func delete(cell: FolderCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell){
            
            let folderDelete = newFolder[indexPath.item]
            guard let managedContext = folderDelete.managedObjectContext else{
                return
            }
            managedContext.delete(folderDelete)
            do{
                try managedContext.save()
            }catch{
                print("could not DELETE!")
            }
            fetchFolderData()
            
            //collectionView?.deleteItems(at: [indexPath])
            collectionView.reloadData()
        }
    }
    
}
