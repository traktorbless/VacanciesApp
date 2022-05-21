//
//  ContentView.swift
//  vacancyList
//
//  Created by Антон Таранов on 18.05.2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var vacancyApp = VacancyApp()
    @State var currentURL = ""
    @State var isPresented = false

    var body: some View {
        NavigationView {
            List {
                ForEach(vacancyApp.vacancies) { item in
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Spacer(minLength: 3)
                        
                        Text(item.employer.name)
                        
                        Spacer(minLength: 10)
                        
                        HStack {
                            Spacer()
                            
                            SalaryText(salaryFrom: item.salary?.from, salaryTo: item.salary?.to)
                        }

                    }
                    .onTapGesture {
                        isPresented = true
                    }
                    .sheet(isPresented: $isPresented) {
                        Safari(url: item.alternate_url)
                    }
                }
            }
            .refreshable {
                Task {
                    await vacancyApp.loadData()
                }
            }
            .listStyle(.plain)
            .task {
                await vacancyApp.loadData()
            }
            .searchable(text: $vacancyApp.keyWord)
            .navigationTitle("Vacancy")
            .onChange(of: vacancyApp.keyWord) { _ in
                Task {
                    await vacancyApp.loadData()
                }
            }
            .toolbar {
                NavigationLink {
                    FilterView(vacancyApp: vacancyApp)
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }
            }
        }
    }
    
    @ViewBuilder private func SalaryText(salaryFrom: Int?, salaryTo: Int?) -> some View {
        if let salaryFrom = salaryFrom {
            HStack(alignment: .top) {
                Text("Salary: from")
                
                Text("\(salaryFrom)")
                    .fontWeight(.heavy)
                    .foregroundColor(.green)
            }
        } else if let salaryTo = salaryTo {
             HStack {
                Text("Salary: to")
                
                Spacer(minLength: 5)
                
                Text("\(salaryTo)")
                    .fontWeight(.heavy)
                    .foregroundColor(.green)
            }
        } else {
            Text("")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(vacancyApp: VacancyApp())
    }
}

