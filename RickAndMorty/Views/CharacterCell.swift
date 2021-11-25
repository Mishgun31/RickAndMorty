//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Михаил Мезенцев on 15.11.2021.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImageView: CharatcterCellImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    private let cornerRadius: CGFloat = 10
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }
    
    func configure(with data: Character) {
        characterNameLabel.text = data.name
        characterImageView.fetchImage(with: data.image ?? "")
        setCellAppearance()
    }
    
    private func setCellAppearance() {
        characterNameLabel.textColor = .white
        
        backgroundColor = .black
        
        layer.cornerRadius = cornerRadius
        layer.borderColor = #colorLiteral(red: 0, green: 0.7659460902, blue: 0, alpha: 1)
        layer.borderWidth = 4
        
        layer.shadowRadius = cornerRadius
        layer.shadowColor = #colorLiteral(red: 0.6937051415, green: 1, blue: 0, alpha: 1)
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 5, height: 5)
        clipsToBounds = false
    }
}
