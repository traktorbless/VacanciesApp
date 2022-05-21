//
//  FilterView.swift
//  vacancyList
//
//  Created by Антон Таранов on 18.05.2022.
//

import SwiftUI

struct FilterView: View {
    @ObservedObject var vacancyApp: VacancyApp
    
    var body: some View {
        Form {
            Section {
                Picker("City", selection: $vacancyApp.currentArea) {
                    ForEach(vacancyApp.areas.keys.sorted(),id: \.self) {
                        Text($0)
                    }
                }
            }
            
            Section {
                Picker("Schedule",selection: $vacancyApp.currentSchedule) {
                    ForEach(vacancyApp.schedules.keys.sorted(),id: \.self) {
                        Text($0)
                    }
                }
            }
        }
        .onDisappear {
            vacancyApp.changeFilter()
            Task {
                await vacancyApp.loadData()
            }
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(vacancyApp: VacancyApp())
    }
}
