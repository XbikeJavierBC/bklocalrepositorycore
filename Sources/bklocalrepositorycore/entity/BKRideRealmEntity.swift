//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import Foundation
import RealmSwift
import ghgungnircore

public class BKRideRealmEntity: Object {
    @Persisted(primaryKey: true)
    var id: String = UUID().uuidString
    
    @Persisted
    var time: Int = -1
    
    @Persisted
    var distance: Double = 0.0
    
    @Persisted
    var startAddress: String = .empty
    
    @Persisted
    var endAddress: String = .empty
}
