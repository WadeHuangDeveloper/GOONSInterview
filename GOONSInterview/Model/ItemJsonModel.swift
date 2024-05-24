//
//  ItemJsonModel.swift
//  GOONSInterview
//
//  Created by Huei-Der Huang on 2024/5/24.
//

import Foundation

struct ItemJsonModel: Codable {
    var owner: OwnerJsonModel
    var repositoryName: String
    var description: String
    var programLanguage: String
    var stars: Int
    var watchers: Int
    var forks: Int
    var issues: Int
    
    enum CodingKeys: String, CodingKey {
        case owner
        case repositoryName = "full_name"
        case description
        case programLanguage = "language"
        case stars = "stargazers_count"
        case watchers = "watchers_count"
        case forks = "forks_count"
        case issues = "open_issues_count"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.owner = try container.decode(OwnerJsonModel.self, forKey: .owner)
        self.repositoryName = try container.decode(String.self, forKey: .repositoryName)
        self.description = try container.decode(String.self, forKey: .description)
        self.programLanguage = try container.decode(String.self, forKey: .programLanguage)
        self.stars = try container.decode(Int.self, forKey: .stars)
        self.watchers = try container.decode(Int.self, forKey: .watchers)
        self.forks = try container.decode(Int.self, forKey: .forks)
        self.issues = try container.decode(Int.self, forKey: .issues)
    }
}
