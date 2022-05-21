//
//  SafariView.swift
//  VacancyList
//
//  Created by Антон Таранов on 21.05.2022.
//

import SwiftUI
import SafariServices


struct Safari: UIViewControllerRepresentable {
    let url: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return SFSafariViewController(url: URL(string: url)!)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }
}
