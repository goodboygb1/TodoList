//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Find poom","Buy flowers","Destroy palm"]
    let defaults = UserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = defaults.array(forKey: "ToDoList") as? [String] {
            itemArray = item
        }
        
    }
    
    //Mark data source methode
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //Mark table view delegate methode
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
           
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        print(itemArray[indexPath.row])
    }
    
    // Mark Add new Item
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textUserPressed = UITextField()
        let alert = UIAlertController(title: "Add New List", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style:.default) { (action) in
           
            self.itemArray.append(textUserPressed.text!)
            self.defaults.set(self.itemArray, forKey: "ToDoList")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (addNewItemTextField) in
            addNewItemTextField.placeholder = "Add Item"
            textUserPressed = addNewItemTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
    }
    
}



 
 

