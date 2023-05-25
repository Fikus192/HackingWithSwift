//
//  ActivityItem.swift
//  ChallengeDay_4
//
//  Created by Mateusz Ratajczak on 03/05/2023.
//

import Foundation

struct ActivityItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let time: Int
    var completedCount = 0
    
    static func == (lhs: ActivityItem, rhs: ActivityItem) -> Bool {
        lhs.id == rhs.id && lhs.completedCount == rhs.completedCount
    }
}
