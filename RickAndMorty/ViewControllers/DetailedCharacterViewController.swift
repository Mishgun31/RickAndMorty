//
//  DetailedCharacterViewController.swift
//  RickAndMorty
//
//  Created by Михаил Мезенцев on 21.11.2021.
//

import UIKit

class DetailedCharacterViewController: UIViewController {

    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    var character: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewAppearance()
        setImage()
        setLabels()
    }
    
    private func setImage() {
        Networker.shared.fetchImage(with: character.image ?? "") { imageData in
            self.characterImageView.image = UIImage(data: imageData)
        }
    }
    
    private func setLabels() {
        characterNameLabel.text = character.name
        characterDescriptionLabel.text = character.description
    }
    
    private func setupViewAppearance() {
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
        characterNameLabel.textColor = .white
        characterDescriptionLabel.textColor = .white
        
        let cornerRadius: CGFloat = 20
        let backgroundLayer = backgroundView.layer
        
        characterImageView.layer.cornerRadius = cornerRadius
        
        backgroundLayer.cornerRadius = cornerRadius
        backgroundLayer.borderColor = #colorLiteral(red: 0, green: 0.7659460902, blue: 0, alpha: 1)
        backgroundLayer.borderWidth = 4
        
        backgroundLayer.shadowRadius = 10
        backgroundLayer.shadowColor = #colorLiteral(red: 0.6937051415, green: 1, blue: 0, alpha: 1)
        backgroundLayer.shadowOpacity = 0.5
        backgroundLayer.shadowOffset = CGSize(width: 5, height: 5)
    }
}
