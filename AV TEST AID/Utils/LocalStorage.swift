//
//  LocalStorage.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 13/07/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation

final class LocalStorage: NSObject {
    
    override init() {
        super.init()
    }
    
    static let shared = LocalStorage()
    
    public func persistString(string: String!, key: String){
        delete(key: key);
        UserDefaults.standard.setValue(string, forKey: key);
        UserDefaults.standard.synchronize();
    }
    
    public func persistObject(object: NSObject!, key: String) {
        delete(key: key)
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: object)
        UserDefaults.standard.set(encodedData, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    //TODO come back to write a generic version
    public func persistProfessions(profession: [Profession]){
        guard let data = try? JSONEncoder().encode(profession) else { return }
        UserDefaults.standard.set(data, forKey: StringIDs.PersistenceIdentifiers.PROFESSIONS)
    }
    
    public func getProfessions() -> [Profession]{
        guard
            let data = UserDefaults.standard.data(forKey: StringIDs.PersistenceIdentifiers.PROFESSIONS),
            let professions = try? JSONDecoder().decode([Profession].self, from: data)
        else { return [] }
        return professions
    }
    
    public func persistData(encodedData: Data!, key: String) {
        delete(key: key)

        UserDefaults.standard.set(encodedData, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    public func persistInt(value: Int!, key: String){
        delete(key: key);
        UserDefaults.standard.set(value, forKey: key);
        UserDefaults.standard.synchronize();
    }
    
    public func persistDouble(value: Double!, key: String){
        delete(key: key);
        UserDefaults.standard.set(value, forKey: key);
        UserDefaults.standard.synchronize();
    }
    
    public func getString(key: String) -> String? {
        UserDefaults.standard.synchronize()
        return UserDefaults.standard.value(forKey: key) as? String;
    }
    
    public func getObject(key: String) -> NSObject? {
        if let data = UserDefaults.standard.data(forKey: key),
            let object = NSKeyedUnarchiver.unarchiveObject(with: data) as? NSObject  {
            return object
        } else {
            return nil
        }
    }
    
    public func getData(key: String) -> Data? {
        
        UserDefaults.standard.synchronize()
        if let data = UserDefaults.standard.data(forKey: key) {
            return data
        } else {
            return nil
        }
    }
    
    public func contains(key: String) -> Bool{
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    public func getInt(key: String) -> Int {
        UserDefaults.standard.synchronize()
        return UserDefaults.standard.integer(forKey: key)
    }
    
    public func getDouble(key: String) -> Double {
        UserDefaults.standard.synchronize()
        return UserDefaults.standard.double(forKey: key)
    }
    
    public func delete(key: String){
        UserDefaults.standard.removeObject(forKey: key);
        UserDefaults.standard.synchronize();
    }
    
    public func clearAll(){
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        UserDefaults.standard.synchronize()
    }
}
