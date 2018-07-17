//
//  RealmAccessLayer.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import RealmSwift
import Realm


class RealmManager /*: DBManagerProtocol*/ {
    
//    typealias T = Object
//    typealias F = List
    
    static let shared = RealmManager()
    
    init() {
        self.setDefaultRealmForUser()
    }
    
    func setDefaultRealmForUser() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 2,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        let _ = try! Realm()
    }
    
    private func realmObject() throws -> Realm {
        let realm = try Realm()
        return realm
    }
    
    func removeRealmDBFile() {
        guard let realm = try? realmObject() else { return }
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    func store(_ obj: Object) {
        let realm = try? realmObject()
        
        try? realm?.write {
            realm?.add(obj, update: true)
        }
    }
    
    func delete<T: Object>(_ type: T.Type, key: String) {
        let realm = try? realmObject()
        if let objs = realm?.objects(type).filter("id=%@", key) {
            try? realm?.write {
                realm?.delete(objs)
            }
        }
    }
    
    func get<T: Object>(_ type: T.Type, filter: String? = nil, sortKey: String? = nil, ascending: Bool = false, prefix: Int? = nil) -> List<T> {
        let list = List<T>()
        
        guard let realm = try? realmObject() else { return list }
        
        var objects = realm.objects(type)
        
        if let filter = filter {
            objects = objects.filter(filter)
        }
        if let sortKey = sortKey {
            objects = objects.sorted(byKeyPath: sortKey, ascending: ascending)
        }
        var count = objects.count
        if let prefix = prefix {
            count = min(prefix, count)
        }
        
        for idx in 0..<count {
            list.append(objects[idx].detached())
        }
        return list
    }
    
}

