//
//  CategoryViewController.swift
//  Todoey
//
//  Created by user on 13/06/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        loadcategories()
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else { fatalError() }
        navBar.backgroundColor = UIColor.blue
    }
    //MARK: -- TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return categories?.count ?? 1 }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "Categorias não adicionada ainda."
        if let color = categories?[indexPath.row].backgroundColor {
            guard let categoryColor = UIColor(hexString: color) else { fatalError() }
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(backgroundColor: categoryColor, returnFlat: true)
        }
        return cell
    }
    //MARK: -- TableView Manipulation Methods
    
    func save(category: Category) {
        do {
            try realm.write({
                realm.add(category)
            })
            } catch {
                print("Erro ao salvar context, \(error)")
            }
        self.tableView.reloadData()
    }
    
    func loadcategories() {
        categories = realm.objects(Category.self)
        self.tableView.reloadData()
    }
    //MARK: -- Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let deletionCategory = self.categories?[indexPath.row] {
            do {
                try self.realm.write({
                    realm.delete(deletionCategory)
                    tableView.reloadData()
                })
            } catch {
                print("Erro ao deletar categoria, \(error)")
            }
        }
    }
    
    //MARK: -- Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textAlert = UITextField()
        let alert = UIAlertController(title: "Adicionar nova categoria", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textAlert.text!
            newCategory.backgroundColor = RandomFlatColor().hexValue()
            self.save(category: newCategory)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Criar nova categoria"
            textAlert = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: -- TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
}
