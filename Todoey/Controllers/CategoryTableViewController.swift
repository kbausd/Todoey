//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Snarf on 25.08.19.
//  Copyright © 2019 Snarf. All rights reserved.
//

import UIKit
import CoreData


class CategoryTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

    // MARK: - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
        
    }
    
    
    // MARK: - Data Manipulation Methods
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
    }
    
    
    
    
    // MARK: - Add new Categories
    
    @IBAction func addButonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        // Erstelle einen Alertcontroller
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        // Erstellen einen Button für den Alertcontroller
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            // Erzeuge einen neuen Eintrag im Array im Container "DataModel"
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            self.saveCategories()
            self.tableView.reloadData()
        }
        
        // Füge ein Textfeld dem Alertcontroller hinzu
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Ccategory"
            textField = alertTextField
        }
        
        // Füge den konfigurierten alert dem Alertcontroller hinzu
        alert.addAction(action)
        
        // Präsentiere den gesamten Controller
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    // MARK: - TableView Delegate Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        
        // wenn das Optional .indexPathForSelectedRow != nil, dann weise diesen Wert indexPath zu und führe den Codeblock aus
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
}
