//
//  StatisticsModel.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 07/09/26.
//

import UIKit
struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange:Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
