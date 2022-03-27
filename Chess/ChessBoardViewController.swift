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
    
    view.backgroundColor = .systemBackground
    
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
    
    let transposedCoordinates = 63 - (8*(indexPath.row/8)) - (7-(indexPath.row%8))
    let squareInfo = game.board.squares[transposedCoordinates]
    square.configure(serialOrder: indexPath.row, piece: squareInfo.piece)
    
    return square
  }
}
