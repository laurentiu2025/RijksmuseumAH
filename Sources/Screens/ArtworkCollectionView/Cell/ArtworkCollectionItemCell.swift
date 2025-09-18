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
        label.textAlignment = .left
        return label
    }()
    
    private lazy var artworkImageView: ArtworkCollectionItemCellImageView = {
        let imageView = ArtworkCollectionItemCellImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var loadingIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.isHidden = true
        return indicatorView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return stackView
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .red
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
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        let visibility = ArtworkCollectionItemCellVisibility(title: nil,
                                                             isStackViewHidden: true,
                                                             isLoadingIndicatorHidden: true,
                                                             artworkImageViewBackgroundColor: .clear,
                                                             artworkImageViewState: .idle,
                                                             errorTitle: nil,
                                                             isErrorTitleHidden: true)
        setVisibility(visibility)
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        setupStackViewLayout()
        setupTitleLabelLayout()
        setupArtworkImageViewLayout()
        setupLoadingIndicatorViewLayout()
        setupErrorLabelLayout()
    }
    
    private func setupStackViewLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupTitleLabelLayout() {
        stackView.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupArtworkImageViewLayout() {
        stackView.addArrangedSubview(artworkImageView)
    }
    
    private func setupLoadingIndicatorViewLayout() {
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loadingIndicatorView)
        
        NSLayoutConstraint.activate([
            loadingIndicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
        ])
    }
    
    private func setupErrorLabelLayout() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            errorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            errorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    // MARK: - State
    
    func show(state: ArtworkItemDataLoaderState) {
        let visibility = ArtworkCollectionItemCellVisibilityMapper.mapVisibility(loaderState: state)
        setVisibility(visibility)
    }
    
    private func setVisibility(_ visibility: ArtworkCollectionItemCellVisibility) {
        titleLabel.text = visibility.title
        stackView.isHidden = visibility.isStackViewHidden
        loadingIndicatorView.isHidden = visibility.isLoadingIndicatorHidden
        visibility.isLoadingIndicatorHidden ? loadingIndicatorView.stopAnimating() : loadingIndicatorView.startAnimating()
        artworkImageView.backgroundColor = visibility.artworkImageViewBackgroundColor
        artworkImageView.show(state: visibility.artworkImageViewState)
        errorLabel.text = visibility.errorTitle
        errorLabel.isHidden = visibility.isErrorTitleHidden
    }
}
