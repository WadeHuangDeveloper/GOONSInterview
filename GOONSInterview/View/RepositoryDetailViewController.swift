//
//  RepositoryDetailViewController.swift
//  GOONSInterview
//
//  Created by Huei-Der Huang on 2024/5/24.
//

import UIKit
import Combine
import SDWebImage

class RepositoryDetailViewController: UIViewController {
    static let identifier = "\(RepositoryDetailViewController.self)"
    var coordinator: MainCoordinator?
    var viewModel = DetailViewModel()
    private var subscriptions = Set<AnyCancellable>()
    private var loginLabel = UILabel()
    private var iconImageView = UIImageView()
    private var fullNameLabel = UILabel()
    private var languageLabel = UILabel()
    private var starsLabel = UILabel()
    private var watchersLabel = UILabel()
    private var forksLabel = UILabel()
    private var issuesLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCombine()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        loginLabel.font = .systemFont(ofSize: 40, weight: .bold)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        
        fullNameLabel.font = .systemFont(ofSize: 30, weight: .medium)
        fullNameLabel.textAlignment = .center
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        languageLabel.font = .systemFont(ofSize: 18, weight: .bold)
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        starsLabel.font = .systemFont(ofSize: 14, weight: .regular)
        starsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        watchersLabel.font = .systemFont(ofSize: 14, weight: .regular)
        watchersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        forksLabel.font = .systemFont(ofSize: 14, weight: .regular)
        forksLabel.translatesAutoresizingMaskIntoConstraints = false
        
        issuesLabel.font = .systemFont(ofSize: 14, weight: .regular)
        issuesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let numbersView = UIStackView(arrangedSubviews: [starsLabel, watchersLabel, forksLabel, issuesLabel])
        numbersView.axis = .vertical
        numbersView.alignment = .trailing
        numbersView.distribution = .equalSpacing
        numbersView.spacing = 12
        numbersView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomView = UIStackView(arrangedSubviews: [languageLabel, numbersView])
        bottomView.axis = .horizontal
        bottomView.alignment = .top
        bottomView.distribution = .fillEqually
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        let mainStackView = UIStackView(arrangedSubviews: [loginLabel, iconImageView, fullNameLabel, bottomView])
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .equalSpacing
        mainStackView.spacing = 10
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: view.bounds.width-40),
            
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    private func setupCombine() {
        viewModel.$itemModel
            .receive(on: DispatchQueue.main)
            .sink { model in
                guard let model = model else { return }
                self.iconImageView.sd_setImage(with: URL(string: model.owner.icon))
                self.loginLabel.text = model.owner.login
                self.fullNameLabel.text = model.repositoryName
                self.languageLabel.text = "Written in \(model.programLanguage)"
                self.starsLabel.text = "\(model.stars) stars"
                self.watchersLabel.text = "\(model.watchers) watchers"
                self.forksLabel.text = "\(model.forks) forks"
                self.issuesLabel.text = "\(model.issues) issues"
            }.store(in: &subscriptions)
    }
}
