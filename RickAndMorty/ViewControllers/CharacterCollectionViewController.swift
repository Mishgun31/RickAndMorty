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
    
    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailedCharacterVC = segue.destination as?
                DetailedCharacterViewController else { return }
        guard let itemNumber = sender as? Int else { return }
        detailedCharacterVC.character = rickAndMorty?.results?[itemNumber]
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        rickAndMorty?.results?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailedCharacter", sender: indexPath.item)
    }
    
    // MARK: Private methods
    
    @objc private func changePage(_ sender: UIBarButtonItem) {
        let prevPageQuery = rickAndMorty?.info?.prev
        let nextPageQuery = rickAndMorty?.info?.next
        
        if sender.title == "Next" {
            fetchData(with: nextPageQuery ?? "")
        } else {
            fetchData(with: prevPageQuery ?? "")
        }
    }
    
    private func fetchData(with url: String) {
        Networker.shared.fetchData(with: url) { rickAndMorty in
            self.rickAndMorty = rickAndMorty
            self.collectionView.reloadData()
            self.setPageButtonsAccessibility(with: rickAndMorty.info)
        }
    }
    
    private func setupViewApperance() {
        collectionView.backgroundColor = .clear
        setupNavigationItem()
        setNavigationBarTitleColors()
    }
    
    private func setupNavigationItem() {
        let prevButton = UIBarButtonItem(
            title: "Previous",
            style: .plain,
            target: self,
            action: #selector(changePage)
        )
        let nextButton = UIBarButtonItem(
            title: "Next",
            style: .plain,
            target: self,
            action: #selector(changePage)
        )
        prevButton.tintColor = .white
        nextButton.tintColor = .white
        
        navigationItem.setLeftBarButton(prevButton, animated: false)
        navigationItem.setRightBarButton(nextButton, animated: false)
        navigationItem.title = "Rick And Morty"
    }
    
    private func setNavigationBarTitleColors() {
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
    
    private func setPageButtonsAccessibility(with object: Info?) {
        guard let info = object else { return }
        switchAccessibility(for: navigationItem.leftBarButtonItem, with: info.prev)
        switchAccessibility(for: navigationItem.rightBarButtonItem, with: info.next)
    }
    
    private func switchAccessibility(for button: UIBarButtonItem?, with object: String?) {
        object == nil
        ? (button?.isEnabled = false)
        : (button?.isEnabled = true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CharacterCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = edgeInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let itemsWidth = availableWidth / itemsPerRow
        return CGSize(width: itemsWidth, height: itemsWidth * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        edgeInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        edgeInsets.left
    }
}
