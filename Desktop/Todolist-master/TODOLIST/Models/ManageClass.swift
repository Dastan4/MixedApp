//
//  ManageClass.swift
//  TODOLIST
//
//  Created by Dastan Mambetaliev on 17/3/21.
//
import UIKit
import Foundation
import RealmSwift

//класс для доступа к хранилищу 
class ManageClass {
    var database: Realm
    static let sharedInstance = ManageClass()
    
    init() {
        database = try! Realm()
    }
}
