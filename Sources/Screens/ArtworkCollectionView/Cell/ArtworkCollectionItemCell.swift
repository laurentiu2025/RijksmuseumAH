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
    
    private lazy var artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var artworkLoadingIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.isHidden = true
        return indicatorView
    }()
    
    private lazy var imageLoadingIndicatorView = {
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
        
        let viewState = ArtworkCollectionItemCellState(title: nil,
                                                       image: nil,
                                                       isStackViewHidden: true,
                                                       isArtworkLoadingIndicatorHidden: true,
                                                       isImageBackgroundHidden: true,
                                                       isImageLoadingIndicatorHidden: true,
                                                       errorTitle: nil)
        setViewState(viewState)
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        setupStackViewLayout()
        setupTitleLabelLayout()
        setupArtworkImageViewLayout()
        setupArtworkLoadingIndicatorViewLayout()
        setupImageLoadingIndicatorViewLayout()
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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupArtworkImageViewLayout() {
        artworkImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(artworkImageView)
    }
    
    private func setupArtworkLoadingIndicatorViewLayout() {
        artworkLoadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(artworkLoadingIndicatorView)
        
        NSLayoutConstraint.activate([
            artworkLoadingIndicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            artworkLoadingIndicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
        ])
    }
    
    private func setupImageLoadingIndicatorViewLayout() {
        imageLoadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        artworkImageView.addSubview(imageLoadingIndicatorView)
        
        NSLayoutConstraint.activate([
            imageLoadingIndicatorView.centerXAnchor.constraint(equalTo: artworkImageView.centerXAnchor, constant: 0),
            imageLoadingIndicatorView.centerYAnchor.constraint(equalTo: artworkImageView.centerYAnchor, constant: 0),
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
        let viewState = ArtworkCollectionItemCellStateMapper.mapState(loaderState: state)
        setViewState(viewState)
    }
    
    private func setViewState(_ state: ArtworkCollectionItemCellState) {
        titleLabel.text = state.title
        artworkImageView.image = state.image
        stackView.isHidden = state.isStackViewHidden
        artworkLoadingIndicatorView.isHidden = state.isArtworkLoadingIndicatorHidden
        state.isArtworkLoadingIndicatorHidden ? artworkLoadingIndicatorView.stopAnimating() : artworkLoadingIndicatorView.startAnimating()
        let artworkImageViewBackground: UIColor = state.isImageBackgroundHidden ? .clear : .gray
        artworkImageView.backgroundColor = artworkImageViewBackground
        imageLoadingIndicatorView.isHidden = state.isImageLoadingIndicatorHidden
        state.isImageLoadingIndicatorHidden ? imageLoadingIndicatorView.stopAnimating() : imageLoadingIndicatorView.startAnimating()
        errorLabel.isHidden = state.errorTitle == nil
        errorLabel.text = state.errorTitle
    }
}
