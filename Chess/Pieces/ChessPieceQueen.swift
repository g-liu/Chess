//
//  ChessPieceQueen.swift
//  Chess
//
//  Created by Geoffrey Liu on 3/26/22.
//

import SwiftChess
import UIKit


class ChessPiece: UIView {
  var associatedLetter: String { "x" }
  private let associatedColor: String
  
  init(color: Color) {
    self.associatedColor = {
      switch color {
        case .white:
          return "l"
        case .black:
          return "d"
      }
    }()
    super.init(frame: .zero)
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func render() {
    let image = UIImage(named: "Chess_\(associatedLetter)\(associatedColor)t45")
    let imageView = UIImageView(image: image).autolayoutEnabled
    
    addSubview(imageView)
    imageView.pin(to: self)
  }
}

final class ChessPieceQueen: ChessPiece {
  override var associatedLetter: String { "q" }
}

final class ChessPieceKing: ChessPiece {
  override var associatedLetter: String { "k" }
}

final class ChessPieceRook: ChessPiece {
  override var associatedLetter: String { "r" }
}

final class ChessPieceBishop: ChessPiece {
  override var associatedLetter: String { "b" }
}

final class ChessPieceKnight: ChessPiece {
  override var associatedLetter: String { "n" }
}

final class ChessPiecePawn: ChessPiece {
  override var associatedLetter: String { "p" }
}
