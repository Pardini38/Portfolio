//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    let realm = try! Realm()
    var todoItems: Results<Item>?
    var selectedCategory: Category? { didSet { loadItems() } }
    let newItem = Item()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 65.0
        tableView.separatorStyle = .none
        loadItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let colorhex = selectedCategory?.backgroundColor {
            title = selectedCategory!.name
            guard let navBar = navigationController?.navigationBar else { fatalError() }
            if let navBarColor = UIColor(hexString: colorhex) {
                navBar.backgroundColor = navBarColor
                navBar.tintColor = ContrastColorOf(backgroundColor: navBarColor, returnFlat: true)
                navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(backgroundColor: navBarColor, returnFlat: true)]
                searchBar.barTintColor = navBarColor
            }
        }
    }
    //MARK: -- TableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return todoItems?.count ?? 1}
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
            let selectedColor = UIColor(hexString: selectedCategory?.backgroundColor)
            if let color = selectedColor?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
            }
        } else {
            cell.textLabel?.text = "Nenhum item adicionado."
        }
        return cell
    }
    //MARK: -- TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write({
                     item.done = !item.done
                })
            } catch {
                print("Erro ao salvar status da tarefa, \(error)")
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    //MARK: -- Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textAlert = UITextField()
        
        let alert = UIAlertController(title: "Adicionar nova tarefa", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write({
                        let newItem = Item()
                        newItem.title = textAlert.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    })
                } catch {
                    print("Erro ao salvar novo item, \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Criar novo item"
            textAlert = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //MARK: -- Métodos de manipulação do Model
    
    func loadItems() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
//MARK: -- Delete data with swipe

    override func updateModel(at indexPath: IndexPath) {
        if let deletionItem = self.todoItems?[indexPath.row] {
            print("Categoria sendo deletado \(deletionItem)")
            do {
                try self.realm.write({
                    realm.delete(deletionItem)
                    tableView.reloadData()
                })
            } catch {
                print("Erro ao deletar item, \(error)")
            }
        }
    }
}
//MARK: -- UISearchBarDelegate

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

