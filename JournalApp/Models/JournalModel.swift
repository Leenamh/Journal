//
//  JournalModel.swift
//  JournalApp
//
//  Created by Leena Almusharraf on 21/10/2025.
//

import Foundation

struct Journal: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var date: String
    var content: String
    var isBookmarked: Bool = false
}
