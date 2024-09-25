//
//  DatabaseClient.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//

import Foundation
import RealmSwift

protocol DatabaseClientInterface {
    init(inMemoryIdentifier: String?)
    var realm: Realm? {get}
}

class DatabaseClient: DatabaseClientInterface {
   
    public private(set) var realm: Realm?
    
    required init(inMemoryIdentifier: String? = nil) {
        do {
            self.realm = try getRealm(inMemoryIdentifier)
            let dbType = inMemoryIdentifier == nil ? "Default" : "In-Memory"
            let path = self.realm?.configuration.inMemoryIdentifier == inMemoryIdentifier ? (self.realm?.configuration.fileURL?.absoluteString ?? "In-Memory (RAM) db file can't be created, only 'Default' realm file can be created and saved"): (Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? "")
            print("\(dbType) DB: \(path)")
        } catch {
            self.realm = nil
            print("Realm setup error: \(error.localizedDescription)")
        }
        
    }
    
    private func getRealm(_ identifier: String?) throws -> Realm {
        guard let identifier else {
            return try createSecureRealm()
        }
        return try createInMemoryRealm(identifier)
    }
    
    func createSecureRealm() throws -> Realm {
        // Load or create the encryption key
        if let key = KeychainHelper.loadKey() {
            // Use existing key
           return try setupRealm(with: key)
        } else {
            // Generate and save new key
            let newKey = KeychainHelper.generateKey()
            KeychainHelper.saveKey(key: newKey)
            return try setupRealm(with: newKey)
        }
    }
    
    func setupRealm(with key: Data) throws -> Realm {
        var config = Realm.Configuration()
        config.encryptionKey = key
        config.schemaVersion = 1 // Update this if you make schema changes
        config.migrationBlock = { migration, oldSchemaVersion in
            // Handle migrations if necessary
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        return try Realm()
    }
    
    private func createInMemoryRealm(_ identifier: String) throws -> Realm {
        let config = Realm.Configuration(inMemoryIdentifier: identifier)
        return try Realm(configuration: config)
    }
    
}
