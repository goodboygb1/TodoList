//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by PMJs on 19/7/2563 BE.
//  Copyright © 2563 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import 



class CategoryTableViewController: SwipeTableViewController {
    
    var category : Results<Category>? // ตาราง category
    let realm = try! Realm()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = category?[indexPath.row].name ?? "No category added yet"
        
        return cell
    }
    
    
    //MARK: - Data Manipulaiton
    
    func loadCategory()  {
        
        category = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    
    func saveCategory(with category : Category)  {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    override func updateModule(at indexPath: IndexPath) {
        if let item = self.category?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(item)
                }
            } catch {
                print("error while deleting \(error)")
            }
        }
    }
        
        
        //MARK: - Add new Category
        
        @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            
            var categoryNameFromUser = UITextField()
            let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
                
                let newCategory = Category()
                newCategory.name = categoryNameFromUser.text!
                
                
                self.saveCategory(with: newCategory)
                
            }
            alert.addTextField { (addCategoryTextField) in
                addCategoryTextField.placeholder = "Add Category"
                categoryNameFromUser = addCategoryTextField
            }
            alert.addAction(action)
            present(alert,animated: true,completion: nil)
            
            
        }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItemSegue", sender: self)
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToItemSegue" {
                let destinationVC = segue.destination as! ToDoListViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = category?[indexPath.row]
                print("set value for prepared")
            }
            
        }
    }
        
   
    }
    
    
    

