//
//  ChessBoardView.swift
//  Chess
//
//  Created by Geoffrey Liu on 3/27/22.
//

import UIKit

final class ChessBoardView: UIView {
  private var maxSquareSize: CGFloat {
    let screenSize = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
    
    return screenSize / 8.0
  }
  
  private lazy var collectionViewLayout: UICollectionViewCompositionalLayout = {
    let itemLayout = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(maxSquareSize), heightDimension: .absolute(maxSquareSize)))
    
    let groupSize = NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0), heightDimension: .fractionalHeight(1/8.0))
    let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: itemLayout, count: 8)
    
    let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
    
    return .init(section: sectionLayout)
  }()
  
  private lazy var collectionView: UICollectionView = {
    let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).autolayoutEnabled
    view.register(ChessBoardSquare.self, forCellWithReuseIdentifier: ChessBoardSquare.identifier)
    
    view.layer.borderWidth = 3
    view.layer.borderColor = UIColor.systemMint.cgColor
    
    view.isScrollEnabled = false
    
    return view
  }()
  
  weak var delegate: (UICollectionViewDelegate & UICollectionViewDataSource)? {
    didSet {
      collectionView.delegate = delegate
      collectionView.dataSource = delegate
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      collectionView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
      
      // TODO: account for landscape
      collectionView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -16),
      collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor),
      ])
  }
}

