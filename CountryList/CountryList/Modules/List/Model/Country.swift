//
//  Country.swift
//  CountryList
//
//  Created by Nivedita Angadi on 11/02/25.
//

import Foundation

struct Country: Codable, Identifiable {
    var abbreviation: String
    var capital: String
    var currency: String
    var id: Int
    var name: String
    var phone: String
    var population: Double?
    var media: Media
}

struct Media: Codable {
    var flag: String
    var emblem: String
    var orthographic: String
}
