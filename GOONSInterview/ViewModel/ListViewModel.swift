//
//  ListViewModel.swift
//  GOONSInterview
//
//  Created by Huei-Der Huang on 2024/5/24.
//

import Foundation
import Alamofire

class ListViewModel {
    @Published var itemModels = [ItemJsonModel]()
    @Published var errorMessage: String? = nil
    private let githubUrl = "https://api.github.com/search/repositories?q="
    
    func requestAPI(_ text: String) {
        Task {
            do {
                guard !text.isEmpty else {
                    throw ErrorModel.InvalidSearchText
                }
                
                guard let url = URL(string: "\(githubUrl)\(text)") else {
                    throw ErrorModel.InvalidURL
                }
                
                print(url)
                
                let request = AF.request(url, method: .get) { $0.timeoutInterval = 5.0 }
                request.responseDecodable { [weak self] (response: DataResponse<RepositoryJsonModel, AFError>) in
                    switch response.result {
                    case .success(let model):
                        self?.itemModels = model.items
                        self?.errorMessage = nil
                        
                    case .failure(let error):
                        self?.itemModels.removeAll()
                        self?.errorMessage = error.localizedDescription
                    }
                }
            } catch {
                self.itemModels.removeAll()
                if let error = error as? ErrorModel {
                    errorMessage = error.description
                } else if let error = error as? AFError {
                    errorMessage = error.errorDescription
                } else {
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}
