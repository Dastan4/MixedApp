//
//  ToDoList.swift
//  TODOLIST
//
//  Created by Dastan Mambetaliev on 15/2/21.
//

import Foundation
import UIKit
import RealmSwift

//var defaults = UserDefaults.standard

//var titlesUserDefaults = defaults.array(forKey: Key.text) as? [String] ?? [String]()
//var descriptionsUserDefaults = defaults.array(forKey: Key.desc) as? [String] ?? [String]()
//var checkedsUserDefaults = defaults.array(forKey: Key.checked) as? [Bool] ?? [Bool]()

//struct Key {
//    static let text = "Title"
//    static let desc = "Description"
//    static var checked = "Checked"
//}



//extension ItemDetailViewController {
//    
//    func addItem(text: String, description: String, checked: Bool = false) {
//        let realm = try! Realm()
//
//        let title = ChecklistItem()
//        title.text = text
//
//        let desc = ChecklistItem()
//        desc.desc = description
//
//        try! realm.write {
//            realm.add([title, desc])
//        }
//
//    }
//}
    
//    var todos: [ChecklistItem] = []
//    var defaults = UserDefaults.standard

//    init() {
//        updateTodos()
//    }
    
    
//    func newTodo() -> ChecklistItem {
//        let item = ChecklistItem()
//        item.text = ""
//        item.desc = ""
//        item.checked = true
////        todos.append(item)
//        return item
//    }
    
//    func updateTodos() {
//        for i in 0..<titlesUserDefaults.count {
//            let item = ChecklistItem()
//            item.text = titlesUserDefaults[i]
//            item.desc = descriptionsUserDefaults[i]
//            item.checked = checkedsUserDefaults[i]
//            todos.append(item)
//        }
//    }
    

//    func updateData() {
//        titlesUserDefaults = []
//        descriptionsUserDefaults = []
//        checkedsUserDefaults = []
//        for i in todos {
//            titlesUserDefaults.append(i.text)
//            descriptionsUserDefaults.append(i.desc)
//            checkedsUserDefaults.append(i.checked)
//        }
//        defaults.removeObject(forKey: Key.text)
//        defaults.removeObject(forKey: Key.desc)
//        defaults.removeObject(forKey: Key.checked)
//        
//        defaults.set(titlesUserDefaults, forKey: Key.text)
//        defaults.set(descriptionsUserDefaults, forKey: Key.desc)
//        defaults.set(checkedsUserDefaults, forKey: Key.checked)



extension ChecklistViewController {
    func removeItem(at index: ChecklistItem) {
        try! realm.write {
            realm.delete(index)
        }

    }

}
