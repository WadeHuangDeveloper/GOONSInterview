//
//  RepositoryListViewController.swift
//  GOONSInterview
//
//  Created by Huei-Der Huang on 2024/5/24.
//

import UIKit
import Combine

class RepositoryListViewController: UIViewController {
    static let identifier = "\(RepositoryListViewController.self)"
    var coordinator: MainCoordinator?
    var viewModel = ListViewModel()
    private var subscriptions = Set<AnyCancellable>()
    private var refreshControl = UIRefreshControl()
    private var searchBar = UISearchBar()
    private var repositoryTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCombine()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Repository Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    private func setupUI() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        
        //searchBar.text = "Swift"
        searchBar.delegate = self
        searchBar.searchBarStyle = .default
        searchBar.placeholder = "請輸入關鍵字搜尋"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTableView))
        repositoryTableView.addGestureRecognizer(tapGesture)
        repositoryTableView.refreshControl = refreshControl
        repositoryTableView.tableHeaderView = searchBar
        repositoryTableView.dataSource = self
        repositoryTableView.delegate = self
        repositoryTableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.identifier)
        repositoryTableView.rowHeight = 100
        repositoryTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(repositoryTableView)
        
        NSLayoutConstraint.activate([
            searchBar.heightAnchor.constraint(equalToConstant: 45),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            repositoryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            repositoryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            repositoryTableView.topAnchor.constraint(equalTo: view.topAnchor),
            repositoryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupCombine() {
        viewModel.$itemModels
            .receive(on: DispatchQueue.main)
            .sink { models in
                if models.count > 0 && self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
                self.repositoryTableView.reloadData()
            }.store(in: &subscriptions)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { error in
                guard let error = error else { return }
                self.showAlert(message: error)
            }.store(in: &subscriptions)
    }
    
    @objc private func didTapTableView() {
        view.endEditing(true)
    }
    
    @objc private func didRefresh() {
        viewModel.itemModels.removeAll()
        
        guard let text = searchBar.text else { return }
        viewModel.requestAPI(text)
    }
    
    private func showAlert(message: String = "") {
        refreshControl.endRefreshing()
        
        let alertController = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAlertAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}

extension RepositoryListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.itemModels.removeAll()
        
        guard let text = searchBar.text else { return }
        viewModel.requestAPI(text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.itemModels.removeAll()
        }
    }
}

extension RepositoryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier, for: indexPath) as! RepositoryTableViewCell
        cell.configure(viewModel.itemModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.request(.toDetailView(viewModel.itemModels[indexPath.row]))
    }
}
