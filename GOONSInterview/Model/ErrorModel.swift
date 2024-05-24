//
//  ErrorModel.swift
//  GOONSInterview
//
//  Created by Huei-Der Huang on 2024/5/24.
//

import Foundation

enum ErrorModel: Error {
    case InvalidSearchText
    case InvalidURL
}


extension ErrorModel {
    public var description: String {
        switch self {
        case .InvalidSearchText:
            return "The data couldn't be read because it is missing."
        case .InvalidURL:
            return "The URL couldn't be read because it is missing."
        }
    }
}
