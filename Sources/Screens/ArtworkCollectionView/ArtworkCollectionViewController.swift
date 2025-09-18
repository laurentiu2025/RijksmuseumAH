//
//  ArtworkCollectionViewController.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import UIKit

final class ArtworkCollectionViewController: UIViewController {
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.isHidden = true
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView.accessibilityIdentifier = ArtworkCollectionViewAccessibilityIdentifier.collectionView.rawValue
        return collectionView
    }()
    
    private lazy var loadingIndicatorView =  {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.isHidden = true
        indicatorView.accessibilityIdentifier = ArtworkCollectionViewAccessibilityIdentifier.loadingIndicator.rawValue
        return indicatorView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No data available."
        label.textColor = .label
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.isHidden = true
        view.onRetry = { [weak self] in
            guard let self = self else {
                return
            }
            
            viewModel.fetchArtworkItems()
        }
        
        view.accessibilityIdentifier = ArtworkCollectionViewAccessibilityIdentifier.errorView.rawValue
        return view
    }()
    
    private let collectionViewDelegate: ArtworkCollectionViewDelegate
    private let collectionViewDataSource: ArtworkCollectionViewDataSource
    private var viewModel: ArtworkCollectionViewModeling
    
    typealias ArtworkSelectionHandler = (ArtworkResource) -> Void
    var onArtworkSelected: ArtworkSelectionHandler?
    
    // MARK: - Initialization
    
    init(collectionViewDelegate: ArtworkCollectionViewDelegate, collectionViewDataSource: ArtworkCollectionViewDataSource, viewModel: ArtworkCollectionViewModeling) {
        self.collectionViewDelegate = collectionViewDelegate
        self.collectionViewDataSource = collectionViewDataSource
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        configureCollectionView()
        setupCollectionViewCallbacks()
        setupLayout()
        viewModel.fetchArtworkItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let padding: CGFloat = 16
        let interitemSpacing: CGFloat = collectionViewLayout.minimumInteritemSpacing
        let totalSpacing = interitemSpacing + padding
        
        let numberOfItemsPerRow: CGFloat = 2
        let availableWidth = collectionView.bounds.width - totalSpacing
        let itemWidth = floor(availableWidth / numberOfItemsPerRow)
        
        collectionViewLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    // MARK: - Setup
    
    private func bindViewModel() {
        viewModel.onStateChange = { [weak self] state in
            guard let self = self else {
                return
            }
            
            show(state: state)
        }
    }
    
    private func configureCollectionView() {
        collectionView.register(ArtworkCollectionItemCell.self, forCellWithReuseIdentifier: ArtworkCollectionItemCell.identifier)
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate
    }
    
    private func setupCollectionViewCallbacks() {
        collectionViewDelegate.onIndexPathSelected = { [weak self] indexPath in
            guard let self = self else {
                return
            }
            
            let selectedArtworkItem = collectionViewDataSource.artworkItems[indexPath.row]
            guard case .loaded(let artworkResource, _) = selectedArtworkItem.state else {
                return
            }
            
            onArtworkSelected?(artworkResource)
        }
        
        collectionViewDelegate.onScrolledToBottom = { [weak self] in
            guard let self = self else {
                return
            }
            
            viewModel.fetchMoreArtworkItems()
        }
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        setupCollectionViewLayout()
        setupLoadingIndicatorViewLayout()
        setupEmptyLabelLayout()
        setupErrorViewLayout()
    }
    
    private func setupCollectionViewLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupLoadingIndicatorViewLayout() {
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicatorView)
        NSLayoutConstraint.activate([
            loadingIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupEmptyLabelLayout() {
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emptyLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupErrorViewLayout() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.widthAnchor.constraint(equalToConstant: 300),
            errorView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    // MARK: - State
    
    private func show(state: ArtworkCollectionViewState) {
        let visibility = ArtworkCollectionViewVisibilityMapper.mapVisibility(state: state)
        setVisibility(visibility)
    }
    
    private func setVisibility(_ visibility: ArtworkCollectionViewVisibility) {
        collectionView.isHidden = visibility.isCollectionViewHidden
        collectionViewDataSource.artworkItems = visibility.items
        collectionViewDelegate.artworkItems = visibility.items
        collectionView.reloadData()
        loadingIndicatorView.isHidden = visibility.isLoadingIndicatorHidden
        emptyLabel.isHidden = visibility.isEmptyLabelHidden
        errorView.isHidden = visibility.isErrorViewHidden
        errorView.show(message: visibility.errorTitle)
    }
}
