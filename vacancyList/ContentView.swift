//
//  ContentView.swift
//  vacancyList
//
//  Created by Антон Таранов on 18.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var results = [Result]()
    @State private var keyWord = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(results, id: \.name) { item in
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                    }
                }
            }
            .task {
                await loadData()
            }
            .searchable(text: $keyWord)
            .navigationTitle("Vacancy")
            .onChange(of: keyWord) { newValue in
                Task {
                    await loadData()
                }
            }
            .toolbar {
                NavigationLink {
                    FilterView()
                } label: {
                    Image(systemName: "line.3.horizontal")
                }
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://api.hh.ru/vacancies?text=\(keyWord)") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(Items.self, from: data) {
                results = decodedResponse.items
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
