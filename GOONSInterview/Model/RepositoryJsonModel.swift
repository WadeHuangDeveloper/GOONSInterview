//
//  RepositoryJsonModel.swift
//  GOONSInterview
//
//  Created by Huei-Der Huang on 2024/5/24.
//

import Foundation

struct RepositoryJsonModel: Codable {
    var items: [ItemJsonModel]
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decode([ItemJsonModel].self, forKey: .items)
    }
}
