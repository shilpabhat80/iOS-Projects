//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by Shilpa Bhat on 12/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var itemList:[NSManagedObject]? = [NSManagedObject]()
    
    var appDelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?
    var canEdit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        load()
        
        self.tableView.reloadData()
    }
    

    @IBAction func saveToDoItemDetail(segue:UIStoryboardSegue) {
        if segue.identifier == "saveItem" {
            if let itemDetailViewController = segue.source as? ToDoListItemDetailViewController {
                
                //add the new player to the players array
                if let item = itemDetailViewController.name {
                    
                    if canEdit {
                        update(name: item, atIndex: (tableView.indexPathForSelectedRow?.row)!)
                        canEdit = false
                    } else {
                        save(name: item)
                    }
                }
            }
        }
    }
    
   
}

// MARK: save/load data using core data
extension ToDoListViewController
{
    func entityName() -> String? {
        return "ToDoListItem"
    }
    
    func load() {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName()!)
        
        do {
            itemList = try managedContext?.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func save(name nameToSave:String){
        
        if let myManagedContext = managedContext {
            
            let entity = NSEntityDescription.entity(forEntityName: entityName()!, in: myManagedContext)!
            let item = NSManagedObject(entity: entity, insertInto: myManagedContext)
            item.setValue(nameToSave, forKeyPath: "item")
            
            appDelegate?.saveContext()
        }
    }
    
    func update(name nameToSave:String, atIndex index:Int){
        
        let item = itemList?[index]
        item?.setValue(nameToSave, forKeyPath: "item")
        
        appDelegate?.saveContext()
    }
}

// MARK: save/load data using core data
extension ToDoListViewController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        
        let item = itemList?[indexPath.row]
        cell.textLabel?.lineBreakMode = .byTruncatingTail
        cell.textLabel?.text = item?.value(forKey: "item") as? String
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let item = itemList?[indexPath.row]
            managedContext?.delete(item!)
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.saveContext()
            
            load()
            self.tableView.reloadData()
        }
    }
}

// MARK: segue methods
extension ToDoListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "UpdateItem" {
            let navigationController = segue.destination as? UINavigationController
            if let itemDetailViewController = navigationController?.topViewController as?  ToDoListItemDetailViewController {
                canEdit = true
                if let item = itemList?[(tableView.indexPathForSelectedRow?.row)!] {
                    itemDetailViewController.name = item.value(forKey: "item") as? String
                }
            }
        }
    }

}
