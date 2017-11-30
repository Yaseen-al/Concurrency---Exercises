//
//  Country.swift
//  2017_11_30 Concurrency - Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
struct Country: Codable {
    let name: String
    let region: String
    let population: Int
    let alpha2Code: String
    let capital: String
    let timezones: [String]
    let languages: [language]
    let flag: String
}

struct language: Codable {
    let name: String
    let nativeName: String
}
