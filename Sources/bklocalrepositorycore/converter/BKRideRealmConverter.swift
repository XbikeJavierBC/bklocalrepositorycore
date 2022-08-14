//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import bkdomauncore
import RealmSwift

struct BKRideRealmConverter {
    public static func modelToEntity(model: BKRideModel) -> BKRideRealmEntity {
        let realmEntity = BKRideRealmEntity()

        realmEntity.time            = model.time
        realmEntity.distance        = model.distance
        realmEntity.startAddress    = model.startAddress
        realmEntity.endAddress      = model.endAddress
        
        let list = List<BKCoordinateRealmEntity>()
        let listEntity =  model.coordinateList.map {
            BKCoordinateConverter.modelToEntity(model: $0)
        }
        
        list.append(objectsIn: listEntity)
        
        realmEntity.coordinateList = list

        return realmEntity
    }
    
    public static func entityToModel(entity: BKRideRealmEntity?) -> BKRideModel {
        guard let entity = entity else {
            return BKRideModel()
        }
        
        var list: [BKCoordinateModel] = []
        
        entity.coordinateList.forEach { realmEntity in
            list.append(BKCoordinateConverter.entityToModel(entity: realmEntity))
        }
        
        return BKRideModel(
            time: entity.time,
            distance: entity.distance,
            startAddress: entity.startAddress,
            endAddress: entity.endAddress,
            coordinateList: list
        )
    }
}
