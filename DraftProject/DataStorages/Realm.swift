//
//  Realm.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import RealmSwift

class RealmDatabase: NSObject {

    public let realm: Realm
    public static var dbVersion: UInt64 = 1 // Версия автоматически поднимается, если оказалась ниже, чем на устройстве.
    
    var isInTransaction: Bool {
        return realm.isInWriteTransaction
    }
    
    static func realmConfig() -> Realm.Configuration {
        let realmPath = Realm.Configuration.defaultConfiguration.fileURL!
        return Realm.Configuration(
            fileURL: realmPath,
            schemaVersion: RealmDatabase.dbVersion
        )
    }
    
    static func getDbVersion() -> UInt64 {
        let configCheck = Realm.Configuration()
        do {
            let schemaVersion = try schemaVersionAtURL(configCheck.fileURL!)
            print("schema version \(schemaVersion)")
            return schemaVersion
        } catch {
            print(error)
            return 0
        }
    }
    
    override init() {
        
        RealmDatabase.dbVersion = RealmDatabase.getDbVersion()
        if let realmOptional = try? Realm(configuration: RealmDatabase.realmConfig()) {
            realm = realmOptional
        } else {
            RealmDatabase.dbVersion = RealmDatabase.getDbVersion() + 1
            realm = try! Realm(configuration: RealmDatabase.realmConfig())
            print("⚠️ Realm Scheme Version was updated")
        }
        
        super.init()
    }
    
    func write(writeClosure: () -> Void) {
        do {
            try realm.write {
                writeClosure()
            }
        } catch {
            print("⛔️⛔️⛔️ Realm write operation error: \(error.localizedDescription)")
        }
    }
    
    func reset() {
        write {
            realm.deleteAll()
        }
    }
    
    func get<T: Object>(_ type: T.Type, id: Int) -> T? {
        return realm.object(ofType: type, forPrimaryKey: id)
    }
    
    func get<T: Object>(_ type: T.Type) -> Results<T> {
        return realm.objects(type.self)
    }
    
    func save<T: Object>(_ object: T) {
        write {
            realm.add(object, update: .modified)
        }
    }
    
    func save<S: Collection>(_ objects: S) where S.Iterator.Element: Object {
        write {
            realm.add(objects, update: .modified)
        }
    }
    
    func removeAll<T: Object>(_ type: T.Type) {
        write {
            let all = get(type)
            realm.delete(all)
        }
    }
    
    func remove<T: Object>(_ object: T, cascading: Bool = false) {
        write {
            realm.delete(object)
        }
    }
}

extension Object {
        
    var hasPrimaryKey: Bool {
        return self.objectSchema.primaryKeyProperty != nil
    }
    
//    func save() {
//        db.save(self)
//    }
    
}

extension Results {
    func array() -> [Element] {
        return self.map { $0 }
    }
    
    func empty() -> Results {
        return self.filter("FALSEPREDICATE")
    }
}

extension RealmSwift.List {
    func array() -> [Element] {
        return self.map { $0 }
    }
}

