//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import Foundation
import Combine
import RealmSwift

import ghgungnircore
import ghvultangcore

import bkdomauncore

public class BKRXRideLocalRepository: GHRxDaoDelegate {
    public typealias T = BKRideModel
    public typealias U = String
    
    private static let coreNotFound = "Core not initialice"
    
    public static func get(id: String) throws -> AnyPublisher<BKRideModel, Error>? {
        guard let realm = GHRealmCore().core else {
            return Fail(
                error: GHError.make(message: self.coreNotFound)
            ).eraseToAnyPublisher()
        }
        
        return realm.objects(BKRideRealmEntity.self)
            .collectionPublisher
            .tryMap { BKRideRealmConverter.entityToModel(entity: $0.filter { $0.id == id }.first) }
            .eraseToAnyPublisher()
    }
    
    public static func getAll() throws -> AnyPublisher<[BKRideModel], Error>? {
        guard let realm = GHRealmCore().core else {
            return Fail(
                error: GHError.make(message: self.coreNotFound)
            ).eraseToAnyPublisher()
        }
        
        return realm.objects(BKRideRealmEntity.self)
            .collectionPublisher
            .tryMap { $0.map { BKRideRealmConverter.entityToModel(entity: $0) } }
            .eraseToAnyPublisher()
    }
    
    public static func save(model: BKRideModel) throws -> AnyPublisher<Bool, Error>? {
        return GHPublisher<BKRideRealmEntity, Error>(initialValue: BKRideRealmConverter.modelToEntity(model: model))
            .tryMap { realmEntity in
                guard let realm = GHRealmCore().core else {
                    throw GHError.make(message: self.coreNotFound)
                }
                
                try realm.write {
                    realm.add(realmEntity, update: .modified)
                }
                return true
            }
            .eraseToAnyPublisher()
    }
    
    public static func saveAll(modelList: [BKRideModel]) throws -> AnyPublisher<Bool, Error>? {
        let list = modelList.map { BKRideRealmConverter.modelToEntity(model: $0) }
        
        return GHPublisher<[BKRideRealmEntity], Error>(initialValue: list)
            .tryMap { realmEntity in
                guard let realm = GHRealmCore().core else {
                    throw GHError.make(message: self.coreNotFound)
                }
                
                try realm.write {
                    realm.add(realmEntity, update: .modified)
                }
                return true
            }
            .eraseToAnyPublisher()
    }
    
    public static func delete(id: String) throws -> AnyPublisher<Bool, Error>? {
        guard let realm = GHRealmCore().core else {
            return Fail(
                error: GHError.make(message: self.coreNotFound)
            ).eraseToAnyPublisher()
        }
        
        return realm.objects(BKRideRealmEntity.self)
            .collectionPublisher
            .tryMap {
                guard let realmEntity = $0
                    .filter("id == \(id)")
                    .first else  {
                    return false
                }
                
                try realm.write {
                    realm.delete(realmEntity)
                }
                
                return true
            }
            .eraseToAnyPublisher()
    }
    
    public static func deleteAll() throws -> AnyPublisher<Bool, Error>? {
        guard let realm = GHRealmCore().core else {
            return Fail(
                error: GHError.make(message: self.coreNotFound)
            ).eraseToAnyPublisher()
        }
        
        return realm.objects(BKRideRealmEntity.self)
            .collectionPublisher
            .tryMap { elements in
                try realm.write {
                    realm.delete(elements)
                }
                
                return true
            }
            .eraseToAnyPublisher()
    }
}
