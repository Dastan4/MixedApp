//
//  ViewController.swift
//  TODOLIST
//
//  Created by Dastan Mambetaliev on 8/2/21.
//

import RealmSwift
import UIKit

class ChecklistViewController: UITableViewController {

//    var todoList = TodoList()
    
    let realm = try! Realm()
//    контейнер сохраненных элементов
    var items: Results<ChecklistItem>!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let todos: Results<ChecklistItem>? = ManageClass.sharedInstance.database.objects(ChecklistItem.self) {
            items = todos
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count != 0 {
            return items.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
//        let item = todoList.todos[indexPath.row]
        let item = items[indexPath.row]
        configureText(cell: cell, with: item)
        configureCheckmark(for: cell, with: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
//            let item = todoList.todos[indexPath.row]
            let item = items[indexPath.row]
//            изменение статуса выполнения
            try! ManageClass.sharedInstance.database.write {
                item.toggleChecked()
            }
            configureCheckmark(for: cell, with: item)
//            todoList.updateData()
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        todoList.todos.remove(at: indexPath.row)
        let editingRow = items[indexPath.row]
        
        let indexPaths = [indexPath]
        removeItem(at: editingRow)
        tableView.deleteRows(at: indexPaths, with: .automatic )
//        todoList.updateData()
    }
    
    
    func configureText(cell: UITableViewCell, with item: ChecklistItem) {
        if let cellText = cell as? ChecklistTableViewCell {
            cellText.titleTextLabel.text = item.text
            cellText.descriptionTextLabel.text = item.desc
        }
    }
    
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        guard let checkmark = cell as? ChecklistTableViewCell else {
            return
        }
        
        if item.checked {
            checkmark.checkLabel.text = "√"
        } else {
            checkmark.checkLabel.text = ""
        }
        
    }
    
//    делегирование
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let itemDetailViewController = segue.destination as? ItemDetailViewController {
                itemDetailViewController.delegate = self
                itemDetailViewController.todoList = items
            }
        } else if segue.identifier == "EditItemSegue" {
            if let itemDetailViewController = segue.destination as? ItemDetailViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
//                    let item = todoList.todos[indexPath.row]
//                    itemDetailViewController.itemToEdit = item
                    itemDetailViewController.itemToEdit = items[indexPath.row]
                    itemDetailViewController.delegate = self
                }
            }
        }
    }
}
//расширением мы передаем протокол делегирования из AddItemTableViewController
extension ChecklistViewController: ItemDetailViewControllerDelegate {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        navigationController?.popViewController(animated: true)
        try! ManageClass.sharedInstance.database.write {
//            добавление в базу Realm
            ManageClass.sharedInstance.database.add(item)
        }
        let rowIndex = items.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        if let index = items.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(cell: cell, with: item)
//                todoList.updateData()
            }
        }
        navigationController?.popViewController(animated: true)
//        обновление тут необходимо для отображения изменений title or description в checkListViewController
        tableView.reloadData()
    }
    
}
