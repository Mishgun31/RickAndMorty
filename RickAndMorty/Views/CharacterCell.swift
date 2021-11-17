//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Михаил Мезенцев on 15.11.2021.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    func configure(with data: Character) {
        characterImageView.image = UIImage(named: "SwiftImage")
        characterNameLabel.text = data.name
    }
}
