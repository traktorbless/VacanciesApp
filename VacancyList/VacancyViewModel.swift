//
//  VacancyViewModel.swift
//  vacancyList
//
//  Created by Антон Таранов on 19.05.2022.
//

import Foundation
import SwiftUI

@MainActor class VacancyApp: ObservableObject {
    @Published var vacancies = [Vacancy]()
    @Published var keyWord = ""
    @Published var currentArea = "Moscow"
    @Published var currentSchedule = "Fulltime"
    
    var filter = Filters(idArea: "1", schedule: "fullDay")
    
    let areas = ["Moscow" : "1","Saint-Peterburg" : "2"]
    let schedules = ["Fulltime": "fullDay","Shift" : "shift","Flexible" : "flexible","Remote" : "remote","FlyInFlyOut" : "flyInFlyOut"]
    
    func changeFilter() {
        filter = Filters(idArea: areas[currentArea] ?? "1", schedule: schedules[currentSchedule] ?? "fullDay")
    }
    
    func loadData() async {
        guard let url = URL(string: "https://api.hh.ru/vacancies?text=\(keyWord)&area=\(filter.idArea)&schedule=\(filter.schedule)") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(Items.self, from: data) {
                vacancies = decodedResponse.items
            }
        } catch {
            print("Invalid data")
        }
    }
    
    struct Filters {
        var idArea: String
        var schedule: String
    }
}
