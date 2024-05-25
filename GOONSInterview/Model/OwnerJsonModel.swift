//
//  OwnerJsonModel.swift
//  GOONSInterview
//
//  Created by Huei-Der Huang on 2024/5/24.
//

import Foundation
import SDWebImage

struct OwnerJsonModel: Codable {
    var icon: String
    var login: String
    
    enum CodingKeys: String, CodingKey {
        case icon = "avatar_url"
        case login = "login"
    }
    
    init(from decoder: any Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.icon = try container.decode(String.self, forKey: .icon)
            self.login = try container.decode(String.self, forKey: .login)
        } catch {
            print(error)
            throw error
        }
    }
}
