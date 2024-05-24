//
//  Coordinator.swift
//  GOONSInterview
//
//  Created by Huei-Der Huang on 2024/5/24.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
    func request(_ event: CoordinatorEvent)
}

enum CoordinatorEvent {
    case toListView
    case toDetailView(_ viewModel: ItemJsonModel)
}
