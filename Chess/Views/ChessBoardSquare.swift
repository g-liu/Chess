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
    
    let dragGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didDragPiece))
    pieceView.addGestureRecognizer(dragGestureRecognizer)
  }
  
  @objc func didDragPiece(_ gestureRecognizer: UIPanGestureRecognizer) {
    guard let pieceView = gestureRecognizer.view as? ChessPiece else {
      return
    }
    
//    if gestureRecognizer.state == .cancelled ||
//        gestureRecognizer.state == .ended ||
//        gestureRecognizer.state == .failed {
//      pieceView.transform = .init(translationX: 0, y: 0)
//      return
//    }
//
//
//    let pieceCenter = pieceView.center
//    let gestureCenter = gestureRecognizer.location(in: pieceView)
////    print("Center is now \(gestureCenter) @ \(pieceCenter) for \(pieceView)")
//
//    let transformCoordinates = gestureCenter - pieceCenter
//
//    pieceView.transform = .init(translationX: transformCoordinates.x, y: transformCoordinates.y)
    
    // TODO: Lmao this code works better
    // But gotta fix the snapping....
    // need delegate probably
    // sigh
    
    let location = gestureRecognizer.location(in: self)
    pieceView.center = location
    
    if gestureRecognizer.state == .ended {
        if pieceView.frame.midX >= layer.frame.width / 2 {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
              pieceView.center.x = self.layer.frame.width - 40
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                pieceView.center.x = 40
            }, completion: nil)
        }
    }
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

