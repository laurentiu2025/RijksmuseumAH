//
//  ArtworkCollectionItemCell.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import UIKit

final class ArtworkCollectionItemCell: UICollectionViewCell {
    static let identifier = "ArtworkCollectionItemCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureContentView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContentView() {
        contentView.backgroundColor = .gray.withAlphaComponent(0.5)
        contentView.layer.cornerRadius = 8
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        setupTitleLabelLayout()
    }
    
    private func setupTitleLabelLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    // MARK: - Show
    
    func show(artworkId: URL) {
        titleLabel.text = artworkId.lastPathComponent
    }
}
