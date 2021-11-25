//
//  CharacterImageView.swift
//  RickAndMorty
//
//  Created by Михаил Мезенцев on 24.11.2021.
//

import UIKit

class CharacterImageView: UIImageView {
    
    func fetchImage(with url: String) {
        image = UIImage(named: "RickAndMorty")
        guard let url = URL(string: url) else { return }
        
        if let cachedData = getFromCache(with: url) {
            image = UIImage(data: cachedData)
            return
        }
        
        Networker.shared.fetchImage(with: url) { data, response in
            self.image = UIImage(data: data)
            self.saveToCache(data, and: response)
        }
    }
    
    private func saveToCache(_ data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func getFromCache(with url: URL) -> Data? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return cachedResponse.data
        }
        return nil
    }
}

class CharatcterCellImageView: CharacterImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.layer.frame.width / 2
    }
}
