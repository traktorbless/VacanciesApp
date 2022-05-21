//
//  model.swift
//  vacancyList
//
//  Created by Антон Таранов on 18.05.2022.
//

import Foundation

struct Items: Codable {
    var items: [Vacancy]
}

struct Vacancy: Codable, Identifiable {
    var id: String
    var salary: Salary?
    var name: String
    var area: Area
    var alternate_url: String
    var employer: Employer
    var schedule: Schedule
}

struct Area: Codable, Identifiable {
    var id: String
    var name: String
}

struct Schedule: Codable, Identifiable {
    var id: String
    var name: String
}

struct Employer: Codable {
    var name: String
}

struct Salary: Codable {
    var to: Int?
    var from: Int?
}
