//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import Foundation
import RealmSwift
import ghgungnircore

class BKCoordinateRealmEntity: Object {
    @Persisted(primaryKey: true)
    var id: String = UUID().uuidString
    
    @Persisted
    var latitude: Double = 0.0
    
    @Persisted
    var longitude: Double = 0.0
}
