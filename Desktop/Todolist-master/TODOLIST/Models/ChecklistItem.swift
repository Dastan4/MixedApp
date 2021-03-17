//
//  ChecklistItem.swift
//  TODOLIST
//
//  Created by Dastan Mambetaliev on 15/2/21.
//

import Foundation
import RealmSwift

class ChecklistItem: Object, Codable {
    
    @objc dynamic var text = ""
    @objc dynamic var desc = ""
    @objc dynamic var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
    
}
