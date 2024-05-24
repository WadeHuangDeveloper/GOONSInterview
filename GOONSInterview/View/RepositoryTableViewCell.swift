//
//  RepositoryTableViewCell.swift
//  GOONSInterview
//
//  Created by Huei-Der Huang on 2024/5/24.
//

import UIKit
import SDWebImage

class RepositoryTableViewCell: UITableViewCell {
    static let identifier = "\(RepositoryTableViewCell.self)"
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var titleView = UIStackView()
    private var iconImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.numberOfLines = 2
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        titleView.axis = .vertical
        titleView.alignment = .leading
        titleView.distribution = .fillEqually
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = 40
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleView)
        addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 80),
            iconImageView.widthAnchor.constraint(equalToConstant: 80),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            titleView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func configure(_ viewModel: ItemJsonModel) {
        iconImageView.sd_setImage(with: URL(string: viewModel.owner.icon))
        titleLabel.text = viewModel.repositoryName
        subtitleLabel.text = viewModel.description
    }

}
