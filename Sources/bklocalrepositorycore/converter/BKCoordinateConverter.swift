//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import bkdomauncore
import RealmSwift

struct BKCoordinateConverter {
    public static func modelToEntity(model: BKCoordinateModel) -> BKCoordinateRealmEntity {
        let realmEntity = BKCoordinateRealmEntity()

        realmEntity.latitude         = model.latitude
        realmEntity.longitude        = model.longitude

        return realmEntity
    }
    
    public static func entityToModel(entity: BKCoordinateRealmEntity?) -> BKCoordinateModel {
        guard let entity = entity else {
            return BKCoordinateModel()
        }
        
        return BKCoordinateModel(
            latitude: entity.latitude,
            longitude: entity.longitude
        )
    }
}
