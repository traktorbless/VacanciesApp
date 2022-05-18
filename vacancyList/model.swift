//
//  model.swift
//  vacancyList
//
//  Created by Антон Таранов on 18.05.2022.
//

import Foundation

struct Items: Codable {
    var items: [Result]
}

struct Result: Codable {
    var name: String
}
