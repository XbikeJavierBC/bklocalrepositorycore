//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import bkdomauncore

struct BKRideRealmConverter {
    public static func modelToEntity(model: BKRideModel) -> BKRideRealmEntity {
        let realmEntity = BKRideRealmEntity()

        realmEntity.time            = model.time
        realmEntity.distance        = model.distance
        realmEntity.startAddress    = model.startAddress
        realmEntity.endAddress      = model.endAddress

        return realmEntity
    }
    
    public static func entityToModel(entity: BKRideRealmEntity?) -> BKRideModel {
        guard let entity = entity else {
            return BKRideModel()
        }
        
        return BKRideModel(
            time: entity.time,
            distance: entity.distance,
            startAddress: entity.startAddress,
            endAddress: entity.endAddress
        )
    }
}
