//
//  ChessBoardViewController.swift
//  Chess
//
//  Created by Geoffrey Liu on 3/26/22.
//

import UIKit

final class ChessBoardViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    let board = ChessBoardView().autolayoutEnabled
    view.addSubview(board)
    board.pin(to: view.safeAreaLayoutGuide)
  }


}

// TODO: just make this a collection view???
final class ChessBoardView: UIView {
  private lazy var collectionViewLayout: UICollectionViewCompositionalLayout = {
    let itemLayout = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
    
    let groupSize = NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0), heightDimension: .absolute(50.0))
    let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: itemLayout, count: 8)
    
    let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
    
    return .init(section: sectionLayout)
  }()
  
  private lazy var collectionView: UICollectionView = {
    let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).autolayoutEnabled
    view.register(ChessBoardSquare.self, forCellWithReuseIdentifier: ChessBoardSquare.identifier)
    
    view.delegate = self
    view.dataSource = self
    
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    addSubview(collectionView)
    collectionView.pin(to: safeAreaLayoutGuide)
  }
}

extension ChessBoardView: UICollectionViewDataSource, UICollectionViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    64
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let square = collectionView.dequeueReusableCell(withReuseIdentifier: ChessBoardSquare.identifier, for: indexPath) as? ChessBoardSquare else { return .init() }
    
    square.configure(serialOrder: indexPath.row)
    return square
  }
}

final class ChessBoardSquare: UICollectionViewCell {
  static let identifier = "ChessBoardSquare"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    
  }
  
  func configure(serialOrder: Int) {
    backgroundColor = getColor(serialOrder: serialOrder)
  }
  
  private func getColor(serialOrder: Int) -> UIColor {
    if (serialOrder / 8).isEven {
      return serialOrder.isEven ? .systemGray6 : .systemCyan
    } else {
      return serialOrder.isEven ? .systemCyan : .systemGray6
    }
  }
}
