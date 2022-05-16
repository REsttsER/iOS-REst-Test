//
//  RealmHelper.swift
//  REst
//
//  Created by 장은애(Eunae Jang) on 2022/05/16.
//

import Foundation
import RealmSwift
import UIKit

class RealmHelper {
    private init() {}
    static let shared = RealmHelper()
    var realm = try! Realm()
    
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("realm create error: \(error)")
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("realm delete Error: \(error)")
        }
    }
}
