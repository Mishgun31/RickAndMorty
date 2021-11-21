//
//  CharacterCollectionViewController.swift
//  RickAndMorty
//
//  Created by Михаил Мезенцев on 15.11.2021.
//

import UIKit

class CharacterCollectionViewController: UICollectionViewController {
    
    private let itemsPerRow: CGFloat = 2
    private let edgeInsets = UIEdgeInsets(top: 20,
                                          left: 20,
                                          bottom: 20,
                                          right: 20)
    
    private var rickAndMorty: RickAndMorty?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewApperance()
        fetchData(with: URLQuery.rickAndMortyAPI.rawValue)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rickAndMorty?.results?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: "CharacterCell",
                    for: indexPath
                ) as? CharacterCell else { return UICollectionViewCell() }
        
        if let character = rickAndMorty?.results?[indexPath.item] {
            cell.configure(with: character)
        }
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    // MARK: Private methods
    
    private func fetchData(with url: String) {
        Networker.shared.fetchData(with: url) { rickAndMorty in
            self.rickAndMorty = rickAndMorty
            self.collectionView.reloadData()
        }
    }
    
    private func setupViewApperance() {
        collectionView.backgroundColor = .clear
        
        navigationItem.title = "Rick And Morty"
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.barStyle = .black
            navigationBar.largeTitleTextAttributes = [
                .foregroundColor: UIColor.white
            ]
            navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.white
            ]
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CharacterCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = edgeInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let itemsWidth = availableWidth / itemsPerRow
        return CGSize(width: itemsWidth, height: itemsWidth * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        edgeInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        edgeInsets.left
    }
}
