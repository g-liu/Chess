//
//  ChessBoardViewController.swift
//  Chess
//
//  Created by Geoffrey Liu on 3/26/22.
//

import UIKit
import SwiftChess

final class ChessBoardViewController: UIViewController {
  
  private var game: Game {
    let player = Human(color: .white)
    let ai = AIPlayer(color: .black, configuration: .init(difficulty: .easy))
    
    return .init(firstPlayer: player, secondPlayer: ai)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    let board = ChessBoardView().autolayoutEnabled
    board.delegate = self
    view.addSubview(board)
    board.pin(to: view.safeAreaLayoutGuide)
  }


}

extension ChessBoardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    game.board.squares.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let square = collectionView.dequeueReusableCell(withReuseIdentifier: ChessBoardSquare.identifier, for: indexPath) as? ChessBoardSquare else { return .init() }
    
    square.configure(serialOrder: indexPath.row)
    
    // TODO: hacky as FUCK maybe put this in the square itself LMAO
    let squareInfo = game.board.squares[indexPath.row]
    if let piece = squareInfo.piece {
      addPieceImage(type: piece.type, color: piece.color, to: square)
       
    }
    return square
  }
  
  private func addPieceImage(type pieceType: Piece.PieceType, color: Color, to square: ChessBoardSquare) {
    let pieceView: ChessPiece
    switch pieceType {
        
      case .pawn:
        pieceView = ChessPiecePawn(color: color).autolayoutEnabled
      case .rook:
        pieceView = ChessPieceRook(color: color).autolayoutEnabled
      case .knight:
        pieceView = ChessPieceKnight(color: color).autolayoutEnabled
      case .bishop:
        pieceView = ChessPieceBishop(color: color).autolayoutEnabled
      case .queen:
        pieceView = ChessPieceQueen(color: color).autolayoutEnabled
      case .king:
        pieceView = ChessPieceKing(color: color).autolayoutEnabled
    }
    
    square.addSubview(pieceView)
    pieceView.pin(to: square)
  }
}



// TODO: just make this a collection view???
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
      collectionView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
      collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor),
      ])
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
      return serialOrder.isEven ? .systemGray2 : .systemCyan
    } else {
      return serialOrder.isEven ? .systemCyan : .systemGray2
    }
  }
}
