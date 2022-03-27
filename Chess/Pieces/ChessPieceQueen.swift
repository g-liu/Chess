//
//  ChessPieceQueen.swift
//  Chess
//
//  Created by Geoffrey Liu on 3/26/22.
//

import SwiftChess
import UIKit

final class ChessPieceQueen: UIView {
  private let associatedLetter = "q"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func render() {
    let image = UIImage(named: "Chess_\(associatedLetter)lt45")
    let imageView = UIImageView(image: image).autolayoutEnabled
    
    addSubview(imageView)
    imageView.pin(to: self)
  }
}
