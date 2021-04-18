//
//  DetailsViewModel.swift
//  DetailsLibrary
//
//  Created by Elisa Camillo on 17/04/21.
//

import Foundation

public class DetailsViewModel {
    var buttonAdd: Bool
    var title: String
    var abbreviation: String
    var lastHour: Double
    var lastDay: Double
    var lastMonth: Double
    var iconURL: String
    
    init(buttonAdd: Bool, title: String, abbreviation: String, lastHour: Double, lastDay: Double, lastMonth: Double, iconURL: String) {
        self.buttonAdd = buttonAdd
        self.title = title
        self.abbreviation = abbreviation
        self.lastHour = lastHour
        self.lastDay = lastDay
        self.lastMonth = lastMonth
        self.iconURL = iconURL
    }

}
