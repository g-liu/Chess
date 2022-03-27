//
//  ChessBoardSquare.swift
//  Chess
//
//  Created by Geoffrey Liu on 3/27/22.
//

import UIKit
import SwiftChess

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
  
  func configure(serialOrder: Int, piece: Piece?) {
    backgroundColor = getColor(serialOrder: serialOrder)
    
    if let piece = piece {
      addPieceImage(piece)
    }
  }
  
  private func getColor(serialOrder: Int) -> UIColor {
    if (serialOrder / 8).isEven {
      return serialOrder.isEven ? .systemBackground : .systemMint
    } else {
      return serialOrder.isEven ? .systemMint : .systemBackground
    }
  }
  
  private func addPieceImage(_ piece: Piece) {
    let pieceView: ChessPiece
    switch piece.type {
        
      case .pawn:
        pieceView = ChessPiecePawn(color: piece.color).autolayoutEnabled
      case .rook:
        pieceView = ChessPieceRook(color: piece.color).autolayoutEnabled
      case .knight:
        pieceView = ChessPieceKnight(color: piece.color).autolayoutEnabled
      case .bishop:
        pieceView = ChessPieceBishop(color: piece.color).autolayoutEnabled
      case .queen:
        pieceView = ChessPieceQueen(color: piece.color).autolayoutEnabled
      case .king:
        pieceView = ChessPieceKing(color: piece.color).autolayoutEnabled
    }
    
    addSubview(pieceView)
    pieceView.pin(to: self, margins: .init(top: 2, left: 2, bottom: 2, right: 2))
  }
  
  private func addSquareNumber(_ number: Int, to square: ChessBoardSquare) {
    let label = UILabel().autolayoutEnabled
    label.text = "\(number)"
    label.textAlignment = .center
    label.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
    label.backgroundColor = .init(white: 1, alpha: 0.75)
    
    addSubview(label)
    label.pin(to: self)
  }
}

