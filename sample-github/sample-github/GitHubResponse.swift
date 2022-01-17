//
//  GitHubResponse.swift
//  sample-github
//
//  Created by KaitoKudo on 2022/01/16.
//

import Foundation

struct GitHubResponse: Codable {
    let items: [Item]
}

struct Item: Codable {
    let fullName: String
    
    private enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
    }
}
