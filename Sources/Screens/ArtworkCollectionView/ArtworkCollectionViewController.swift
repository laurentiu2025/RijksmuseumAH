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
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return collectionView
    }()
    
    private let collectionViewDelegate: ArtworkCollectionViewDelegate
    private let collectionViewDataSource: ArtworkCollectionViewDataSource
    private var viewModel: ArtworkCollectionViewModeling
    
    typealias ArtworkSelectionHandler = (ArtworkViewData) -> Void
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
        let interItemSpacing: CGFloat = collectionViewLayout.minimumInteritemSpacing
        let totalSpacing = interItemSpacing + padding
        
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
            guard case .loaded(let artworkData, _) = selectedArtworkItem.state else {
                return
            }
            
            onArtworkSelected?(artworkData)
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
    
    // MARK: - State
    
    private func show(state: ArtworkCollectionViewState) {
        switch state {
        case .idle,
                .loadingInitial:
            // TODO: Add handling
            break
        case .initialLoadFailed(let error):
            // TODO: Add handling
            print(error.localizedDescription)
        case .loaded(let items, _),
                .loadingMore(let items, _):
            collectionViewDataSource.artworkItems = items
            collectionViewDelegate.artworkItems = items
            collectionView.reloadData()
        case .loadMoreFailed(_, _, let error):
            // TODO: Add handling
            print(error.localizedDescription)
        }
    }
}
