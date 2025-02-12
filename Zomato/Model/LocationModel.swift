//
//  LocationManager.swift
//  Zomato
//
//  Created by Celestial on 23/01/25.
//

import Foundation

//MARK: - GeopifyResponse Model for API Decoding

struct GeoapifyResponse: Codable, Hashable {
    let features: [Feature]
}

struct Feature: Codable, Hashable {
    let properties: Properties
}

struct Properties: Codable, Hashable {
    let suburb: String?
    let distance: Int?
    let lon: Double?
    let lat: Double?
    let state: String?
    let address_line1: String?
}


