//
//  User.swift
//  ChallengeDay_5
//
//  Created by Mateusz Ratajczak on 20/05/2023.
//

import Foundation

struct User: Codable {
    struct Friend: Codable {
        let id: String
        let name: String
    }
    
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    
    let friends: [Friend]
}
