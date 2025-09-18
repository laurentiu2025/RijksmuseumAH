//
//  ArtworkCollectionItemCellImageView.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import UIKit

final class ArtworkCollectionItemCellImageView: UIView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var loadingIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.isHidden = true
        return indicatorView
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
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        setupImageViewLayout()
        setupLoadingIndicatorViewLayout()
        setupErrorLabelLayout()
    }
    
    private func setupImageViewLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    private func setupLoadingIndicatorViewLayout() {
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadingIndicatorView)
        
        NSLayoutConstraint.activate([
            loadingIndicatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            loadingIndicatorView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            loadingIndicatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            loadingIndicatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    private func setupErrorLabelLayout() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            errorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    // MARK: - State
    
    func show(state: ArtworkCollectionItemCellImageViewState) {
        let visibility = ArtworkCollectionItemCellImageViewVisibilityMapper.mapVisibility(state: state)
        setVisibility(visibility)
    }
    
    private func setVisibility(_ visibility: ArtworkCollectionItemCellImageViewVisibility) {
        imageView.image = visibility.image
        imageView.isHidden = visibility.isImageViewHidden
        loadingIndicatorView.isHidden = visibility.isLoadingIndicatorHidden
        visibility.isLoadingIndicatorHidden ? loadingIndicatorView.stopAnimating() : loadingIndicatorView.startAnimating()
        errorLabel.isHidden = visibility.isErrorViewHidden
        errorLabel.text = visibility.errorTitle
    }
}
