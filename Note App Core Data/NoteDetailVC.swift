//
//  ViewController.swift
//  Note App Core Data
//
//

import UIKit
import CoreData

class NoteDetailVC: UIViewController {
    
    
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var selectedNote : Note? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (selectedNote != nil) {
            titleTextField.text = selectedNote?.title
            descriptionTextField.text = selectedNote?.desc
            
                }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)

    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            
            if selectedNote == nil {
                
                let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
                let newNote = Note(entity: entity!, insertInto: context)
                
                newNote.id = noteList.count as NSNumber
                newNote.title = titleTextField.text
                newNote.desc = descriptionTextField.text
                
                do {
                    try context.save()
                    noteList.append(newNote)
                    navigationController?.popViewController(animated: true)
                } catch {
                    print("Yeni not eklenirken hata oluştu")
                }
            } else {
                
                selectedNote?.title = titleTextField.text
                selectedNote?.desc = descriptionTextField.text
                
                do {
                    try context.save()
                    navigationController?.popViewController(animated: true)
                } catch {
                    print("Not güncellenirken hata oluştu")
                }
            }
        }
    
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            
            if let noteToDelete = selectedNote {
                noteToDelete.deletedDate = Date()
                do {
                    try context.save()
                    navigationController?.popViewController(animated: true)
                } catch {
                    print("Silme sırasında hata oluştu")
                }
            }
        }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
}

