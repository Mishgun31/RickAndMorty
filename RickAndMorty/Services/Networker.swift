//
//  Networker.swift
//  RickAndMorty
//
//  Created by Михаил Мезенцев on 17.11.2021.
//

import Foundation

class Networker {
    
    static let shared = Networker()
    
    private init() {}
    
    func fetchData(with url: String, comletion: @escaping (RickAndMorty) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            print(response)
            
            do {
                let rickAndMorty = try JSONDecoder().decode(RickAndMorty.self, from: data)
                DispatchQueue.main.async {
                    comletion(rickAndMorty)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchImage(with url: URL, comletion: @escaping (Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            guard url == response.url else { return }
            
            DispatchQueue.main.async {
                comletion(data, response)
            }
        }.resume()
    }
}
