//
//  ATM.swift
//  iOS Code Challenge
//
//  Created by Thilagawathy Duraisamy on 30/7/2024.
//

import Foundation
struct ATM {
    let id: String
    let name: String
    let locationLat: Float
    let locationLong: Float
    let address: String

    init?(withJSON json: Network.JSON) {
        guard let id = json["id"] as? String else { return nil }
        guard let name = json["name"] as? String else { return nil }
        guard let address = json["address"] as? String else { return nil }

        self.id = id
        self.name = name
        self.address = address

        guard let location = json["location"] as? Network.JSON else { return nil }
        guard let locationLat = location["lat"] as? Float else { return nil }
        guard let locationLong = location["lon"] as? Float else { return nil }

        self.locationLat = locationLat
        self.locationLong = locationLong
    }
}
