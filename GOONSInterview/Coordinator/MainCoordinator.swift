//
//  MainCoordinator.swift
//  GOONSInterview
//
//  Created by Huei-Der Huang on 2024/5/24.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        request(.toListView)
    }
    
    func request(_ event: CoordinatorEvent) {
        switch event {
        case .toListView:
            let viewController = RepositoryListViewController()
            viewController.coordinator = self
            navigationController.pushViewController(viewController, animated: true)
            
        case .toDetailView(let viewModel):
            let viewController = RepositoryDetailViewController()
            viewController.coordinator = self
            viewController.viewModel.itemModel = viewModel
            navigationController.pushViewController(viewController, animated: true)
            
        }
    }
    
    
}
