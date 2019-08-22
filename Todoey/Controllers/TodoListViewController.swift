//
//  ViewController.swift
//  Todoey
//
//  Created by Snarf on 20.08.19.
//  Copyright © 2019 Snarf. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    // Erzeuge ein Array mit Objekten der Klasse Item
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Apples"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Do Nothing"
        itemArray.append(newItem3)
        

        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
        
    }

    
    //MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        // Ternary Operator
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    

    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
 
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    


    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        // Erstelle einen Alertcontroller
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // Erstellen einen Button für den Alertcontroller
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen if user clicks the Add Item button on the alert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
        // Für ein Textfeld dem Alertcontroller hinzu
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField

        }
        
        // Füge den konfigurierten alert dem Alertcontroller hinzu
        alert.addAction(action)
        
        // Präsentiere den gesamten Controller
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
}



